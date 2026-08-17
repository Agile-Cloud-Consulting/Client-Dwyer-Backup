/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetFile {
    global GetFile() {

    }
    @InvocableMethod(label='Get Files' description='Retrieve files by fileId and businessUnitId')
    global static List<pi.GetFile.Output> getFiles(List<pi.GetFile.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='File ID' required=true)
    global String fileId;
    global Input() {

    }
}
global class Output {
    @AuraEnabled
    @InvocableVariable(label='File' required=true)
    global pi.FileModel filex;
    @AuraEnabled
    global Boolean isSuccess;
    @AuraEnabled
    global String message;
    global Output() {

    }
}
}
