@isTest
private class EmailScrubberControllerTest {

    // ─────────────────────────────────────────────
    // Helpers
    // ─────────────────────────────────────────────

    private static Email_Scrubber_Config__mdt mockConfig(
        String label, String objectName, String fieldName
    ) {
        Email_Scrubber_Config__mdt cfg = new Email_Scrubber_Config__mdt();
        cfg.Label                     = label;
        cfg.Object_API_Name__c        = objectName;
        cfg.Email_Field_API_Name__c   = fieldName;
        cfg.Is_Active__c              = true;
        return cfg;
    }

    private static void injectConfigs(List<Email_Scrubber_Config__mdt> configs) {
        EmailScrubberController.testConfigs = configs;
        EmailScrubberBatch.testConfigs      = configs;
    }

    // ─────────────────────────────────────────────
    // isSandbox
    // ─────────────────────────────────────────────

    @isTest
    static void testIsSandboxReturnsBoolean() {
        Boolean result = EmailScrubberController.isSandbox();
        System.assertNotEquals(null, result, 'isSandbox should return a non-null boolean');
    }

    // ─────────────────────────────────────────────
    // getActiveConfigs
    // ─────────────────────────────────────────────

    @isTest
    static void testGetActiveConfigsReturnsExpectedFields() {
        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email'),
            mockConfig('Lead - Email',    'Lead',    'Email')
        });

        List<Map<String, String>> result = EmailScrubberController.getActiveConfigs();

        System.assertEquals(2, result.size(), 'Should return 2 active configs');
        System.assertEquals('Contact',         result[0].get('object'));
        System.assertEquals('Email',           result[0].get('field'));
        System.assertEquals('Contact - Email', result[0].get('label'));
        System.assertEquals('Lead',            result[1].get('object'));
        System.assertEquals('Email',           result[1].get('field'));
    }

    @isTest
    static void testGetActiveConfigsReturnsEmptyWhenNoneConfigured() {
        injectConfigs(new List<Email_Scrubber_Config__mdt>());

        List<Map<String, String>> result = EmailScrubberController.getActiveConfigs();

        System.assertEquals(0, result.size(), 'Should return empty list when no configs exist');
    }

    // ─────────────────────────────────────────────
    // getAllConfigs
    // ─────────────────────────────────────────────

    @isTest
    static void testGetAllConfigsReturnsAllRecords() {
        Email_Scrubber_Config__mdt inactive = mockConfig('Lead - PersonEmail', 'Lead', 'PersonEmail');
        inactive.Is_Active__c = false;

        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email'),
            inactive
        });

        List<Map<String, Object>> result = EmailScrubberController.getAllConfigs();

        System.assertEquals(2, result.size(), 'getAllConfigs should return all records regardless of active flag');
        System.assertEquals('Contact - Email', result[0].get('label'));
        System.assertEquals('Contact',         result[0].get('object'));
        System.assertEquals('Email',           result[0].get('field'));
        System.assertEquals(true,              result[0].get('isActive'));
        System.assertEquals('Lead - PersonEmail', result[1].get('label'));
        System.assertEquals(false,                result[1].get('isActive'));
    }

    @isTest
    static void testGetAllConfigsReturnsEmptyWhenNoneConfigured() {
        injectConfigs(new List<Email_Scrubber_Config__mdt>());

        List<Map<String, Object>> result = EmailScrubberController.getAllConfigs();

        System.assertEquals(0, result.size(), 'Should return empty list when no configs exist');
    }

    // ─────────────────────────────────────────────
    // getObjects
    // ─────────────────────────────────────────────

    @isTest
    static void testGetObjectsWithSearchTermReturnsMatches() {
        List<Map<String, String>> result = EmailScrubberController.getObjects('Contact');

        System.assert(!result.isEmpty(), 'getObjects("Contact") should return at least one match');
        System.assertNotEquals(null, result[0].get('label'), 'Each entry should have a label');
        System.assertNotEquals(null, result[0].get('value'), 'Each entry should have a value');
    }

    @isTest
    static void testGetObjectsLabelsContainApiName() {
        List<Map<String, String>> result = EmailScrubberController.getObjects('Contact');

        for (Map<String, String> entry : result) {
            System.assert(
                entry.get('label').contains('(') && entry.get('label').contains(')'),
                'Label should include API name in parentheses: ' + entry.get('label')
            );
        }
    }

    @isTest
    static void testGetObjectsWithBlankSearchReturnsResults() {
        List<Map<String, String>> result = EmailScrubberController.getObjects('');

        System.assert(!result.isEmpty(), 'getObjects with blank search should return results');
    }

    // ─────────────────────────────────────────────
    // getEmailFields
    // ─────────────────────────────────────────────

    @isTest
    static void testGetEmailFieldsForContact() {
        List<Map<String, String>> result = EmailScrubberController.getEmailFields('Contact');

        System.assert(!result.isEmpty(), 'Contact should have at least one email field');

        Boolean foundEmail = false;
        for (Map<String, String> entry : result) {
            if (entry.get('value') == 'Email') {
                foundEmail = true;
            }
        }
        System.assert(foundEmail, 'Contact Email field should be in results');
    }

    @isTest
    static void testGetEmailFieldsReturnsOnlyEmailTypeFields() {
        List<Map<String, String>> result = EmailScrubberController.getEmailFields('Contact');

        // All returned fields must be email-type — verified by cross-checking against describe
        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Contact.fields.getMap();
        for (Map<String, String> entry : result) {
            String apiName = entry.get('value');
            Schema.DisplayType fieldType = fields.get(apiName.toLowerCase()).getDescribe().getType();
            System.assertEquals(
                Schema.DisplayType.EMAIL, fieldType,
                'Field ' + apiName + ' should be of type EMAIL'
            );
        }
    }

    @isTest
    static void testGetEmailFieldsThrowsForInvalidObject() {
        try {
            EmailScrubberController.getEmailFields('NonExistentObject__c');
            System.assert(false, 'Expected AuraHandledException for invalid object');
        } catch (AuraHandledException e) {
            System.assertNotEquals(null, e.getMessage(), 'Exception message should not be null');
        }
    }

    // ─────────────────────────────────────────────
    // saveConfig / buildMetadata
    // ─────────────────────────────────────────────

    @isTest
    static void testBuildMetadataNewRecord() {
        Metadata.CustomMetadata md = EmailScrubberController.buildMetadata(
            'Contact_Email', 'Contact - Email', 'Contact', 'Email', true
        );

        System.assertEquals('Email_Scrubber_Config__mdt.Contact_Email', md.fullName,
            'fullName should be prefixed with metadata type');
        System.assertEquals('Contact - Email', md.label, 'label should match');

        Map<String, Object> fieldValues = new Map<String, Object>();
        for (Metadata.CustomMetadataValue v : md.values) {
            fieldValues.put(v.field, v.value);
        }
        System.assertEquals('Contact', fieldValues.get('Object_API_Name__c'),
            'Object API name should be Contact');
        System.assertEquals('Email', fieldValues.get('Email_Field_API_Name__c'),
            'Email field API name should be Email');
        System.assertEquals(true, fieldValues.get('Is_Active__c'),
            'Is_Active should be true');
    }

    @isTest
    static void testBuildMetadataInactiveRecord() {
        Metadata.CustomMetadata md = EmailScrubberController.buildMetadata(
            'Contact_Email', 'Contact - Email Updated', 'Contact', 'Email', false
        );

        System.assertEquals('Contact - Email Updated', md.label, 'label should reflect update');

        Map<String, Object> fieldValues = new Map<String, Object>();
        for (Metadata.CustomMetadataValue v : md.values) {
            fieldValues.put(v.field, v.value);
        }
        System.assertEquals(false, fieldValues.get('Is_Active__c'),
            'Is_Active should be false for inactive record');
    }

    // ─────────────────────────────────────────────
    // startScrub
    // ─────────────────────────────────────────────

    @isTest
    static void testStartScrubReturnsBatchJobId() {
        EmailScrubberController.bypassPermissionCheck = true;
        insert new Contact(LastName = 'BatchTest', Email = 'batch@example.com');

        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email')
        });

        Test.startTest();
        String jobId = EmailScrubberController.startScrub();
        Test.stopTest();

        System.assertNotEquals(null, jobId, 'Should return a valid batch job ID');
        System.assert(jobId.length() == 15 || jobId.length() == 18, 'Job ID should be a standard Salesforce ID');
    }

    @isTest
    static void testStartScrubThrowsWhenNoActiveConfigs() {
        EmailScrubberController.bypassPermissionCheck = true;
        injectConfigs(new List<Email_Scrubber_Config__mdt>());

        Test.startTest();
        try {
            EmailScrubberController.startScrub();
            System.assert(false, 'Expected AuraHandledException was not thrown');
        } catch (AuraHandledException e) {
            System.assertEquals(
                'No active Email Scrubber configurations found.',
                e.getMessage(),
                'Exception message should indicate no configs found'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testStartScrubActuallyScrubsEmails() {
        EmailScrubberController.bypassPermissionCheck = true;
        insert new Contact(LastName = 'ScrubTest', Email = 'scrub@example.com');

        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email')
        });

        Test.startTest();
        EmailScrubberController.startScrub();
        Test.stopTest();

        Contact result = [SELECT Email FROM Contact LIMIT 1];
        System.assertEquals('scrub@example.com.invalid', result.Email,
            'Email should have .invalid appended after batch runs');
    }

    // ─────────────────────────────────────────────
    // getJobStatus
    // ─────────────────────────────────────────────

    @isTest
    static void testGetJobStatusReturnsValidStatusMap() {
        EmailScrubberController.bypassPermissionCheck = true;
        insert new Contact(LastName = 'StatusTest', Email = 'status@example.com');

        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email')
        });

        Test.startTest();
        String jobId = EmailScrubberController.startScrub();
        Test.stopTest();

        Map<String, Object> status = EmailScrubberController.getJobStatus(jobId);

        System.assertNotEquals(null, status,                   'Status map should not be null');
        System.assertNotEquals(null, status.get('status'),    'Status field should be present');
        System.assertNotEquals(null, status.get('errors'),    'Errors field should be present');
        System.assertNotEquals(null, status.get('processed'), 'Processed field should be present');
        System.assertNotEquals(null, status.get('total'),     'Total field should be present');
    }

    @isTest
    static void testGetJobStatusShowsCompletedAfterBatch() {
        EmailScrubberController.bypassPermissionCheck = true;
        insert new Contact(LastName = 'CompletedTest', Email = 'done@example.com');

        injectConfigs(new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact - Email', 'Contact', 'Email')
        });

        Test.startTest();
        String jobId = EmailScrubberController.startScrub();
        Test.stopTest();

        Map<String, Object> status = EmailScrubberController.getJobStatus(jobId);
        System.assertEquals('Completed', status.get('status'),
            'Job should have Completed status after Test.stopTest()');
        System.assertEquals(0, status.get('errors'),
            'Should have zero errors on a clean run');
    }

    @isTest
    static void testGetJobStatusWithInvalidIdThrowsException() {
        try {
            EmailScrubberController.getJobStatus('000000000000000000');
            System.assert(false, 'Expected exception for invalid job ID');
        } catch (AuraHandledException e) {
            System.assert(
                e.getMessage().contains('Could not retrieve job status'),
                'Should throw an AuraHandledException with status message'
            );
        }
    }
}