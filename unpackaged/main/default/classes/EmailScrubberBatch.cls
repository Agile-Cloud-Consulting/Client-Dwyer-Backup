/**
 * Batch class that appends '.invalid' to email fields on configured SObjects.
 * Chains itself to process multiple object configurations sequentially.
 * Declared without sharing intentionally — scrubbing must process all records
 * regardless of the running user's row-level access.
 */
public without sharing class EmailScrubberBatch implements Database.Batchable<SObject>, Database.Stateful {

    private List<Email_Scrubber_Config__mdt> pendingConfigs;
    private Email_Scrubber_Config__mdt currentConfig;
    private static final String SUFFIX = '.invalid';

    // Allows test classes to inject mock configs without needing real CMT records
    @TestVisible
    private static List<Email_Scrubber_Config__mdt> testConfigs;

    /**
     * Constructs a batch job for the first config in the list.
     * Remaining configs are processed by chained batch executions.
     * @param configs List of active Email_Scrubber_Config__mdt records; must not be empty
     */
    public EmailScrubberBatch(List<Email_Scrubber_Config__mdt> configs) {
        if (configs == null || configs.isEmpty()) {
            throw new IllegalArgumentException('At least one config is required.');
        }
        this.pendingConfigs = configs.clone();
        this.currentConfig  = this.pendingConfigs.remove(0);
    }

    /**
     * Returns a query locator for all records on the current object config.
     * @param bc BatchableContext provided by the platform
     * @return QueryLocator for the current object
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, ' + currentConfig.Email_Field_API_Name__c
                     + ' FROM ' + currentConfig.Object_API_Name__c;
        return Database.getQueryLocator(query);
    }

    /**
     * Appends '.invalid' to each record's email field and updates with partial-failure support.
     * Failures are logged via ErrorLogger as a single batch-level entry rather than per-record.
     * @param bc BatchableContext provided by the platform
     * @param scope Records in the current batch chunk
     */
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        String fieldName = currentConfig.Email_Field_API_Name__c;
        List<SObject> toUpdate = new List<SObject>();

        for (SObject record : scope) {
            String val = (String) record.get(fieldName);
            if (String.isNotBlank(val) && !val.endsWith(SUFFIX)) {
                record.put(fieldName, val + SUFFIX);
                toUpdate.add(record);
            }
        }

        if (toUpdate.isEmpty()) return;

        List<Database.SaveResult> results = Database.update(toUpdate, false);

        List<String> failedSummaries = new List<String>();
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                List<String> msgs = new List<String>();
                for (Database.Error err : results[i].getErrors()) {
                    msgs.add(err.getMessage());
                }
                failedSummaries.add(toUpdate[i].Id + ': ' + String.join(msgs, '; '));
            }
        }

        if (!failedSummaries.isEmpty()) {
            ErrorLogger.log(
                'EmailScrubberBatch',
                'execute',
                failedSummaries.size() + ' record(s) failed to update on '
                    + currentConfig.Object_API_Name__c + ' | ' + String.join(failedSummaries, ' | '),
                null,
                null,
                'ERROR',
                'Apex'
            );
        }
    }

    /**
     * Chains the next batch run if more configs remain.
     * @param bc BatchableContext provided by the platform
     */
    public void finish(Database.BatchableContext bc) {
        if (!pendingConfigs.isEmpty()) {
            Database.executeBatch(new EmailScrubberBatch(pendingConfigs), 200);
        }
    }

    /**
     * Returns active configs — uses injected test data if present.
     * @return List of active Email_Scrubber_Config__mdt records
     */
    public static List<Email_Scrubber_Config__mdt> getActiveConfigs() {
        if (testConfigs != null) {
            return testConfigs;
        }
        return [
            SELECT Object_API_Name__c, Email_Field_API_Name__c
            FROM Email_Scrubber_Config__mdt
            WHERE Is_Active__c = TRUE
            ORDER BY Object_API_Name__c
        ];
    }
}