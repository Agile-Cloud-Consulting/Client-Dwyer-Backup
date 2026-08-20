/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetListMembership {
    global GetListMembership() {

    }
    @InvocableMethod(label='Account Engagement: Get B2B Marketing List Memberships' description='Use this action to retrieve the Marketing Lists and Marketing List membership status of a prospect.')
    global static List<pi.GetListMembership.Output> GetB2BMarketingListMemberships(List<pi.GetListMembership.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    @InvocableVariable( description='ID of the prospect record that the list membership is connected to.' required=false)
    global Integer prospectId;
    global Input() {

    }
}
global class ListMembership {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Integer id;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Integer listId;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global pi.GetListMembership.ListRecord listRecord;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global pi.GetListMembership.Prospect prospect;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Integer prospectId;
    global ListMembership() {

    }
}
global class ListRecord {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String description;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Boolean isPublic;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global Boolean isSalesforceVisible;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String name;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String title;
    global ListRecord() {

    }
}
global class Output {
    @InvocableVariable( description='Contains error information if the executed action fails' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON array that contains list membership records. Review these output fields: id - ID of the list membership record. list.name - Name of the Marketing List. list.title - Publicly visible name of the Marketing List. list.description - Description of the Marketing List. list.isPublic - Indicates if the membership is to a subscription or preference. list.isSalesforceVisible - Indicates if the membership is to a nurture program. prospect.email - Email address of the prospect that’s a member of the list. listId - ID of the associated list record. prospectId - ID of the associated prospect record.' required=false)
    global String records;
    @InvocableVariable( description='This field is deprecated. Use records instead.' required=false)
    global List<pi.GetListMembership.ListMembership> values;
    global Output() {

    }
}
global class Prospect {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String email;
    global Prospect() {

    }
}
}
