@IsTest
public class TestDataFactory {

    public static void setupErrorLogSettings() {
        setupErrorLogSettings(true, false, null, 90, 'DEBUG');
    }

    public static void setupErrorLogSettings(Boolean enableLogging, Boolean enableEmail,
                                              String emailRecipients, Integer retentionDays,
                                              String verbosity) {
        Error_Log_Settings__c settings = Error_Log_Settings__c.getOrgDefaults();
        settings.Enable_Error_Logging__c = enableLogging;
        settings.Enable_Email_Notifications__c = enableEmail;
        settings.Email_Recipients__c = emailRecipients;
        settings.Log_Retention_Days__c = retentionDays;
        settings.Verbosity_Level__c = verbosity;
        upsert settings;
    }

    public static void setupKillSwitches() {
        Global_Kill_Switch__c globalKs = Global_Kill_Switch__c.getOrgDefaults();
        globalKs.Disable_All__c = false;
        globalKs.Disable_Outbound_Emails__c = false;
        upsert globalKs;

        Object_Kill_Switch__c objectKs = Object_Kill_Switch__c.getOrgDefaults();
        upsert objectKs;

        Automation_Kill_Switch__c autoKs = Automation_Kill_Switch__c.getOrgDefaults();
        upsert autoKs;

        Validation_Kill_Switch__c validationKs = Validation_Kill_Switch__c.getOrgDefaults();
        upsert validationKs;
    }

    public static void enableGlobalKillSwitch() {
        Global_Kill_Switch__c globalKs = Global_Kill_Switch__c.getOrgDefaults();
        globalKs.Disable_All__c = true;
        upsert globalKs;
    }

    public static void enableEmailKillSwitch() {
        Global_Kill_Switch__c globalKs = Global_Kill_Switch__c.getOrgDefaults();
        globalKs.Disable_Outbound_Emails__c = true;
        upsert globalKs;
    }

    public static void enableValidationKillSwitch(String objectName) {
        Validation_Kill_Switch__c validationKs = Validation_Kill_Switch__c.getOrgDefaults();
        validationKs.put('Disable_' + objectName + '__c', true);
        upsert validationKs;
    }

    public static void enableObjectKillSwitch(String objectName) {
        Object_Kill_Switch__c objectKs = Object_Kill_Switch__c.getOrgDefaults();
        objectKs.put('Disable_' + objectName + '__c', true);
        upsert objectKs;
    }

    public static void enableAutomationKillSwitch(String automationName) {
        Automation_Kill_Switch__c autoKs = Automation_Kill_Switch__c.getOrgDefaults();
        autoKs.put('Disable_' + automationName + '__c', true);
        upsert autoKs;
    }

    public static Error_Log__c createErrorLog(String className, String severity) {
        Error_Log__c log = new Error_Log__c(
            Class_Name__c = className,
            Method_Name__c = 'testMethod',
            Error_Message__c = 'Test error message',
            Severity__c = severity,
            Source__c = 'Apex',
            Logged_At__c = Datetime.now(),
            Running_User__c = UserInfo.getUserId()
        );
        insert log;
        return log;
    }

    public static List<Error_Log__c> createErrorLogs(Integer count) {
        List<Error_Log__c> logs = new List<Error_Log__c>();
        for (Integer i = 0; i < count; i++) {
            logs.add(new Error_Log__c(
                Class_Name__c = 'TestClass' + i,
                Method_Name__c = 'testMethod',
                Error_Message__c = 'Test error message ' + i,
                Severity__c = 'ERROR',
                Source__c = 'Apex',
                Logged_At__c = Datetime.now(),
                Running_User__c = UserInfo.getUserId()
            ));
        }
        insert logs;
        return logs;
    }
}