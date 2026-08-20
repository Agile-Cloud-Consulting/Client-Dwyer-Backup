/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetLandingPage {
    global GetLandingPage() {

    }
    @InvocableMethod(label='Get Landing Pages' description='Retrieve landing pages by landingPageId and businessUnitId')
    global static List<pi.GetLandingPage.Output> getLandingPages(List<pi.GetLandingPage.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Landing Page ID' required=true)
    global String landingPageId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    @InvocableVariable(label='Landing Page' required=true)
    global pi.LandingPageModel landingPage;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
