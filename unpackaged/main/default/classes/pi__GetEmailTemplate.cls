/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetEmailTemplate {
    global GetEmailTemplate() {

    }
    @InvocableMethod(label='Get Email Templates' description='Retrieve email templates by emailTemplateId and businessUnitId')
    global static List<pi.GetEmailTemplate.Output> getEmailTemplates(List<pi.GetEmailTemplate.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Email Template ID' required=true)
    global String emailTemplateId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='Email Template' required=true)
    global pi.EmailTemplateModel emailTemplate;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
