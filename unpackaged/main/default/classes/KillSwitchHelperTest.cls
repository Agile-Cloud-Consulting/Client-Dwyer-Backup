@IsTest
private class KillSwitchHelperTest {

    @TestSetup
    static void setup() {
        TestDataFactory.setupKillSwitches();
    }

    @IsTest
    static void testGlobalKillSwitchEnabled() {
        TestDataFactory.enableGlobalKillSwitch();

        System.assertEquals(true, KillSwitchHelper.isGloballyDisabled(),
            'isGloballyDisabled should return true when Disable_All__c is checked');
    }

    @IsTest
    static void testGlobalKillSwitchDisabled() {
        System.assertEquals(false, KillSwitchHelper.isGloballyDisabled(),
            'isGloballyDisabled should return false when Disable_All__c is unchecked');
    }

    @IsTest
    static void testObjectKillSwitchEnabled() {
        TestDataFactory.enableObjectKillSwitch('Account');

        System.assertEquals(true, KillSwitchHelper.isObjectDisabled('Account'),
            'isObjectDisabled should return true when Disable_Account__c is checked');
    }

    @IsTest
    static void testObjectKillSwitchDisabled() {
        System.assertEquals(false, KillSwitchHelper.isObjectDisabled('Account'),
            'isObjectDisabled should return false when Disable_Account__c is unchecked');
    }

    @IsTest
    static void testAutomationKillSwitchEnabled() {
        TestDataFactory.enableAutomationKillSwitch('Lead_Assignment_Flow');

        System.assertEquals(true, KillSwitchHelper.isAutomationDisabled('Lead_Assignment_Flow'),
            'isAutomationDisabled should return true when kill switch is checked');
    }

    @IsTest
    static void testAutomationKillSwitchDisabled() {
        System.assertEquals(false, KillSwitchHelper.isAutomationDisabled('Lead_Assignment_Flow'),
            'isAutomationDisabled should return false when kill switch is unchecked');
    }

    @IsTest
    static void testMissingFieldReturnsfalse() {
        System.assertEquals(false, KillSwitchHelper.isObjectDisabled('NonExistentObject'),
            'Missing field should return false, not throw');
        System.assertEquals(false, KillSwitchHelper.isAutomationDisabled('NonExistentAutomation'),
            'Missing field should return false, not throw');
    }

    @IsTest
    static void testIsDisabledShortCircuitsOnGlobal() {
        TestDataFactory.enableGlobalKillSwitch();

        System.assertEquals(true, KillSwitchHelper.isDisabled('Account', 'Lead_Assignment_Flow'),
            'isDisabled should return true when global is enabled');
    }

    @IsTest
    static void testIsDisabledShortCircuitsOnObject() {
        TestDataFactory.enableObjectKillSwitch('Account');

        System.assertEquals(true, KillSwitchHelper.isDisabled('Account', 'Lead_Assignment_Flow'),
            'isDisabled should return true when object is enabled');
    }

    @IsTest
    static void testIsDisabledChecksAutomation() {
        TestDataFactory.enableAutomationKillSwitch('Lead_Assignment_Flow');

        System.assertEquals(true, KillSwitchHelper.isDisabled('Account', 'Lead_Assignment_Flow'),
            'isDisabled should return true when automation is enabled');
    }

    @IsTest
    static void testIsDisabledAllOff() {
        System.assertEquals(false, KillSwitchHelper.isDisabled('Account', 'Lead_Assignment_Flow'),
            'isDisabled should return false when all switches are off');
    }

    @IsTest
    static void testEmailKillSwitchEnabled() {
        TestDataFactory.enableEmailKillSwitch();

        System.assertEquals(true, KillSwitchHelper.isEmailDisabled(),
            'isEmailDisabled should return true when Disable_Outbound_Emails__c is checked');
    }

    @IsTest
    static void testEmailKillSwitchDisabled() {
        System.assertEquals(false, KillSwitchHelper.isEmailDisabled(),
            'isEmailDisabled should return false when Disable_Outbound_Emails__c is unchecked');
    }

    @IsTest
    static void testProfileLevelOverride() {
        Id profileId = UserInfo.getProfileId();
        Global_Kill_Switch__c profileSetting = new Global_Kill_Switch__c(
            SetupOwnerId = profileId,
            Disable_All__c = true
        );
        insert profileSetting;

        System.assertEquals(true, KillSwitchHelper.isGloballyDisabled(),
            'Profile-level kill switch should override org default');
    }

    @IsTest
    static void testUserLevelOverride() {
        Global_Kill_Switch__c userSetting = new Global_Kill_Switch__c(
            SetupOwnerId = UserInfo.getUserId(),
            Disable_All__c = true
        );
        insert userSetting;

        System.assertEquals(true, KillSwitchHelper.isGloballyDisabled(),
            'User-level kill switch should override org and profile defaults');
    }
}