/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateListMembership {
    global CreateListMembership() {

    }
    @InvocableMethod(label='Account Engagement: Sign Up Prospect for B2B Marketing Lists' description='Use this action to sign up a prospect for a B2B Marketing List. Prospect ID and List ID are prerequisites for successfully running this action.')
    global static List<pi.CreateListMembership.Output> SignUpProspectB2BMarketingLists(List<pi.CreateListMembership.Input> inputs) {
        return null;
    }
global class Input {
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='ID of the Marketing List to sign the prospect record up to.' required=true)
    global Integer listId;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    @InvocableVariable( description='ID of the prospect record to add to the Marketing List.' required=true)
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
    global pi.CreateListMembership.ListRecord listRecord;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global pi.CreateListMembership.Prospect prospect;
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
    @InvocableVariable( description='Contains error information if the executed action fails.' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON record of the newly created list membership. Review these output fields: id - ID of the list membership record. list.name - Name of the Marketing List. list.title - Publicly visible name of the Marketing List. list.description - Description of the Marketing List. list.isPublic - Indicates if the membership is to a subscription or preference. list.isSalesforceVisible - Indicates if the membership is to a nurture program. prospect.email - Email address of the prospect that’s a member of the list. listId - ID of the associated list record. prospectId - ID of the associated prospect record.' required=false)
    global String record;
    @InvocableVariable( description='This field is deprecated. Use record instead.' required=false)
    global List<pi.CreateListMembership.ListMembership> values;
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
