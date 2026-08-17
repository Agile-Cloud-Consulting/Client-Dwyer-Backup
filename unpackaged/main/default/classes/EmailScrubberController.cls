/**
 * AuraEnabled controller for the Email Scrubber Tool LWC.
 * Exposes methods to read/write Email_Scrubber_Config__mdt records,
 * kick off the scrubbing batch, and query job status.
 */
public with sharing class EmailScrubberController {

    @TestVisible
    private static List<Email_Scrubber_Config__mdt> testConfigs;

    // Set to true in tests to bypass FeatureManagement.checkPermission
    @TestVisible
    private static Boolean bypassPermissionCheck = false;

    /**
     * Returns true if the running org is a sandbox.
     * @return Boolean sandbox flag
     */
    @AuraEnabled(cacheable=true)
    public static Boolean isSandbox() {
        return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
    }

    /**
     * Returns all active Email Scrubber configurations.
     * @return List of maps with label, object, and field keys
     */
    @AuraEnabled
    public static List<Map<String, String>> getActiveConfigs() {
        List<Map<String, String>> result = new List<Map<String, String>>();
        for (Email_Scrubber_Config__mdt c : fetchConfigs()) {
            result.add(new Map<String, String>{
                'label'  => c.Label,
                'object' => c.Object_API_Name__c,
                'field'  => c.Email_Field_API_Name__c
            });
        }
        return result;
    }

    /**
     * Returns all Email Scrubber configurations regardless of active status.
     * @return List of maps with developerName, label, object, field, and isActive keys
     */
    @AuraEnabled
    public static List<Map<String, Object>> getAllConfigs() {
        List<Map<String, Object>> result = new List<Map<String, Object>>();
        List<Email_Scrubber_Config__mdt> configs = testConfigs != null
            ? testConfigs
            : [
                SELECT QualifiedApiName, Label, Object_API_Name__c, Email_Field_API_Name__c, Is_Active__c
                FROM Email_Scrubber_Config__mdt
                ORDER BY Object_API_Name__c
            ];

        for (Email_Scrubber_Config__mdt c : configs) {
            result.add(new Map<String, Object>{
                'developerName' => c.QualifiedApiName,
                'label'         => c.Label,
                'object'        => c.Object_API_Name__c,
                'field'         => c.Email_Field_API_Name__c,
                'isActive'      => c.Is_Active__c
            });
        }
        return result;
    }

    // EntityDefinition does not support queryMore() — LIMIT must stay <= 200.
    // searchTerm filters server-side so the fixed window always returns relevant results.
    /**
     * Returns queryable SObject types matching the search term.
     * @param searchTerm Partial label to filter by
     * @return List of maps with label and value (QualifiedApiName) keys
     */
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getObjects(String searchTerm) {
        String pattern = '%' + (String.isBlank(searchTerm) ? '' : searchTerm.trim()) + '%';
        List<Map<String, String>> result = new List<Map<String, String>>();
        for (EntityDefinition ed : [
            SELECT QualifiedApiName, Label
            FROM EntityDefinition
            WHERE IsQueryable = true
              AND IsDeprecatedAndHidden = false
              AND IsCustomSetting = false
              AND Label LIKE :pattern
            ORDER BY Label
            LIMIT 50
        ]) {
            result.add(new Map<String, String>{
                'label' => ed.Label + ' (' + ed.QualifiedApiName + ')',
                'value' => ed.QualifiedApiName
            });
        }
        return result;
    }

    /**
     * Returns email-type fields on the specified SObject.
     * @param objectApiName API name of the SObject to describe
     * @return List of maps with label and value (field API name) keys, sorted by label
     */
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getEmailFields(String objectApiName) {
        try {
            Schema.DescribeSObjectResult describe = Schema.describeSObjects(
                new List<String>{ objectApiName }
            )[0];

            Map<String, Schema.SObjectField> fieldMap = describe.fields.getMap();
            Map<String, String> labelToApi = new Map<String, String>();
            for (String fieldName : fieldMap.keySet()) {
                Schema.DescribeFieldResult field = fieldMap.get(fieldName).getDescribe();
                if (field.getType() == Schema.DisplayType.EMAIL) {
                    labelToApi.put(field.getLabel() + ' (' + field.getName() + ')', field.getName());
                }
            }

            List<String> labels = new List<String>(labelToApi.keySet());
            labels.sort();

            List<Map<String, String>> result = new List<Map<String, String>>();
            for (String label : labels) {
                result.add(new Map<String, String>{
                    'label' => label,
                    'value' => labelToApi.get(label)
                });
            }
            return result;
        } catch (Exception e) {
            ErrorLogger.log(e, 'EmailScrubberController', 'getEmailFields');
            AuraHandledException ahe = new AuraHandledException('Could not describe object: ' + objectApiName);
            ahe.setMessage('Could not describe object ' + objectApiName + ': ' + e.getMessage());
            throw ahe;
        }
    }

    /**
     * Deploys a new or updated Email_Scrubber_Config__mdt record via metadata API.
     * Requires the Run_Email_Scrubber custom permission.
     * @param developerName Developer name for the metadata record
     * @param label Display label
     * @param objectApiName SObject API name to scrub
     * @param emailFieldApiName Email field API name on the object
     * @param isActive Whether this configuration is active
     */
    @AuraEnabled
    public static void saveConfig(
        String developerName,
        String label,
        String objectApiName,
        String emailFieldApiName,
        Boolean isActive
    ) {
        if (!bypassPermissionCheck && !FeatureManagement.checkPermission('Run_Email_Scrubber')) {
            AuraHandledException ex = new AuraHandledException('You do not have permission to run this tool.');
            ex.setMessage('You do not have permission to run this tool.');
            throw ex;
        }

        Metadata.DeployContainer container = new Metadata.DeployContainer();
        container.addMetadata(buildMetadata(developerName, label, objectApiName, emailFieldApiName, isActive));

        if (!Test.isRunningTest()) {
            Metadata.Operations.enqueueDeployment(container, new DeployCallback());
        }
    }

    /**
     * Enqueues the Email Scrubber batch job for all active configurations.
     * Requires the Run_Email_Scrubber custom permission.
     * @return The AsyncApexJob ID of the enqueued batch
     */
    @AuraEnabled
    public static String startScrub() {
        if (!bypassPermissionCheck && !FeatureManagement.checkPermission('Run_Email_Scrubber')) {
            AuraHandledException ex = new AuraHandledException('You do not have permission to run this tool.');
            ex.setMessage('You do not have permission to run this tool.');
            throw ex;
        }

        if (KillSwitchHelper.isAutomationDisabled('Email_Scrubber')) {
            AuraHandledException ex = new AuraHandledException('Email Scrubber is currently disabled via the kill switch.');
            ex.setMessage('Email Scrubber is currently disabled via the kill switch.');
            throw ex;
        }

        List<Email_Scrubber_Config__mdt> configs = fetchConfigs();

        if (configs.isEmpty()) {
            AuraHandledException ex = new AuraHandledException('No active Email Scrubber configurations found.');
            ex.setMessage('No active Email Scrubber configurations found.');
            throw ex;
        }

        return Database.executeBatch(new EmailScrubberBatch(configs), 200);
    }

    /**
     * Returns the current status of an Apex batch job.
     * @param jobId The AsyncApexJob ID to query
     * @return Map with status, errors, processed, total, and extendedStatus keys
     */
    @AuraEnabled
    public static Map<String, Object> getJobStatus(String jobId) {
        try {
            AsyncApexJob job = [
                SELECT Status, NumberOfErrors, JobItemsProcessed,
                       TotalJobItems, ExtendedStatus
                FROM AsyncApexJob
                WHERE Id = :jobId
                LIMIT 1
            ];

            return new Map<String, Object>{
                'status'         => job.Status,
                'errors'         => job.NumberOfErrors,
                'processed'      => job.JobItemsProcessed,
                'total'          => job.TotalJobItems,
                'extendedStatus' => job.ExtendedStatus
            };
        } catch (Exception e) {
            ErrorLogger.log(e, 'EmailScrubberController', 'getJobStatus');
            AuraHandledException ahe = new AuraHandledException('Could not retrieve job status.');
            ahe.setMessage('Could not retrieve job status: ' + e.getMessage());
            throw ahe;
        }
    }

    @TestVisible
    private static Metadata.CustomMetadata buildMetadata(
        String developerName,
        String label,
        String objectApiName,
        String emailFieldApiName,
        Boolean isActive
    ) {
        Metadata.CustomMetadata md = new Metadata.CustomMetadata();
        md.fullName = 'Email_Scrubber_Config__mdt.' + developerName;
        md.label    = label;

        Metadata.CustomMetadataValue objVal = new Metadata.CustomMetadataValue();
        objVal.field = 'Object_API_Name__c';
        objVal.value = objectApiName;
        md.values.add(objVal);

        Metadata.CustomMetadataValue fieldVal = new Metadata.CustomMetadataValue();
        fieldVal.field = 'Email_Field_API_Name__c';
        fieldVal.value = emailFieldApiName;
        md.values.add(fieldVal);

        Metadata.CustomMetadataValue activeVal = new Metadata.CustomMetadataValue();
        activeVal.field = 'Is_Active__c';
        activeVal.value = isActive;
        md.values.add(activeVal);

        return md;
    }

    private static List<Email_Scrubber_Config__mdt> fetchConfigs() {
        if (testConfigs != null) {
            return testConfigs;
        }
        return [
            SELECT Label, Object_API_Name__c, Email_Field_API_Name__c
            FROM Email_Scrubber_Config__mdt
            WHERE Is_Active__c = TRUE
            ORDER BY Object_API_Name__c
        ];
    }

    private class DeployCallback implements Metadata.DeployCallback {
        public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
            if (result.status != Metadata.DeployStatus.Succeeded) {
                ErrorLogger.log(
                    'EmailScrubberController',
                    'DeployCallback.handleResult',
                    'Metadata deployment failed: ' + result.errorMessage,
                    null,
                    null,
                    'ERROR',
                    'Apex'
                );
            }
        }
    }
}