/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetCustomRedirect {
    global GetCustomRedirect() {

    }
    @InvocableMethod(label='Get Custom Redirects' description='Retrieve custom redirects by customRedirectId and businessUnitId')
    global static List<pi.GetCustomRedirect.Output> getCustomRedirects(List<pi.GetCustomRedirect.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Custom Redirect ID' required=true)
    global String customRedirectId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='Custom Redirect' required=true)
    global pi.CustomRedirectModel customRedirect;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
