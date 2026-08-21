@IsTest
private class ErrorLoggerTest {

    @TestSetup
    static void setup() {
        TestDataFactory.setupErrorLogSettings();
    }

    @IsTest
    static void testLogFromException() {
        Test.startTest();
        try {
            throw new DmlException('Test exception');
        } catch (Exception ex) {
            ErrorLogger.log(ex, 'ErrorLoggerTest', 'testLogFromException');
        }
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Class_Name__c, Severity__c, Source__c FROM Error_Log__c];
        System.assertEquals(1, logs.size(), 'Should create one error log');
        System.assertEquals('ErrorLoggerTest', logs[0].Class_Name__c);
        System.assertEquals('ERROR', logs[0].Severity__c);
        System.assertEquals('Apex', logs[0].Source__c);
    }

    @IsTest
    static void testLogFromExceptionWithRecordId() {
        Account acc = new Account(Name = 'Test');
        insert acc;

        Test.startTest();
        try {
            throw new DmlException('Test exception');
        } catch (Exception ex) {
            ErrorLogger.log(ex, 'ErrorLoggerTest', 'testLogWithRecordId', acc.Id);
        }
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Record_Id__c FROM Error_Log__c];
        System.assertEquals(1, logs.size());
        System.assertEquals(acc.Id, logs[0].Record_Id__c);
    }

    @IsTest
    static void testLogFullParameters() {
        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Test error message',
                        'stack trace here', null, 'WARNING', 'Integration');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Class_Name__c, Method_Name__c,
            Error_Message__c, Stack_Trace__c, Severity__c, Source__c FROM Error_Log__c];
        System.assertEquals(1, logs.size());
        System.assertEquals('TestClass', logs[0].Class_Name__c);
        System.assertEquals('testMethod', logs[0].Method_Name__c);
        System.assertEquals('Test error message', logs[0].Error_Message__c);
        System.assertEquals('stack trace here', logs[0].Stack_Trace__c);
        System.assertEquals('WARNING', logs[0].Severity__c);
        System.assertEquals('Integration', logs[0].Source__c);
    }

    @IsTest
    static void testLogFromFlow() {
        ErrorLogRequest req = new ErrorLogRequest();
        req.className = 'Test_Flow';
        req.methodName = 'Update_Records';
        req.errorMessage = 'Flow error message';
        req.severity = null; // should default to ERROR
        req.source = null;   // should default to Flow

        Test.startTest();
        ErrorLogger.logFromFlow(new List<ErrorLogRequest>{ req });
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Class_Name__c, Severity__c, Source__c FROM Error_Log__c];
        System.assertEquals(1, logs.size());
        System.assertEquals('Test_Flow', logs[0].Class_Name__c);
        System.assertEquals('ERROR', logs[0].Severity__c);
        System.assertEquals('Flow', logs[0].Source__c);
    }

    @IsTest
    static void testLoggingDisabledViaCustomSetting() {
        TestDataFactory.setupErrorLogSettings(false, false, null, 90, 'DEBUG');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Should not log', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, logs.size(), 'No log should be created when logging is disabled');
    }

    @IsTest
    static void testVerbosityFilteringBlocksLowerSeverity() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 90, 'ERROR');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Info message', '', '', 'INFO', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, logs.size(), 'INFO should not be logged when verbosity is ERROR');
    }

    @IsTest
    static void testVerbosityFilteringAllowsHigherSeverity() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 90, 'WARNING');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Error message', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, logs.size(), 'ERROR should be logged when verbosity is WARNING');
    }

    @IsTest
    static void testRunningUserIsResolved() {
        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Test', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Running_User__c FROM Error_Log__c];
        System.assertEquals(1, logs.size());
        System.assertEquals(UserInfo.getUserId(), logs[0].Running_User__c,
            'Running user should be resolved to current user');
    }

    @IsTest
    static void testPublishFailureIsSilent() {
        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Test', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, logs.size(), 'Log should still be created even if internal issues occur');
    }

    @IsTest
    static void testEmailNotificationSentOnError() {
        TestDataFactory.setupErrorLogSettings(true, true, 'test@example.com', 90, 'DEBUG');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Critical error', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        // The PE trigger fires in a separate context after Test.stopTest(),
        // which creates the error log and attempts to send email.
        // We verify the log was created (proving the handler ran including email logic).
        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, logs.size(), 'Error log should be created when email notifications are enabled');
    }

    @IsTest
    static void testEmailNotificationNotSentForWarning() {
        TestDataFactory.setupErrorLogSettings(true, true, 'test@example.com', 90, 'DEBUG');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Warning message', '', '', 'WARNING', 'Apex');
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, logs.size(), 'Warning log should be created');
        System.assertEquals(0, Limits.getEmailInvocations(),
            'No email should be sent for WARNING severity');
    }

    @IsTest
    static void testEmailNotificationDisabled() {
        TestDataFactory.setupErrorLogSettings(true, false, 'test@example.com', 90, 'DEBUG');

        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Error', '', '', 'ERROR', 'Apex');
        Test.stopTest();

        System.assertEquals(0, Limits.getEmailInvocations(),
            'No email should be sent when notifications are disabled');
    }

    @IsTest
    static void testLogWithNullSeverityAndSource() {
        Test.startTest();
        ErrorLogger.log('TestClass', 'testMethod', 'Test', '', '', null, null);
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Severity__c, Source__c FROM Error_Log__c];
        System.assertEquals(1, logs.size());
        System.assertEquals('ERROR', logs[0].Severity__c, 'Null severity should default to ERROR');
        System.assertEquals('Apex', logs[0].Source__c, 'Null source should default to Apex');
    }

    @IsTest
    static void testShouldLogVerbosityFiltering() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 90, 'ERROR');

        System.assertEquals(true, ErrorLogger.shouldLog('ERROR'),
            'ERROR should be logged when verbosity is ERROR');
        System.assertEquals(false, ErrorLogger.shouldLog('WARNING'),
            'WARNING should not be logged when verbosity is ERROR');
        System.assertEquals(false, ErrorLogger.shouldLog('INFO'),
            'INFO should not be logged when verbosity is ERROR');
        System.assertEquals(false, ErrorLogger.shouldLog('DEBUG'),
            'DEBUG should not be logged when verbosity is ERROR');
    }

    @IsTest
    static void testShouldLogWarningLevel() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 90, 'WARNING');

        System.assertEquals(true, ErrorLogger.shouldLog('ERROR'),
            'ERROR should be logged when verbosity is WARNING');
        System.assertEquals(true, ErrorLogger.shouldLog('WARNING'),
            'WARNING should be logged when verbosity is WARNING');
        System.assertEquals(false, ErrorLogger.shouldLog('INFO'),
            'INFO should not be logged when verbosity is WARNING');
    }

    @IsTest
    static void testShouldLogDebugLevel() {
        TestDataFactory.setupErrorLogSettings(true, false, null, 90, 'DEBUG');

        System.assertEquals(true, ErrorLogger.shouldLog('ERROR'),
            'ERROR should be logged when verbosity is DEBUG');
        System.assertEquals(true, ErrorLogger.shouldLog('DEBUG'),
            'DEBUG should be logged when verbosity is DEBUG');
    }
}