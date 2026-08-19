/**
 * Abstract base class for trigger handlers. Subclasses set objectName in their constructor
 * and override virtual methods (beforeInsert, afterUpdate, etc.) as needed.
 * Provides automatic kill switch checking and per-handler recursion prevention.
 */
public inherited sharing abstract class TriggerHandler {

    private static Map<String, Set<System.TriggerOperation>> completedExecutions =
        new Map<String, Set<System.TriggerOperation>>();

    protected String objectName;
    protected Boolean allowRecursion = false;

    /**
     * Entry point called from the trigger. Reads the current trigger context and
     * delegates to the dispatch logic below.
     */
    public void run() {
        run(Trigger.operationType, Trigger.new, Trigger.old, Trigger.oldMap, Trigger.newMap);
    }

    /**
     * Dispatch logic decoupled from trigger context so it can be unit-tested in isolation.
     * Checks kill switches, enforces recursion prevention, and dispatches to the
     * appropriate virtual method based on the supplied operation.
     */
    @TestVisible
    private void run(System.TriggerOperation operation, List<SObject> newRecords,
                     List<SObject> oldRecords, Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
        if (KillSwitchHelper.isGloballyDisabled() || KillSwitchHelper.isObjectDisabled(objectName)) {
            return;
        }

        if (!allowRecursion && hasAlreadyRun(operation)) {
            return;
        }
        markAsRun(operation);

        switch on operation {
            when BEFORE_INSERT  { beforeInsert(newRecords); }
            when BEFORE_UPDATE  { beforeUpdate(newRecords, oldMap); }
            when BEFORE_DELETE  { beforeDelete(oldRecords, oldMap); }
            when AFTER_INSERT   { afterInsert(newRecords, newMap); }
            when AFTER_UPDATE   { afterUpdate(newRecords, oldMap, newMap); }
            when AFTER_DELETE   { afterDelete(oldRecords, oldMap); }
            when AFTER_UNDELETE { afterUndelete(newRecords, newMap); }
        }
    }

    protected virtual void beforeInsert(List<SObject> newRecords) {}
    protected virtual void beforeUpdate(List<SObject> newRecords, Map<Id, SObject> oldMap) {}
    protected virtual void beforeDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) {}
    protected virtual void afterInsert(List<SObject> newRecords, Map<Id, SObject> newMap) {}
    protected virtual void afterUpdate(List<SObject> newRecords, Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {}
    protected virtual void afterDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) {}
    protected virtual void afterUndelete(List<SObject> newRecords, Map<Id, SObject> newMap) {}

    private Boolean hasAlreadyRun(System.TriggerOperation operation) {
        String handlerName = String.valueOf(this).split(':')[0];
        return completedExecutions.containsKey(handlerName) &&
            completedExecutions.get(handlerName).contains(operation);
    }

    private void markAsRun(System.TriggerOperation operation) {
        String handlerName = String.valueOf(this).split(':')[0];
        if (!completedExecutions.containsKey(handlerName)) {
            completedExecutions.put(handlerName, new Set<System.TriggerOperation>());
        }
        completedExecutions.get(handlerName).add(operation);
    }

    @TestVisible
    private static void resetRecursionTracking() {
        completedExecutions.clear();
    }
}