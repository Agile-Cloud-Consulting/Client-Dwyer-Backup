/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GenerateFlowContext {
    global GenerateFlowContext() {

    }
    @InvocableMethod(label='Generate Flow Context' description='Combine all the variables and generate a context that can be used as an input for all the invocable actions')
    global static List<pi.GenerateFlowContext.Output> generateFlowContext(List<pi.GenerateFlowContext.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Named Credential to Use for Account Engagement API Access' required=false)
    global String accountEngagementSandboxBUCredential;
    @InvocableVariable(label='Interview Guid' description='$Flow.InterviewGuid' required=true)
    global String interviewGuid;
    @InvocableVariable(label='Production Business Unit ID' required=false)
    global String productionBusinessUnitId;
    @InvocableVariable(label='Copy from Production to Sandbox' required=false)
    global Boolean productionToSandbox;
    @InvocableVariable(label='Sandbox Business Unit ID' required=false)
    global String sandboxBusinessUnitId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='Flow Context' required=true)
    global pi.FlowContextModel context;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
