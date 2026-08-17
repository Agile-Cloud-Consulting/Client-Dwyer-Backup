@isTest
private class EmailScrubberBatchTest {

    // ─────────────────────────────────────────────
    // Helpers
    // ─────────────────────────────────────────────

    private static Email_Scrubber_Config__mdt mockConfig(String objectName, String fieldName) {
        Email_Scrubber_Config__mdt cfg = new Email_Scrubber_Config__mdt();
        cfg.Object_API_Name__c    = objectName;
        cfg.Email_Field_API_Name__c = fieldName;
        return cfg;
    }

    private static List<Contact> createContacts(List<String> emails) {
        List<Contact> contacts = new List<Contact>();
        for (String email : emails) {
            contacts.add(new Contact(LastName = 'Test_' + email, Email = email));
        }
        insert contacts;
        return contacts;
    }

    private static List<Lead> createLeads(List<String> emails) {
        List<Lead> leads = new List<Lead>();
        for (String email : emails) {
            leads.add(new Lead(
                LastName  = 'Test_' + email,
                FirstName = 'Lead',
                Company   = 'TestCo',
                Email     = email
            ));
        }
        insert leads;
        return leads;
    }

    // ─────────────────────────────────────────────
    // Tests
    // ─────────────────────────────────────────────

    @isTest
    static void testScrubsContactEmailOnInsert() {
        createContacts(new List<String>{ 'alice@example.com', 'bob@example.com' });

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email')
        };

        Test.startTest();
        Database.executeBatch(new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200);
        Test.stopTest();

        for (Contact c : [SELECT Email FROM Contact]) {
            System.assert(c.Email.endsWith('.invalid'),
                'Expected .invalid suffix but got: ' + c.Email);
        }
    }

    @isTest
    static void testDoesNotDoubleSuffixEmail() {
        createContacts(new List<String>{ 'already@example.com.invalid' });

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email')
        };

        Test.startTest();
        Database.executeBatch(new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200);
        Test.stopTest();

        Contact result = [SELECT Email FROM Contact LIMIT 1];
        System.assertEquals('already@example.com.invalid', result.Email,
            '.invalid should not be appended twice');
    }

    @isTest
    static void testSkipsBlankEmailField() {
        Contact c = new Contact(LastName = 'NoEmail');
        insert c;

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email')
        };

        Test.startTest();
        Database.executeBatch(new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200);
        Test.stopTest();

        Contact result = [SELECT Email FROM Contact WHERE Id = :c.Id];
        System.assertEquals(null, result.Email, 'Null email should remain null');
    }

    @isTest
    static void testScrubsLeadEmail() {
        createLeads(new List<String>{ 'lead@example.com' });

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Lead', 'Email')
        };

        Test.startTest();
        Database.executeBatch(new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200);
        Test.stopTest();

        Lead result = [SELECT Email FROM Lead LIMIT 1];
        System.assertEquals('lead@example.com.invalid', result.Email,
            'Lead email should have .invalid suffix');
    }

    @isTest
    static void testChainsAcrossMultipleObjects() {
        createContacts(new List<String>{ 'contact@example.com' });
        createLeads(new List<String>{ 'lead@example.com' });

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email'),
            mockConfig('Lead',    'Email')
        };

        Test.startTest();
        // Only pass first config — batch chains itself for the rest
        Database.executeBatch(
            new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200
        );
        Test.stopTest();

        Contact c = [SELECT Email FROM Contact LIMIT 1];
        System.assert(c.Email.endsWith('.invalid'), 'Contact email should be scrubbed');

        // Note: chained batch runs after Test.stopTest() in the same test context
        Lead l = [SELECT Email FROM Lead LIMIT 1];
        System.assert(l.Email.endsWith('.invalid'), 'Lead email should be scrubbed');
    }

    @isTest
    static void testLargeBatchBulkSafety() {
        List<String> emails = new List<String>();
        for (Integer i = 0; i < 200; i++) {
            emails.add('user' + i + '@example.com');
        }
        createContacts(emails);

        EmailScrubberBatch.testConfigs = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email')
        };

        Test.startTest();
        Database.executeBatch(new EmailScrubberBatch(EmailScrubberBatch.testConfigs), 200);
        Test.stopTest();

        Integer unscrubbed = [
            SELECT COUNT() FROM Contact WHERE NOT (Email LIKE '%.invalid')
        ];
        System.assertEquals(0, unscrubbed, 'All 200 contacts should be scrubbed');
    }

    @isTest
    static void testGetActiveConfigsReturnsTestData() {
        List<Email_Scrubber_Config__mdt> mocks = new List<Email_Scrubber_Config__mdt>{
            mockConfig('Contact', 'Email')
        };
        EmailScrubberBatch.testConfigs = mocks;

        List<Email_Scrubber_Config__mdt> result = EmailScrubberBatch.getActiveConfigs();

        System.assertEquals(1, result.size(), 'Should return injected test configs');
        System.assertEquals('Contact', result[0].Object_API_Name__c);
    }
}