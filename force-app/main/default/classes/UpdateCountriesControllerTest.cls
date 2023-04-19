/**
 * Test class for UpdateCountriesController
 */
@isTest
public with sharing class UpdateCountriesControllerTest {

    @isTest
    private static void executeTest() {
        CountryApiServiceMock mock = new CountryApiServiceMock();
        UpdateCountriesController.service = (CountryApiService) Test.createStub(CountryApiService.class, mock);
        Test.startTest();
        UpdateCountriesController.updateCountriesAPI();
        Test.stopTest();
        List<Country__c> results = [SELECT Id, Name FROM Country__c];
        System.assertEquals(1, results.size(), 'One record should be created.');
        System.assertEquals('Switzerland', results.get(0).Name, 'One record should be created.');
    }
}