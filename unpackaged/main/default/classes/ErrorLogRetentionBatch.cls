/**
 * Batch job that deletes Error_Log__c records older than the configured retention period.
 * Implements Schedulable so it can be scheduled via cron. Defaults to 90-day retention
 * if Log_Retention_Days__c is not set.
 */
public without sharing class ErrorLogRetentionBatch implements Database.Batchable<SObject>, Schedulable {

    /** Schedulable entry point that launches the batch with a scope of 200. */
    public void execute(SchedulableContext sc) {
        Database.executeBatch(this, 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Integer retentionDays = (Integer) Error_Log_Settings__c.getOrgDefaults().Log_Retention_Days__c;
        if (retentionDays == null) {
            retentionDays = 90;
        }
        DateTime cutoff = DateTime.now().addDays(-retentionDays);
        return Database.getQueryLocator(
            'SELECT Id FROM Error_Log__c WHERE Logged_At__c < :cutoff'
        );
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        delete scope;
    }

    public void finish(Database.BatchableContext bc) {
        // No-op
    }
}