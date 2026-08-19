/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetForm {
    global GetForm() {

    }
    @InvocableMethod(label='Get Form' description='Retrieve form details')
    global static List<pi.GetForm.Output> getForms(List<pi.GetForm.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='form ID' required=true)
    global String formID;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Campaign Id' required=true)
    global Integer campaignId;
    @InvocableVariable(label='Folder Id' required=true)
    global Integer folderId;
    @InvocableVariable(label='form' required=true)
    global pi.FormModel form;
    @InvocableVariable(label='form ID' required=true)
    global String formID;
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
