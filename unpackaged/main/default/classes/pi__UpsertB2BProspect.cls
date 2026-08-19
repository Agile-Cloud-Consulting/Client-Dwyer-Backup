/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class UpsertB2BProspect {
    global UpsertB2BProspect() {

    }
    @InvocableMethod(label='Account Engagement: Upsert B2B Prospect' description='Use this action to upsert a prospect record, including profile, score, and ownership. Use an Email, Prospect ID, Lead ID, or Contact ID.')
    global static List<pi.UpsertB2BProspect.UpsertResponse> UpsertB2BProspect(List<pi.UpsertB2BProspect.RequestInput> inputs) {
        return null;
    }
global class RequestInput {
    @InvocableVariable( description='First line of the work address of the prospect.' required=false)
    global String addressOne;
    @InvocableVariable( description='Second line of the work address of the prospect.' required=false)
    global String addressTwo;
    @InvocableVariable( description='Revenue of the company the prospect works for.' required=false)
    global String annualRevenue;
    @InvocableVariable( description='Business Unit ID of the Account Engagement business unit to access.' required=true)
    global String businessUnitId;
    @InvocableVariable( description='Account Engagement campaign that converted the prospect.' required=false)
    global Integer campaignId;
    @InvocableVariable( description='City of the work address of the prospect.' required=false)
    global String city;
    @InvocableVariable( description='Marketing comments about a prospect.' required=false)
    global String comments;
    @InvocableVariable( description='Name of the company the prospect works at.' required=false)
    global String company;
    @InvocableVariable( description='Country of the work address of the prospect.' required=false)
    global String country;
    @InvocableVariable( description='Department the prospect works in at their company.' required=false)
    global String department;
    @InvocableVariable( description='Work email address of the prospect.' required=true)
    global String email;
    @InvocableVariable( description='Number of employees at the company the prospect works for.' required=false)
    global String employees;
    @InvocableVariable( description='Work fax number of the prospect.' required=false)
    global String fax;
    @InvocableVariable( description='First name of the prospect.' required=false)
    global String firstName;
    @InvocableVariable( description='Industry of the company the prospect works for.' required=false)
    global String industry;
    @InvocableVariable( description='When false, indicates the prospect has consented to calls.' required=false)
    global Boolean isDoNotCall;
    @InvocableVariable( description='When false, indicates the prospect can be emailed. Not the email consent field.' required=false)
    global Boolean isDoNotEmail;
    @InvocableVariable( description='Indicates if marketing has reviewed the prospect.' required=false)
    global Boolean isReviewed;
    @InvocableVariable( description='Indicates if the prospect has been marked as important.' required=false)
    global Boolean isStarred;
    @InvocableVariable( description='Job Title of the prospect at their company.' required=false)
    global String jobTitle;
    @InvocableVariable( description='Last name of the prospect.' required=false)
    global String lastName;
    @InvocableVariable( description='Provides the named credential to leverage for authentication.' required=true)
    global String namedCredential;
    @InvocableVariable( description='Marketer notes.' required=false)
    global String notes;
    @InvocableVariable( description='Indicates if the prospect has opted out of marketing communications. This field serves as the email marketing consent value.' required=false)
    global Boolean optedOut;
    @InvocableVariable( description='Work phone number of the prospect.' required=false)
    global String phone;
    @InvocableVariable( description='Sets the grading profile to use for the prospect based on the ID.' required=false)
    global Integer profileId;
    @InvocableVariable( description='ID of the related account record in Account Engagement.' required=false)
    global Integer prospectAccountId;
    @InvocableVariable( description='Salesforce ID of the Lead or Contact record the prospect is syncing with.' required=false)
    global String salesforceId;
    @InvocableVariable( description='Salesforce ID of the Salesforce user who owns the prospect. If a value is present, a value will not be provided under userId.' required=false)
    global String salesforceOwnerId;
    @InvocableVariable( description='Salutation of the prospect.' required=false)
    global String salutation;
    @InvocableVariable( description='Engagement score for the prospect.' required=false)
    global Integer score;
    @InvocableVariable( description='The source of the prospect.' required=false)
    global String source;
    @InvocableVariable( description='State of the work address of the prospect.' required=false)
    global String state;
    @InvocableVariable( description='Territory associated with the company the prospect works for.' required=false)
    global String territory;
    @InvocableVariable( description='The Account Engagement ID of the user who owns the prospect. If a value is present, a value will not be provided under salesforceOwnerId.' required=false)
    global Integer userId;
    @InvocableVariable( description='Website of the company the prospect works for.' required=false)
    global String website;
    @InvocableVariable( description='Number of years the company the prospect works for has been in business.' required=false)
    global String yearsInBusiness;
    @InvocableVariable( description='ZIP code of the work address of the prospect.' required=false)
    global String zip;
    global RequestInput() {

    }
}
global class UpsertResponse {
    @InvocableVariable( description='Contains error information if the executed action fails.' required=false)
    global String errorMessage;
    @InvocableVariable( description='Indicates the response status code from API calls.' required=false)
    global Integer httpCode;
    @InvocableVariable( description='Indicates whether the action is successful or not. A True value indicates a successful action.' required=false)
    global Boolean isSuccessful;
    @InvocableVariable( description='A JSON record of the newly created prospect. Review these  output fields for a prospect record: id - ID of the prospect record. email - Prospect's email address. addressOne - Prospect's address, line 1. addressTwo - Prospect's address, line 2. annualRevenue - Annual revenue of the prospect's company. campaign.name - The name of the campaign that converted the prospect to sign-up for marketing. campaign.salesforceId - The Salesforce id for the linked campaign record in Salesforce. Syncs with the account engagement campaign. campaign.id - The id of the Account Engagement campaign that converted the prospect. city - Prospect's city. comments - Comments about this prospect. company - The company the prospect works for. country - Prospect's country. department - The department the prospect works in at their company. employees - The number of employees at the prospect's company. fax - Prospect's fax number. firstName - Prospect's first name. industry - The industry of the prospect's company. isDoNotCall - If true, the prospect does not prefer to be called. isDoNotEmail - If true, the prospect should not be emailed. The field is not the email consent, but an indicator if there is a reason to not email the prospect. isReviewed - If true, prospect has been reviewed. isStarred - If true, prospect has been starred as important. jobTitle - The job title of the prospect at their company. lastName - Prospect's last name. notes - Marketing notes about this prospect. optedOut - If true, prospect has opted out of marketing communications. phone - Prospect's phone number. salesforceId - The salesforce id of the linked Lead/Contact record in salesforce for this prospect. salesforceOwnerId - The salesforce id of the Salesforce user who owns the prospect record. It is a 15 or 18 digit code. salutation - Prospect's formal prefix. score - Prospect's score. source - Prospect's source. state - Prospect's US state. territory - Prospect's territory. userId - The Account Engagement id of the user who owns the prospect record. website - The website URL of the prospect's company. yearsInBusiness - The number of years the prospect's company has been in business. zip - Prospect's postal code. campaignParameter - The utm_campaign of the conversion campaign that converted the prospect to marketing. contentParameter - The utm_content parameter of the campaign that converted the prospect to marketing. convertedAt - Time when prospect was converted from visitor. convertedFromObjectName - Name of object associated with visitor activity that resulted in prospect being converted from visitor. convertedFromObjectType - Type of object associated with visitor activity that resulted in prospect being converted from visitor. Supported values include 'Form', 'FormHandler', 'LandingPage', 'MultivariateTestVariation', and 'Video'. doNotSell - Indicates whether the prospect, or a visitor associated with the prospect, recorded an activity with the Global Privacy Control Header enabled. salesforceAccountId - The account id of the prospect's company in Salesforce. salesforceContactId - The contact id of the prospect in Salesforce if a contact record. salesforceLastSync - The time of the last sync between the prospect record and its associated Salesforce records (lead/contact/individual) salesforceLeadId - The lead id of the prospect in Salesforce if a lead record. emailBouncedAt - Time when prospect email address hard bounced. emailBouncedReason - Reason why prospect email address hard bounced. firstActivityAt - Time when first visitor activity occurred for this prospect. firstAssignedAt - Time prospect was first assigned to a user. firstReferrerQuery - First referrer's search query. firstReferrerType - First referrer's vendor and type (such as 'Google Natural Search'). firstReferrerUrl - First referrer's URL. grade - The prospects letter grade. The grade indicates how good of a fit the prospect is for a sales opportunity based on the prospect's profile. isEmailHardBounced - If true, prospect email address has hard bounced. lastActivityAt - Time stamp of this prospect's latest visitor activity. mediumParameter - Prospect's medium parameter utm_medium from Google Analytics. password - Prospect's password. sourceParameter - Prospect's source parameter utm_source from Google Analytics. termParameter - Prospect's term parameter utm_term from Google Analytics. salesforceUrl - URL to view the prospect within the Salesforce system. lifecycleStageId - The account engagement lifecycle stage of the prospect. Visitor, Prospect, Marketing Qualified Lead (MQL), Sales Qualified Lead (SQL) recentInteraction - Describes the prospect's most recent interaction with Account Engagement. createdAt - Creation time of the prospect record. updatedAt - Last update time of the prospect. createdBy.firstName - The first name of the user who created the prospect record. createdBy.lastName - The last name of the user who created the prospect record. updatedBy.firstName - The first name of the user who last updated this prospect record. updatedBy.lastName - The last name of the user who last updated this prospect record. assignedTo.firstName - The first name of the user who is assigned to the prospect. assignedTo.lastName - The first name of the user who is assigned to the prospect. prospectAccount.name - The name of the prospect's company (i.e. account)' required=false)
    global String record;
    global UpsertResponse() {

    }
}
}
