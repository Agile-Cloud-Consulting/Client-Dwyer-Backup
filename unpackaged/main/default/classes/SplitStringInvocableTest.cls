@isTest
private class SplitStringInvocableTest {
    @isTest
    static void splitsOnDefaultDelimiter() {
        SplitStringInvocable.Request req = new SplitStringInvocable.Request();
        req.inputString = 'test;';

        List<SplitStringInvocable.Result> results = SplitStringInvocable.execute(new List<SplitStringInvocable.Request>{ req });

        System.assertEquals(1, results.size());
        System.assertEquals(new List<String>{ 'test' }, results[0].values);
    }

    @isTest
    static void splitsMultipleValuesOnCustomDelimiter() {
        SplitStringInvocable.Request req = new SplitStringInvocable.Request();
        req.inputString = 'a,b,c';
        req.delimiter = ',';

        List<SplitStringInvocable.Result> results = SplitStringInvocable.execute(new List<SplitStringInvocable.Request>{ req });

        System.assertEquals(new List<String>{ 'a', 'b', 'c' }, results[0].values);
    }

    @isTest
    static void blankInputReturnsEmptyList() {
        SplitStringInvocable.Request req = new SplitStringInvocable.Request();
        req.inputString = null;

        List<SplitStringInvocable.Result> results = SplitStringInvocable.execute(new List<SplitStringInvocable.Request>{ req });

        System.assertEquals(0, results[0].values.size());
    }
}