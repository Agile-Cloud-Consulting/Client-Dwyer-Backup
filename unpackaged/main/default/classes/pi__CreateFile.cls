/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateFile {
    global CreateFile() {

    }
    @InvocableMethod(label='Create files' description='Create files based on provided inputs and return recordId of created files.')
    global static List<pi.CreateFile.Output> copyFiles(List<pi.CreateFile.Input> inputs) {
        return null;
    }
    global static Blob getFileContents(String url) {
        return null;
    }
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Account Engagement Campaign ID' required=true)
    global String campaignId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='File' required=true)
    global pi.FileModel filex;
    @InvocableVariable(label='Account Engagement Folder ID' required=true)
    global String folderId;
    @InvocableVariable(label='Account Engagement Tracker Domain ID' required=true)
    global String trackerDomainId;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Created File' required=true)
    global pi.FileModel filex;
    @InvocableVariable(label='Result Status' required=true)
    global Boolean isSuccess;
    @InvocableVariable(label='Result Message' required=true)
    global String message;
    global Output() {

    }
}
global class SerializeWrapper {
    global Integer campaignId;
    global Integer folderId;
    global Integer trackerDomainId;
    global SerializeWrapper() {

    }
}
}
