/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateEngagementStudioProgram {
    global CreateEngagementStudioProgram() {

    }
    @InvocableMethod(label='Create Engagement Studio Programs' description='Create Engagement Studio programs based on provided inputs and return created Engagement Studio programs')
    global static List<pi.CreateEngagementStudioProgram.Output> copyEngagementStudioPrograms(List<pi.CreateEngagementStudioProgram.Input> inputs) {
        return null;
    }
    global static Blob getFileContents(String businessUnit, String url) {
        return null;
    }
    global static Blob getFileContents(String businessUnit, String url, pi.FlowContextModel context) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Destination Business Unit ID' required=true)
    global String destinationBusinessUnitId;
    @InvocableVariable(label='Engagement Studio Program' required=true)
    global pi.EngagementStudioProgramModel engagementStudioProgram;
    @InvocableVariable(label='Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Source Business Unit ID' required=true)
    global String sourceBusinessUnitId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created Engagement Studio program' required=false)
    global pi.EngagementStudioProgramModel engagementStudioProgram;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
