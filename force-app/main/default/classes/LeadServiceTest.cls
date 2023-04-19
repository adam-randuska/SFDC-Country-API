/** 
 * Test class for LeadService and LeadTrigger
 */
@isTest
public with sharing class LeadServiceTest {

    private static final String COUNTRY_NAME = 'Switzerland';

    @TestSetup
    static void prepareData(){
        Country__c countrySwiss = new Country__c(
            Name = COUNTRY_NAME, 
            Country_Code__c = 'CH',
            Country_Code_3__c = 'CHE',
            Capital_City__c = 'Bern',
            Region__c = 'Europe'
            );
        insert countrySwiss;
    }

    @isTest
    static void updateCountryLookupTest_Negative() {
        Test.startTest();
        Lead lead = new Lead(LastName = 'LastNameTest', Company = 'Test Company');
        insert lead;
        System.assertEquals(null, [SELECT Country__c FROM Lead WHERE Id = :lead.Id].Country__c, 'Country__c should not be populated.');
        lead.Country = 'Germany';
        update lead;
        Test.stopTest();

        System.assertEquals(null, [SELECT Country__c FROM Lead WHERE Id = :lead.Id].Country__c, 'Country__c should not be populated.');
    }

    @isTest
    static void updateCountryLookupTest_Positive() {
        Test.startTest();
        // insert without Country
        Lead lead = new Lead(LastName = 'LastNameTest', Company = 'Test Company');
        insert lead;
        System.assertEquals(null, [SELECT Country__c FROM Lead WHERE Id = :lead.Id].Country__c, 'Country__c should not be populated.');

        //update Country to existing one
        lead.Country = COUNTRY_NAME;
        update lead;
        System.assertEquals(COUNTRY_NAME, [SELECT Country__r.Name FROM Lead WHERE Id = :lead.Id].Country__r?.Name, 'Country__c should be populated.');

        // insert with existing Country
        lead = new Lead(LastName = 'LastNameTest', Company = 'Test Company', Country = COUNTRY_NAME);
        insert lead;
        System.assertEquals(COUNTRY_NAME, [SELECT Country__r.Name FROM Lead WHERE Id = :lead.Id].Country__r?.Name, 'Country__c should be populated.');
        Test.stopTest();
    }
}