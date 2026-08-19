trigger ErrorLogEventTrigger on Error_Log_Event__e (after insert) {
    new ErrorLogEventTriggerHandler().handle(Trigger.new);
}