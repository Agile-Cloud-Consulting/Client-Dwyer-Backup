/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateEmailTemplate {
    global CreateEmailTemplate() {

    }
    @InvocableMethod(label='Create Email Templates' description='Create email templates based on provided inputs and return created email templates')
    global static List<pi.CreateEmailTemplate.Output> copyEmailTemplates(List<pi.CreateEmailTemplate.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Account Engagement Campaign ID' required=true)
    global String campaignId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Email Template' required=true)
    global pi.EmailTemplateModel emailTemplate;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Account Engagement Tracker Domain ID' required=true)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created email template' required=false)
    global pi.EmailTemplateModel emailTemplate;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
