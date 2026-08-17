/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateFormHandler {
    global CreateFormHandler() {

    }
    @InvocableMethod(label='Create Form Handlers' description='Create form handler based on provided inputs and return created form handler')
    global static List<pi.CreateFormHandler.Output> copyFormHandlers(List<pi.CreateFormHandler.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Destination Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Campaign Id' required=true)
    global String campaignId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Folder Id' required=true)
    global String folderId;
    @InvocableVariable(label='Form Handler Model' required=true)
    global pi.FormHandlerModel formHandler;
    @InvocableVariable(label='Source Business Unit ID' required=true)
    global String sourceBusinessUnitId;
    @InvocableVariable(label='Tracker Domain Id' required=false)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created Form Handler' required=false)
    global pi.FormHandlerModel formHandler;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
