/**
 * Data transfer object for the ErrorLogger.logFromFlow invocable method.
 * Each property maps to an input variable in the Flow action.
 */
public inherited sharing class ErrorLogRequest {
    @InvocableVariable(label='Class or Flow Name' required=true)
    public String className;

    @InvocableVariable(label='Method or Element Name')
    public String methodName;

    @InvocableVariable(label='Error Message' required=true)
    public String errorMessage;

    @InvocableVariable(label='Stack Trace or Additional Context')
    public String stackTrace;

    @InvocableVariable(label='Related Record ID')
    public String recordId;

    @InvocableVariable(label='Severity (ERROR, WARNING, INFO, DEBUG)')
    public String severity;

    @InvocableVariable(label='Source (Apex, Flow, Integration, Other)')
    public String source;
}