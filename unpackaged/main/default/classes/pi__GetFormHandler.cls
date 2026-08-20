/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetFormHandler {
    global GetFormHandler() {

    }
    @InvocableMethod(label='Get Form Handler' description='Retrieve form handlers details')
    global static List<pi.GetFormHandler.Output> getFormHandlers(List<pi.GetFormHandler.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='formHandler ID' required=true)
    global String formHandlerID;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Campaign Id' required=true)
    global Integer campaignId;
    @InvocableVariable(label='Folder Id' required=true)
    global Integer folderId;
    @InvocableVariable(label='form handler' required=true)
    global pi.FormHandlerModel formHandler;
    @InvocableVariable(label='formHandler ID' required=true)
    global String formHandlerID;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    @InvocableVariable(label='Name' required=true)
    global String name;
    global Output() {

    }
}
}
