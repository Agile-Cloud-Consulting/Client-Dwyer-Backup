/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PardotAPIHelper {
    global static String BASE_URL;
    global static String CONTENT_TYPE;
    global static String HOST;
    global static String PARDOT_NAMED_CRED;
    global static String S3_DEMO_ENV_PATH;
    global static String S3_ENV_PATH;
    global PardotAPIHelper() {

    }
    global static System.HttpResponse doGET(String businessUnitId, String queryObject, String fieldParams, pi.FlowContextModel context, Boolean chooseSource) {
        return null;
    }
    global static System.HttpResponse executeDELETE(String businessUnitId, String queryObject, Integer id, pi.FlowContextModel context) {
        return null;
    }
    global static System.HttpResponse executeGET(String businessUnitId, String queryObject, String fieldParams) {
        return null;
    }
    global static System.HttpResponse executeGET(String businessUnitId, String queryObject, String fieldParams, pi.FlowContextModel context) {
        return null;
    }
    global static System.HttpResponse executeGETDestination(String businessUnitId, String queryObject, String fieldParams, pi.FlowContextModel context) {
        return null;
    }
    global static System.HttpResponse executePATCH(String businessUnitId, String queryObject, String fieldParams, String requestBody, pi.FlowContextModel context) {
        return null;
    }
    global static System.HttpResponse executePOST(String businessUnitId, String queryObject, String fieldParams, String requestBody) {
        return null;
    }
    global static System.HttpResponse executePOST(String businessUnitId, String queryObject, String fieldParams, String requestBody, pi.FlowContextModel context) {
        return null;
    }
    global static System.HttpResponse executePOSTAttachment(String businessUnitId, String queryObject, String fieldParams, String requestBody, Blob fileContents, String filename) {
        return null;
    }
    global static System.HttpResponse executePOSTAttachment(String businessUnitId, String queryObject, String fieldParams, String requestBody, Blob fileContents, String filename, pi.FlowContextModel context) {
        return null;
    }
    global static String getBusinessUnitIdFromContext(pi.FlowContextModel context, Boolean chooseSource, String businessUnitId) {
        return null;
    }
    global static String getEndpoint(String queryObject, String fieldParams, pi.FlowContextModel context, Boolean chooseSource) {
        return null;
    }
    @AuraEnabled
    global static String getUserSessionId() {
        return null;
    }
    global static void logException(Exception e) {

    }
}
