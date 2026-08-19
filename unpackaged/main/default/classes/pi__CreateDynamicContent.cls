/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateDynamicContent {
    global CreateDynamicContent() {

    }
    @InvocableMethod(label='Create Dynamic Content' description='Create the Dynamic Content')
    global static List<pi.CreateDynamicContent.Output> createDynamicContent(List<pi.CreateDynamicContent.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Dynamic Content' required=true)
    global pi.DynamicContentModel dynamicContent;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Account Engagement Tracker Domain ID' required=true)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created dynamicContent' required=false)
    global pi.DynamicContentModel dynamicContent;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean success;
    global Output() {

    }
}
}
