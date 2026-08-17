/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateLandingPage {
    global CreateLandingPage() {

    }
    @InvocableMethod(label='Create Landing Pages' description='Create landing pages based on provided inputs and return created landing pages')
    global static List<pi.CreateLandingPage.Output> copyLandingPages(List<pi.CreateLandingPage.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Destination Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Account Engagement Campaign ID' required=true)
    global String campaignId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Account Engagement Form ID' required=false)
    global String formId;
    @InvocableVariable(label='Landing Page' required=true)
    global pi.LandingPageModel landingPage;
    @InvocableVariable(label='Source Business Unit ID' required=true)
    global String sourceBusinessUnitId;
    @InvocableVariable(label='Account Engagement Tracker Domain ID' required=true)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Created landing page' required=false)
    global pi.LandingPageModel landingPage;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
