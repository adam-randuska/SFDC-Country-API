/**
 * Service class for Lead
 */
public with sharing class LeadService {

    /**
     * update Country__c lookup based on Country Name
     * before insert, before update
     */
    public void updateCountryLookup(List<Lead> newLeads, Map<Id, Lead> oldLeads) {
        List<Lead> leadsToProcess = new List<Lead>();
        // Before Insert process all Leads records
        if (oldLeads == null || oldLeads.isEmpty()) {
            leadsToProcess = newLeads;
        } else { // Before Update process only changed Leads
            for (Lead l : newLeads) {
                if (l.Country != oldLeads.get(l.Id).Country) {
                    leadsToProcess.add(l);
                }
            }
        }
        // nothing to do
        if (leadsToProcess.isEmpty()) {
            return;
        }

        Set<String> countries = new Set<String>();
        for (Lead lead : newLeads) {
            if (lead.Country != null) {
                countries.add(lead.Country);
            }
        }
        // Prepare map with Countries records
        Map<String, Id> countryIdByNameMap = new Map<String, Id>();
        for (Country__c c : [SELECT Id, Name FROM Country__c WHERE Name = :countries]) {
            countryIdByNameMap.put(c.Name, c.Id);
        }
        
        // update Country__c lookup
        for (Lead lead : leadsToProcess) {
            if (lead.Country != null) {
                lead.Country__c = countryIdByNameMap.get(lead.Country);
            } else {
                lead.Country__c = null;
            }
        }
    }
}