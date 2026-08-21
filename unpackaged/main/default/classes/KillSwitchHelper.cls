/**
 * Provides helper methods to check hierarchy custom setting kill switches.
 * Uses getInstance() (no SOQL) to read Global, Object, Automation, and Email kill switches.
 */
public with sharing class KillSwitchHelper {

    /**
     * Checks whether the global master kill switch is enabled.
     * @return true if Disable_All__c is checked at the user, profile, or org level
     */
    public static Boolean isGloballyDisabled() {
        Global_Kill_Switch__c settings = Global_Kill_Switch__c.getInstance();
        return settings != null && settings.Disable_All__c;
    }

    /**
     * Checks whether automation is disabled for a specific object.
     * @param objectName API name of the object (e.g., 'Account')
     * @return true if Disable_[objectName]__c is checked
     */
    public static Boolean isObjectDisabled(String objectName) {
        Object_Kill_Switch__c settings = Object_Kill_Switch__c.getInstance();
        if (settings == null) {
            return false;
        }
        try {
            Object fieldValue = settings.get('Disable_' + objectName + '__c');
            return fieldValue != null && (Boolean) fieldValue;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Checks whether a specific named automation is disabled.
     * @param automationName The automation identifier (e.g., 'Lead_Assignment_Flow')
     * @return true if Disable_[automationName]__c is checked
     */
    public static Boolean isAutomationDisabled(String automationName) {
        Automation_Kill_Switch__c settings = Automation_Kill_Switch__c.getInstance();
        if (settings == null) {
            return false;
        }
        try {
            Object fieldValue = settings.get('Disable_' + automationName + '__c');
            return fieldValue != null && (Boolean) fieldValue;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Checks whether outbound emails are disabled via the global kill switch.
     * @return true if Disable_Outbound_Emails__c is checked
     */
    public static Boolean isEmailDisabled() {
        Global_Kill_Switch__c settings = Global_Kill_Switch__c.getInstance();
        if (settings == null) {
            return false;
        }
        try {
            Object fieldValue = settings.get('Disable_Outbound_Emails__c');
            return fieldValue != null && (Boolean) fieldValue;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Convenience method that checks global, object, and automation kill switches in order.
     * Short-circuits on the first enabled switch.
     * @param objectName API name of the object
     * @param automationName The automation identifier
     * @return true if any of the three kill switches is enabled
     */
    public static Boolean isDisabled(String objectName, String automationName) {
        if (isGloballyDisabled()) {
            return true;
        }
        if (isObjectDisabled(objectName)) {
            return true;
        }
        return isAutomationDisabled(automationName);
    }

}