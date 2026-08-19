/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class FormFieldForFormsModel {
    global String cssClasses;
    global String dataFormat;
    global List<pi.FormFieldForFormsModel.DependentModel> dependents;
    global String description;
    global String errorMessage;
    global Integer formId;
    global Boolean hasDependents;
    @AuraEnabled
    global Integer id;
    global Boolean isAlwaysDisplay;
    global Boolean isDoNotPrefill;
    global Boolean isMaintainInitialValue;
    @AuraEnabled
    global Boolean isRequired;
    global String label;
    global List<pi.FormFieldForFormsModel.ProgressiveModel> progressives;
    @AuraEnabled
    global String prospectApiFieldId;
    @AuraEnabled
    global String type;
    global List<pi.FormFieldForFormsModel.ValueModel> values;
    global FormFieldForFormsModel() {

    }
global class DependentModel {
    global Integer formFieldId;
    @AuraEnabled
    global Integer id;
    global Integer parentId;
    global String value;
    global DependentModel() {

    }
}
global class ProgressiveModel {
    @AuraEnabled
    global Integer id;
    global Integer prospectApiFieldId;
    global ProgressiveModel() {

    }
}
global class ValueModel {
    @AuraEnabled
    global Integer id;
    global String label;
    global Integer sortOrder;
    @AuraEnabled
    global String value;
    global ValueModel() {

    }
}
}
