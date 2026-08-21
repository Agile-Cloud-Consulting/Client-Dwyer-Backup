@IsTest
private class ErrorLogRetentionBatchTest {

    @TestSetup
    static void setup() {
        TestDataFactory.setupErrorLogSettings();
    }

    @IsTest
    static void testDeletesOldRecords() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 30, 'DEBUG');

        List<Error_Log__c> logs = new List<Error_Log__c>();
        for (Integer i = 0; i < 5; i++) {
            logs.add(new Error_Log__c(
                Class_Name__c = 'OldClass',
                Error_Message__c = 'Old error ' + i,
                Severity__c = 'ERROR',
                Source__c = 'Apex',
                Logged_At__c = Datetime.now().addDays(-60)
            ));
        }
        insert logs;

        Test.startTest();
        Database.executeBatch(new ErrorLogRetentionBatch(), 200);
        Test.stopTest();

        List<Error_Log__c> remaining = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, remaining.size(), 'Old records should be deleted');
    }

    @IsTest
    static void testKeepsRecentRecords() {
        List<Error_Log__c> logs = new List<Error_Log__c>();
        for (Integer i = 0; i < 3; i++) {
            logs.add(new Error_Log__c(
                Class_Name__c = 'RecentClass',
                Error_Message__c = 'Recent error ' + i,
                Severity__c = 'ERROR',
                Source__c = 'Apex',
                Logged_At__c = Datetime.now().addDays(-10)
            ));
        }
        insert logs;

        Test.startTest();
        Database.executeBatch(new ErrorLogRetentionBatch(), 200);
        Test.stopTest();

        List<Error_Log__c> remaining = [SELECT Id FROM Error_Log__c];
        System.assertEquals(3, remaining.size(), 'Recent records should be kept');
    }

    @IsTest
    static void testCustomRetentionDays() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 10, 'DEBUG');

        Error_Log__c oldLog = new Error_Log__c(
            Class_Name__c = 'TestClass',
            Error_Message__c = 'Old error',
            Severity__c = 'ERROR',
            Source__c = 'Apex',
            Logged_At__c = Datetime.now().addDays(-15)
        );
        Error_Log__c recentLog = new Error_Log__c(
            Class_Name__c = 'TestClass',
            Error_Message__c = 'Recent error',
            Severity__c = 'ERROR',
            Source__c = 'Apex',
            Logged_At__c = Datetime.now().addDays(-5)
        );
        insert new List<Error_Log__c>{ oldLog, recentLog };

        Test.startTest();
        Database.executeBatch(new ErrorLogRetentionBatch(), 200);
        Test.stopTest();

        List<Error_Log__c> remaining = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, remaining.size(), 'Only the recent record should remain');
        System.assertEquals(recentLog.Id, remaining[0].Id);
    }

    @IsTest
    static void testNullRetentionDaysDefaultsTo90() {
        Error_Log_Settings__c settings = Error_Log_Settings__c.getOrgDefaults();
        settings.Enable_Error_Logging__c = true;
        settings.Log_Retention_Days__c = null;
        upsert settings;

        Error_Log__c log = new Error_Log__c(
            Class_Name__c = 'TestClass',
            Error_Message__c = 'Old error',
            Severity__c = 'ERROR',
            Source__c = 'Apex',
            Logged_At__c = Datetime.now().addDays(-100)
        );
        insert log;

        Test.startTest();
        Database.executeBatch(new ErrorLogRetentionBatch(), 200);
        Test.stopTest();

        List<Error_Log__c> remaining = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, remaining.size(), 'Records older than 90 days should be deleted with null setting');
    }

    @IsTest
    static void testSchedulableInterface() {
        Test.startTest();
        String jobId = System.schedule(
            'Test Error Log Retention',
            '0 0 2 * * ?',
            new ErrorLogRetentionBatch()
        );
        Test.stopTest();

        CronTrigger ct = [SELECT Id, State FROM CronTrigger WHERE Id = :jobId];
        System.assertNotEquals(null, ct, 'Scheduled job should exist');
    }
}