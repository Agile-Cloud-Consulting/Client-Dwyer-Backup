/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class GetEngagementStudioPrograms {
    global GetEngagementStudioPrograms() {

    }
    @InvocableMethod(label='Account Engagement: Get B2B Engagement Studio Programs' description='Use this action to retrieve all Engagement Studio Programs. These programs are also known as automated marketing programs.')
    global static List<pi.GetEngagementStudioPrograms.Output> GetB2BEngagementStudioPrograms(List<pi.GetEngagementStudioPrograms.Input> inputs) {
        return null;
    }
global class EngagementStudioProgram {
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdAt;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdByFirstName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String createdByLastName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String description;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String id;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String name;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global List<String> recipientListIds;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String status;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global List<String> suppressionListIds;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedAt;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedByFirstName;
    @InvocableVariable( description='This field is deprecated.' required=false)
    global String updatedByLastName;
    global EngagementStudioProgram() {

    }
}
global class Input {
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    global Input() {

    }
}
global class Output {
    @InvocableVariable( description='Contains error information if the executed action fails.' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON array that contains engagement studio program records. Review these output fields of a record: id - ID of the Engagement Studio Program record. name - Name of the Engagement Studio Program. status - Status of the Engagement Studio Program: draft, running, paused, starting, scheduled. description - Description of the program and its purpose. recipientListIds - Array of list IDs that define the possible program members. Used in conjunction with the suppression lists to determine overall program membership. suppressionListIds - Array of list IDs that define who to remove from program membership consideration, and used in conjunction with recipient lists to determine the overall program membership. createdAt - Date the Engagement Studio Program was created. createdBy.firstName - The first name of the user who created the Engagement Studio Program. createdBy.lastName - The last name of the user who created the Engagement Studio Program. updatedAt - The date the Engagement Studio Program was last updated. updatedBy.firstName - The first name of the user who last updated the Engagement Studio program. updatedBy.lastName - The last name of the user who last updated the Engagement Studio program.' required=false)
    global String records;
    @InvocableVariable( description='This field is deprecated. Use records instead.' required=false)
    global List<pi.GetEngagementStudioPrograms.EngagementStudioProgram> values;
    global Output() {

    }
}
}
