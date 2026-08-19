/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateCustomField {
    global CreateCustomField() {

    }
    @InvocableMethod(label='Create custom fields' description='Create custom fields based on provided inputs and return created custom field')
    global static List<pi.CreateCustomField.Output> copyCustomFields(List<pi.CreateCustomField.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Custom Field' required=true)
    global pi.CustomFieldModel customField;
    @InvocableVariable(label='Field Id' required=true)
    global String fieldId;
    @InvocableVariable(label='Is Record Multiple Responses' required=false)
    global Boolean isRecordMultipleResponses;
    @InvocableVariable(label='Is Required' required=false)
    global Boolean isRequired;
    @InvocableVariable(label='Is Use Values' required=false)
    global Boolean isUseValues;
    @InvocableVariable(label='Name' required=true)
    global String name;
    @InvocableVariable(label='Salesforce Id' required=false)
    global String salesforceId;
    @InvocableVariable(label='Type' required=true)
    global String type;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created custom field' required=false)
    global pi.CustomFieldModel customField;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
global class SerializeWrapper {
    global String fieldId;
    global Boolean isRecordMultipleResponses;
    global Boolean isRequired;
    global Boolean isUseValues;
    global String name;
    global String salesforceId;
    global String type;
    global SerializeWrapper() {

    }
}
}
