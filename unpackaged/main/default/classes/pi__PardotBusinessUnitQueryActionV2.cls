/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PardotBusinessUnitQueryActionV2 {
    global static String BASE_URL;
    global static String SANDBOX_NAMED_CRED;
    global PardotBusinessUnitQueryActionV2() {

    }
    global static List<pi.PardotBusinessUnitQueryActionV2.Output> getMyBusinessUnits() {
        return null;
    }
    @InvocableMethod(label='Get My Business Units' description='Retrieve Business Units By Context')
    global static List<pi.PardotBusinessUnitQueryActionV2.Output> getMyBusinessUnits(List<pi.PardotBusinessUnitQueryActionV2.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable(label='From Sandbox' description='Whether to query for Business Units from the Sandbox' required=false)
    global Boolean fromSandbox;
    @InvocableVariable(label='Named Credential to Use for Salesforce Metadata API Access' description='Named Credential to Use for Salesforce Metadata API Access' required=false)
    global String salesforceSandboxBUCredential;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='Business Units' required=false)
    global List<pi.PicklistOutput> businessUnits;
    global Output() {

    }
}
global class fakePardotBusinessUnitContextItem {
    global String id;
    global Boolean isCurrent;
    global String name;
    global fakePardotBusinessUnitContextItem() {

    }
}
global class fakePardotBusinessUnitContextOutput {
    global List<pi.PardotBusinessUnitQueryActionV2.fakePardotBusinessUnitContextItem> businessUnits;
    global Boolean isSuccess;
    global Integer totalBusinessUnits;
    global fakePardotBusinessUnitContextOutput() {

    }
}
}
