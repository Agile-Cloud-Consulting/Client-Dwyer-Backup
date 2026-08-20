/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetLayoutTemplate {
    global GetLayoutTemplate() {

    }
    @InvocableMethod(label='Get Layout Templates' description='Retrieve layout templates by layoutTemplateId and businessUnitId')
    global static List<pi.GetLayoutTemplate.Output> getLayoutTemplates(List<pi.GetLayoutTemplate.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Layout Template ID' required=true)
    global String layoutTemplateId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    @InvocableVariable(label='Layout Template' required=true)
    global pi.LayoutTemplateModel layoutTemplate;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
