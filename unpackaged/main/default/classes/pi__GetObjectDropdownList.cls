/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetObjectDropdownList {
    global static List<pi.PicklistOutput> picklistOptions;
    global GetObjectDropdownList() {

    }
    global static pi.GetObjectDropdownList.CollectPickListOptionsService getCollectPickListOptionsServiceInstance() {
        return null;
    }
    @InvocableMethod(label='Get Dropdown Options' description='Retrieve list of id & name for the dropdown options filter by BU.')
    global static List<pi.GetObjectDropdownList.Output> getObjectDropdownOptions(List<pi.GetObjectDropdownList.Input> inputs) {
        return null;
    }
global class CollectPickListOptionsService {
    global pi.GetObjectDropdownList.Input input;
    global Integer maxCallsToPardotAPI;
    global Integer maxRecordsPerAPI;
    global String nextPageToken;
    global Integer timesCalled;
    global CollectPickListOptionsService() {

    }
    global void addResponseToPickListOptions(pi.GetObjectDropdownList.PicklistOutputResponse picklistOutputResponse) {

    }
    global String determineFieldParamsForPardotAPICall() {
        return null;
    }
    global void fetchAndCollectNextPageOfItems() {

    }
    global void fillPickList() {

    }
    global System.HttpResponse makeCallToPardotAPI() {
        return null;
    }
    global Boolean theCallLimitHasBeenReached() {
        return null;
    }
    global Boolean thereAreMorePages() {
        return null;
    }
}
global class Input {
    @InvocableVariable(label='Business Unit ID' required=true)
    global String businessUnitId;
    @InvocableVariable(label='Flow Context' description='Flow context generated using GenerateFlowContext invocable action' required=false)
    global pi.FlowContextModel context;
    @InvocableVariable(label='Fields to retrieve for Query Object from the Pardot API' required=false)
    global String fieldParams;
    @InvocableVariable(label='Get From Source' description='Whether to do the query from the source Business Unit' required=false)
    global Boolean getFromSource;
    @InvocableVariable(label='Query Object from Pardot API' required=true)
    global String queryObject;
    global Input() {

    }
}
global class Output {
    @InvocableVariable(label='List of options' required=false)
    global List<pi.PicklistOutput> options;
    global Output() {

    }
}
global class PicklistOutputResponse {
    global String nextPageToken;
    global List<pi.PicklistOutput> values;
    global PicklistOutputResponse() {

    }
}
}
