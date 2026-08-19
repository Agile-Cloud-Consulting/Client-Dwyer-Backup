/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetCustomField {
    global GetCustomField() {

    }
    @InvocableMethod(label='get Custom Fields' description='Retrieve the Custom FieldIds key details')
    global static List<pi.GetCustomField.Output> getCustomFields(List<pi.GetCustomField.Input> inputs) {
        return null;
    }
global class CustomFieldModels {
    global CustomFieldModels() {

    }
}
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Custom Field ID' required=true)
    global String customFieldID;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='custom field' required=true)
    global pi.CustomFieldModel customField;
    @InvocableVariable(label='Field Id' required=true)
    global String fieldId;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    @InvocableVariable(label='Name' required=true)
    global String name;
    @InvocableVariable(label='Type' required=true)
    global String type;
    global Output() {

    }
}
}
