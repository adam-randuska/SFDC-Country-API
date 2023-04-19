/**
 * Mock class for CountryApiService used in tests
 */
@isTest
public with sharing class CountryApiServiceMock implements System.StubProvider {
    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
    Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
    List<Object> listOfArgs) {
        List<Country__c> countries = new List<Country__c>();
        countries.add(new Country__c(Name = 'Switzerland', Country_Code__c = 'CH'));
        return countries;
    }
}