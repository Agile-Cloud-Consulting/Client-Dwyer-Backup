/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateCustomRedirect {
    global CreateCustomRedirect() {

    }
    @InvocableMethod(label='Create Custom Redirect' description='Create custom redirects based on provided inputs and return created custom redirects')
    global static List<pi.CreateCustomRedirect.Output> copyCustomRedirects(List<pi.CreateCustomRedirect.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Account Engagement Campaign ID' required=true)
    global String campaignId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Custom Redirect' required=true)
    global pi.CustomRedirectModel customRedirect;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Account Engagement Tracker Domain ID' required=true)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created custom redirect' required=false)
    global pi.CustomRedirectModel customRedirect;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
