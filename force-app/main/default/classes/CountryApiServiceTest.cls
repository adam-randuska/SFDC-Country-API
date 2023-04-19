/**
 * Test class for CountryApiService
 */
@isTest
public with sharing class CountryApiServiceTest {

    @isTest
    static void makeCalloutTest() {
        // prepare
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStatus('200');
        mock.setStaticResource('GetCountriesResponse');
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        // Act
        Test.startTest();
        List<Country__c> results = new CountryApiService().makeCallout();
        Test.stopTest();
        // Compare
        System.assertEquals(1, results.size(), 'Should return 1 record');
        System.assertEquals(results.get(0).Name, 'Switzerland', 'Wrong Country Name');
    }

}