/**
 * Handles Error_Log_Event__e platform events by inserting Error_Log__c records
 * and sending email notifications for ERROR-severity events.
 * Runs without sharing because the PE trigger executes as Automated Process.
 */
public without sharing class ErrorLogEventTriggerHandler {

    /**
     * Processes a batch of error log platform events: creates Error_Log__c records
     * and triggers email notifications for ERROR-severity events.
     * @param events The list of Error_Log_Event__e records from the platform event trigger
     */
    public void handle(List<Error_Log_Event__e> events) {
        List<Error_Log__c> logsToInsert = new List<Error_Log__c>();
        Set<String> userIds = new Set<String>();
        List<Error_Log_Event__e> errorEvents = new List<Error_Log_Event__e>();

        for (Error_Log_Event__e evt : events) {
            if (String.isNotBlank(evt.Running_User__c)) {
                userIds.add(evt.Running_User__c);
            }
            if (evt.Severity__c == 'ERROR') {
                errorEvents.add(evt);
            }
        }

        Map<Id, User> usersById = userIds.isEmpty()
            ? new Map<Id, User>()
            : new Map<Id, User>([SELECT Id FROM User WHERE Id IN :userIds]);

        for (Error_Log_Event__e evt : events) {
            Error_Log__c log = new Error_Log__c(
                Class_Name__c = evt.Class_Name__c,
                Method_Name__c = evt.Method_Name__c,
                Error_Message__c = evt.Error_Message__c,
                Stack_Trace__c = evt.Stack_Trace__c,
                Record_Id__c = evt.Record_Id__c,
                Severity__c = evt.Severity__c,
                Source__c = evt.Source__c,
                Logged_At__c = evt.Timestamp__c
            );

            if (String.isNotBlank(evt.Running_User__c)) {
                try {
                    Id userId = Id.valueOf(evt.Running_User__c);
                    if (usersById.containsKey(userId)) {
                        log.Running_User__c = userId;
                    }
                } catch (Exception e) {
                    System.debug(LoggingLevel.WARN, 'ErrorLogEventTriggerHandler: invalid Running_User__c value \'' + evt.Running_User__c + '\': ' + e.getMessage());
                }
            }

            logsToInsert.add(log);
        }

        if (!logsToInsert.isEmpty()) {
            insert logsToInsert;
        }

        sendEmailNotifications(errorEvents);
    }

    private void sendEmailNotifications(List<Error_Log_Event__e> errorEvents) {
        if (errorEvents.isEmpty()) {
            return;
        }

        Error_Log_Settings__c settings = Error_Log_Settings__c.getOrgDefaults();
        if (settings == null || !settings.Enable_Email_Notifications__c
            || String.isBlank(settings.Email_Recipients__c)) {
            return;
        }

        List<String> recipients = new List<String>();
        for (String addr : settings.Email_Recipients__c.split(',')) {
            String trimmed = addr.trim();
            if (String.isNotBlank(trimmed)) {
                recipients.add(trimmed);
            }
        }

        if (recipients.isEmpty()) {
            return;
        }

        String subject = 'Error Log Alert: ' + errorEvents.size() + ' error(s) detected';
        List<String> bodyParts = new List<String>{
            'The following ' + errorEvents.size() + ' error(s) were logged:\n'
        };

        for (Error_Log_Event__e evt : errorEvents) {
            bodyParts.add('---');
            bodyParts.add('Class: ' + (evt.Class_Name__c != null ? evt.Class_Name__c : ''));
            bodyParts.add('Method: ' + (evt.Method_Name__c != null ? evt.Method_Name__c : ''));
            bodyParts.add('Message: ' + (evt.Error_Message__c != null ? evt.Error_Message__c : ''));
            bodyParts.add('Timestamp: ' + (evt.Timestamp__c != null ? String.valueOf(evt.Timestamp__c) : ''));
            bodyParts.add('');
        }

        String body = String.join(bodyParts, '\n');

        try {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(recipients);
            email.setSubject(subject);
            email.setPlainTextBody(body);
            email.setSaveAsActivity(false);
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'ErrorLogEventTriggerHandler email failed: ' + e.getMessage());
        }
    }
}