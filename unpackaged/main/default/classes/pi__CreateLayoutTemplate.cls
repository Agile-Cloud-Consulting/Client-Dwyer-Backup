/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateLayoutTemplate {
    global CreateLayoutTemplate() {

    }
    @InvocableMethod(label='Create Layout Templates' description='Create layout templates based on provided inputs and return created layout templates')
    global static List<pi.CreateLayoutTemplate.Output> copyLayoutTemplates(List<pi.CreateLayoutTemplate.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Layout Template' required=true)
    global pi.LayoutTemplateModel layoutTemplate;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Created layout template' required=false)
    global pi.LayoutTemplateModel layoutTemplate;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
}
