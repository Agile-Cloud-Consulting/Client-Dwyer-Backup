/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetLists {
    global GetLists() {

    }
    @InvocableMethod(label='Account Engagement: Get B2B Marketing Lists' description='Use this action to retrieve all marketing program lists.
Use the isPublic filter to retrieve all subscriptions.
Use the isSalesforceVisible filter to retrieve all Nurture Programs.')
    global static List<pi.GetLists.Output> GetB2BMarketingLists(List<pi.GetLists.Input> inputs) {
        return null;
    }
global class CampaignRecord {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String name;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String salesforceId;
    global CampaignRecord() {

    }
}
global class Input {
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='Filters to only public lists, including subscriptions or preferences.' required=false)
    global Boolean isPublic;
    @InvocableVariable( description='Filters to only nurture programs accessible to Salesforce.' required=false)
    global Boolean isSalesforceVisible;
    @InvocableVariable( description='Add this value to retrieve a specific list’s information.' required=false)
    global Integer listID;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    global Input() {

    }
}
global class ListRecord {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global pi.GetLists.CampaignRecord campaign;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdAt;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdByFirstName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdByLastName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Integer id;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String isDynamic;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String isPublic;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String isSalesforceVisible;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String name;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String title;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedAt;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedByFirstName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedByLastName;
    global ListRecord() {

    }
}
global class Output {
    @InvocableVariable( description='Contains error information if the executed action fails.' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON array that contains list records. Review these output fields: id - ID of the Marketing List record. name - Name of the Marketing List. title - Public name of the Marketing List. campaign.name - Name of the Campaign associated with the Marketing List. campaign.salesforceId - The Salesforce campaign Id associated with this list. createdAt - Date the Marketing List was created. updatedAt- Date the Marketing List was last updated. createdBy.firstName - The first name of the user who created the list. createdBy.lastName - The last name of the user who created the list. updatedBy.firstName - The first name of the user who last updated the list. updatedBy.lastName - The last name of the user who last updated the list. isPublic - Indicates if the Marketing List is a subscription. isSalesforceVisible - Indicates if the Marketing List is part of a general nurture program. isDynamic - Indicates if the Marketing List membership is decided by automated criteria. Not recommended to add users manually to these lists as they may be immediately removed if they don’t match criteria.' required=false)
    global String records;
    @InvocableVariable( description='This field is deprecated. Use records instead.' required=false)
    global List<pi.GetLists.ListRecord> values;
    global Output() {

    }
}
}
