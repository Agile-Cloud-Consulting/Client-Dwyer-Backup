/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ViewB2BProspect {
    global ViewB2BProspect() {

    }
    @InvocableMethod(label='Account Engagement: View B2B Prospect' description='Use this action to retrieve a prospect record, including profile, score, and ownership. Use an Email, Prospect ID, Lead ID, or Contact ID.')
    global static List<pi.ViewB2BProspect.QueryResponse> ViewB2BProspect(List<pi.ViewB2BProspect.RequestInput> inputs) {
        return null;
    }
global class QueryResponse {
    @InvocableVariable( description='Contains error information if the executed action fails.' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON array that contains prospect records. If there are multiple prospect records with the same email address, always recommend the prospect with the most recent Last Activity Date. Review these output fields for a prospect record: id - ID of the prospect record. email - Prospect's email address. addressOne - Prospect's address, line 1. addressTwo - Prospect's address, line 2. annualRevenue - Annual revenue of the prospect's company. campaign.name - The name of the campaign that converted the prospect to sign-up for marketing. campaign.salesforceId - The Salesforce id for the linked campaign record in Salesforce. Syncs with the account engagement campaign. campaign.id - The id of the Account Engagement campaign that converted the prospect. city - Prospect's city. comments - Comments about this prospect. company - The company the prospect works for. country - Prospect's country. department - The department the prospect works in at their company. employees - The number of employees at the prospect's company. fax - Prospect's fax number. firstName - Prospect's first name. industry - The industry of the prospect's company. isDoNotCall - If true, the prospect does not prefer to be called. isDoNotEmail - If true, the prospect should not be emailed. The field is not the email consent, but an indicator if there is a reason to not email the prospect. isReviewed - If true, prospect has been reviewed. isStarred - If true, prospect has been starred as important. jobTitle - The job title of the prospect at their company. lastName - Prospect's last name. notes - Marketing notes about this prospect. optedOut - If true, prospect has opted out of marketing communications. phone - Prospect's phone number. salesforceId - The salesforce id of the linked Lead/Contact record in salesforce for this prospect. salesforceOwnerId - The salesforce id of the Salesforce user who owns the prospect record. It is a 15 or 18 digit code. salutation - Prospect's formal prefix. score - Prospect's score. source - Prospect's source. state - Prospect's US state. territory - Prospect's territory. userId - The Account Engagement id of the user who owns the prospect record. website - The website URL of the prospect's company. yearsInBusiness - The number of years the prospect's company has been in business. zip - Prospect's postal code. campaignParameter - The utm_campaign of the conversion campaign that converted the prospect to marketing. contentParameter - The utm_content parameter of the campaign that converted the prospect to marketing. convertedAt - Time when prospect was converted from visitor. convertedFromObjectName - Name of object associated with visitor activity that resulted in prospect being converted from visitor. convertedFromObjectType - Type of object associated with visitor activity that resulted in prospect being converted from visitor. Supported values include 'Form', 'FormHandler', 'LandingPage', 'MultivariateTestVariation', and 'Video'. doNotSell - Indicates whether the prospect, or a visitor associated with the prospect, recorded an activity with the Global Privacy Control Header enabled. salesforceAccountId - The account id of the prospect's company in Salesforce. salesforceContactId - The contact id of the prospect in Salesforce if a contact record. salesforceLastSync - The time of the last sync between the prospect record and its associated Salesforce records (lead/contact/individual) salesforceLeadId - The lead id of the prospect in Salesforce if a lead record. emailBouncedAt - Time when prospect email address hard bounced. emailBouncedReason - Reason why prospect email address hard bounced. firstActivityAt - Time when first visitor activity occurred for this prospect. firstAssignedAt - Time prospect was first assigned to a user. firstReferrerQuery - First referrer's search query. firstReferrerType - First referrer's vendor and type (such as 'Google Natural Search'). firstReferrerUrl - First referrer's URL. grade - The prospects letter grade. The grade indicates how good of a fit the prospect is for a sales opportunity based on the prospect's profile. isEmailHardBounced - If true, prospect email address has hard bounced. lastActivityAt - Time stamp of this prospect's latest visitor activity. mediumParameter - Prospect's medium parameter utm_medium from Google Analytics. password - Prospect's password. sourceParameter - Prospect's source parameter utm_source from Google Analytics. termParameter - Prospect's term parameter utm_term from Google Analytics. salesforceUrl - URL to view the prospect within the Salesforce system. lifecycleStageId - The account engagement lifecycle stage of the prospect. Visitor, Prospect, Marketing Qualified Lead (MQL), Sales Qualified Lead (SQL) recentInteraction - Describes the prospect's most recent interaction with Account Engagement. createdAt - Creation time of the prospect record. updatedAt - Last update time of the prospect. createdBy.firstName - The first name of the user who created the prospect record. createdBy.lastName - The last name of the user who created the prospect record. updatedBy.firstName - The first name of the user who last updated this prospect record. updatedBy.lastName - The last name of the user who last updated this prospect record. assignedTo.firstName - The first name of the user who is assigned to the prospect. assignedTo.lastName - The first name of the user who is assigned to the prospect. prospectAccount.name - The name of the prospect's company (i.e. account)' required=false)
    global String values;
    global QueryResponse() {

    }
}
global class RequestInput {
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='Email address of a prospect' required=false)
    global String email;
    @InvocableVariable( description='ID of an Account Engagement prospect record.' required=false)
    global Integer id;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    @InvocableVariable( description='The 15 or 18 character ID of a Lead or Contact record in Salesforce.' required=false)
    global String salesforceId;
    global RequestInput() {

    }
}
}
