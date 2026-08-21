/**
 * Publishes error log platform events for transaction-isolated error logging.
 * Supports Apex callers (via overloaded log methods) and Flow callers (via @InvocableMethod).
 * Runs without sharing to guarantee logging regardless of user permissions.
 */
public without sharing class ErrorLogger {

    private static final Map<String, Integer> SEVERITY_LEVELS = new Map<String, Integer>{
        'DEBUG' => 0,
        'INFO' => 1,
        'WARNING' => 2,
        'ERROR' => 3
    };

    /**
     * Logs an error with full parameter control.
     * @param className  The class or flow name where the error occurred
     * @param methodName The method or element name where the error occurred
     * @param errorMessage The error message text
     * @param stackTrace Stack trace or additional context
     * @param recordId Related record ID, if applicable
     * @param severity Severity level: ERROR, WARNING, INFO, or DEBUG
     * @param source Origin of the error: Apex, Flow, Integration, or Other
     */
    public static void log(String className, String methodName, String errorMessage,
                           String stackTrace, String recordId, String severity, String source) {
        publishEvent(className, methodName, errorMessage, stackTrace, recordId, severity, source);
    }

    /**
     * Logs an exception as an ERROR from Apex.
     * @param ex The caught exception
     * @param className The class where the exception was caught
     * @param methodName The method where the exception was caught
     */
    public static void log(Exception ex, String className, String methodName) {
        publishEvent(
            className,
            methodName,
            ex.getMessage(),
            ex.getStackTraceString(),
            null,
            'ERROR',
            'Apex'
        );
    }

    /**
     * Logs an exception as an ERROR from Apex with a related record ID.
     * @param ex The caught exception
     * @param className The class where the exception was caught
     * @param methodName The method where the exception was caught
     * @param recordId Related record ID
     */
    public static void log(Exception ex, String className, String methodName, String recordId) {
        publishEvent(
            className,
            methodName,
            ex.getMessage(),
            ex.getStackTraceString(),
            recordId,
            'ERROR',
            'Apex'
        );
    }

    /**
     * Flow-invocable entry point for error logging. Defaults severity to ERROR and source to Flow.
     * @param requests List of ErrorLogRequest instances from the Flow
     */
    @InvocableMethod(label='Log Error' description='Publishes an error log event' category='Error Logging')
    public static void logFromFlow(List<ErrorLogRequest> requests) {
        for (ErrorLogRequest req : requests) {
            String severity = String.isNotBlank(req.severity) ? req.severity : 'ERROR';
            String source = String.isNotBlank(req.source) ? req.source : 'Flow';
            publishEvent(req.className, req.methodName, req.errorMessage,
                         req.stackTrace, req.recordId, severity, source);
        }
    }

    @TestVisible
    private static Boolean shouldLog(String severity) {
        Error_Log_Settings__c settings = Error_Log_Settings__c.getInstance();
        String verbosity = (settings != null && settings.Verbosity_Level__c != null)
            ? settings.Verbosity_Level__c.toUpperCase()
            : 'DEBUG';
        String sev = (severity != null) ? severity.toUpperCase() : 'ERROR';

        Integer verbosityLevel = SEVERITY_LEVELS.containsKey(verbosity)
            ? SEVERITY_LEVELS.get(verbosity) : 0;
        Integer severityLevel = SEVERITY_LEVELS.containsKey(sev)
            ? SEVERITY_LEVELS.get(sev) : 3;

        return severityLevel >= verbosityLevel;
    }

    private static void publishEvent(String className, String methodName, String errorMessage,
                                     String stackTrace, String recordId, String severity,
                                     String source) {
        try {
            Error_Log_Settings__c settings = Error_Log_Settings__c.getInstance();
            if (settings != null && !settings.Enable_Error_Logging__c) {
                return;
            }

            String sev = String.isNotBlank(severity) ? severity : 'ERROR';
            String src = String.isNotBlank(source) ? source : 'Apex';

            if (!shouldLog(sev)) {
                return;
            }

            Error_Log_Event__e event = new Error_Log_Event__e(
                Class_Name__c = className,
                Method_Name__c = methodName,
                Error_Message__c = errorMessage,
                Stack_Trace__c = stackTrace,
                Record_Id__c = recordId,
                Severity__c = sev,
                Source__c = src,
                Running_User__c = UserInfo.getUserId(),
                Timestamp__c = Datetime.now()
            );

            EventBus.publish(event);
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 'ErrorLogger.publishEvent failed: ' + ex.getMessage());
        }
    }
}