@IsTest
private class TriggerHandlerTest {

    @TestSetup
    static void setup() {
        TestDataFactory.setupKillSwitches();
        TestDataFactory.setupErrorLogSettings();
    }

    /**
     * Test-only handler that records which virtual methods fire, so the framework's
     * dispatch, kill-switch, and recursion logic can be exercised without any trigger
     * on a real object. Performs no DML.
     */
    private class MockTriggerHandler extends TriggerHandler {
        public List<String> handled = new List<String>();

        public MockTriggerHandler(String objectName, Boolean allowRecursion) {
            this.objectName = objectName;
            this.allowRecursion = allowRecursion;
        }

        protected override void beforeInsert(List<SObject> newRecords) { handled.add('beforeInsert'); }
        protected override void beforeUpdate(List<SObject> newRecords, Map<Id, SObject> oldMap) { handled.add('beforeUpdate'); }
        protected override void beforeDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) { handled.add('beforeDelete'); }
        protected override void afterInsert(List<SObject> newRecords, Map<Id, SObject> newMap) { handled.add('afterInsert'); }
        protected override void afterUpdate(List<SObject> newRecords, Map<Id, SObject> oldMap, Map<Id, SObject> newMap) { handled.add('afterUpdate'); }
        protected override void afterDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) { handled.add('afterDelete'); }
        protected override void afterUndelete(List<SObject> newRecords, Map<Id, SObject> newMap) { handled.add('afterUndelete'); }
    }

    private static List<SObject> sampleRecords() {
        return new List<SObject>{ new Account(Name = 'Sample') };
    }

    @IsTest
    static void testGlobalKillSwitchPreventsExecution() {
        TestDataFactory.enableGlobalKillSwitch();
        MockTriggerHandler handler = new MockTriggerHandler('Account', false);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        Test.stopTest();

        System.assertEquals(0, handler.handled.size(),
            'Handler should be skipped when global kill switch is on');
    }

    @IsTest
    static void testObjectKillSwitchPreventsExecution() {
        TestDataFactory.enableObjectKillSwitch('Account');
        MockTriggerHandler handler = new MockTriggerHandler('Account', false);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        Test.stopTest();

        System.assertEquals(0, handler.handled.size(),
            'Handler should be skipped when object kill switch is on');
    }

    @IsTest
    static void testAllOperationsDispatch() {
        MockTriggerHandler handler = new MockTriggerHandler('Account', true);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        handler.run(System.TriggerOperation.BEFORE_UPDATE, sampleRecords(), null, new Map<Id, SObject>(), new Map<Id, SObject>());
        handler.run(System.TriggerOperation.BEFORE_DELETE, null, sampleRecords(), new Map<Id, SObject>(), null);
        handler.run(System.TriggerOperation.AFTER_INSERT, sampleRecords(), null, null, new Map<Id, SObject>());
        handler.run(System.TriggerOperation.AFTER_UPDATE, sampleRecords(), null, new Map<Id, SObject>(), new Map<Id, SObject>());
        handler.run(System.TriggerOperation.AFTER_DELETE, null, sampleRecords(), new Map<Id, SObject>(), null);
        handler.run(System.TriggerOperation.AFTER_UNDELETE, sampleRecords(), null, null, new Map<Id, SObject>());
        Test.stopTest();

        System.assertEquals(
            new List<String>{ 'beforeInsert', 'beforeUpdate', 'beforeDelete',
                              'afterInsert', 'afterUpdate', 'afterDelete', 'afterUndelete' },
            handler.handled,
            'Every trigger operation should dispatch to its matching handler method');
    }

    @IsTest
    static void testRecursionPreventionBlocks() {
        TriggerHandler.resetRecursionTracking();
        MockTriggerHandler handler = new MockTriggerHandler('Account', false);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        Test.stopTest();

        System.assertEquals(1, handler.handled.size(),
            'Second run of the same operation should be blocked by recursion prevention');
    }

    @IsTest
    static void testAllowRecursionPermitsReentry() {
        TriggerHandler.resetRecursionTracking();
        MockTriggerHandler handler = new MockTriggerHandler('Contact', true);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        Test.stopTest();

        System.assertEquals(2, handler.handled.size(),
            'Both runs should be handled when allowRecursion is true');
    }

    @IsTest
    static void testResetRecursionTracking() {
        TriggerHandler.resetRecursionTracking();
        MockTriggerHandler handler = new MockTriggerHandler('Account', false);

        Test.startTest();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        TriggerHandler.resetRecursionTracking();
        handler.run(System.TriggerOperation.BEFORE_INSERT, sampleRecords(), null, null, null);
        Test.stopTest();

        System.assertEquals(2, handler.handled.size(),
            'After reset, the same operation should run again');
    }

    @IsTest
    static void testPublicRunOutsideTriggerContext() {
        MockTriggerHandler handler = new MockTriggerHandler('Account', false);

        Test.startTest();
        handler.run();
        Test.stopTest();

        System.assertEquals(0, handler.handled.size(),
            'Public run() outside trigger context has a null operation and should dispatch nothing');
    }
}