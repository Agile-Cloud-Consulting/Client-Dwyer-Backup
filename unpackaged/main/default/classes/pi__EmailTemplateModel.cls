/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class EmailTemplateModel {
    global Integer campaignId;
    @AuraEnabled
    global String errorMessage;
    global Integer folderId;
    global String htmlMessage;
    @AuraEnabled
    global Integer id;
    global Boolean isAutoResponderEmail;
    global Boolean isDripEmail;
    global Boolean isListEmail;
    global Boolean isOneToOneEmail;
    @AuraEnabled
    global String name;
    global List<pi.EmailTemplateModel.SenderOption> senderOptions;
    @AuraEnabled
    global String statusText;
    @AuraEnabled
    global String subject;
    global String textMessage;
    global Integer trackerDomainId;
    global String type;
    global EmailTemplateModel() {

    }
global class SenderOption {
    global String address;
    global String name;
    global String type;
    global SenderOption() {

    }
}
}
