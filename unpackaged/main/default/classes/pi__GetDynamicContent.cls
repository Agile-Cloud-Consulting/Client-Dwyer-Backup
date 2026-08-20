/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetDynamicContent {
    global GetDynamicContent() {

    }
    @InvocableMethod(label='Get Dynamic Contents' description='Retrieve dynamic contents by dynamicContentId and businessUnitId')
    global static List<pi.GetDynamicContent.Output> getDynamicContents(List<pi.GetDynamicContent.Input> inputs) {
        return null;
    }
global class DynamicContentVariationOutputResponse {
    global List<pi.DynamicContentVariationModel> values;
    global DynamicContentVariationOutputResponse() {

    }
}
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Dynamic Content ID' required=true)
    global String dynamicContentId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='Dynamic Content' required=true)
    global pi.DynamicContentModel dynamicContent;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
