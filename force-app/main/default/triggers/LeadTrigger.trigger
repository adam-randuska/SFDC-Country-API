/**
 * Trigger for Lead Object
 */
trigger LeadTrigger on Lead (before insert, before update) {

    LeadService service = new LeadService();
    // Before Insert
    if (Trigger.isBefore && Trigger.isInsert) {
        service.updateCountryLookup(trigger.new, null);
    }
    // Before Update
    else if (Trigger.isBefore && Trigger.isUpdate) {
        service.updateCountryLookup(trigger.new, trigger.oldMap);
    }
}