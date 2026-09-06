public with sharing class SplitStringInvocable {
    @InvocableMethod(label='Split String' description='Splits a delimited string (e.g. a MultiSelectCheckboxes screen field value) into a text collection. Flow does not auto-split these when used directly in an In filter.')
    public static List<Result> execute(List<Request> requests) {
        List<Result> results = new List<Result>();
        for (Request req : requests) {
            Result res = new Result();
            String delimiter = String.isBlank(req.delimiter) ? ';' : req.delimiter;
            if (String.isBlank(req.inputString)) {
                res.values = new List<String>();
            } else {
                res.values = req.inputString.split(delimiter);
            }
            results.add(res);
        }
        return results;
    }

    public class Request {
        @InvocableVariable(required=true)
        public String inputString;
        @InvocableVariable
        public String delimiter;
    }

    public class Result {
        @InvocableVariable
        public List<String> values;
    }
}