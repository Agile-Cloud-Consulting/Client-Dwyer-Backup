/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetEngagementStudioProgram {
    global GetEngagementStudioProgram() {

    }
    @InvocableMethod(label='Get Engagement Studio Programs' description='Retrieve Engagement Studio programs by engagementStudioProgramId and businessUnitId')
    global static List<pi.GetEngagementStudioProgram.Output> getEngagementStudioPrograms(List<pi.GetEngagementStudioProgram.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Engagement Studio Program ID' required=true)
    global String engagementStudioProgramId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='Engagement Studio Program' required=true)
    global pi.EngagementStudioProgramModel engagementStudioProgram;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
