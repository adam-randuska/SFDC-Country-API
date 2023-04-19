/**
 * Used in Scheduled Apex class UpdateCountriesSchedulable
 */
public with sharing class UpdateCountriesController {
    
    @testVisible
    private static CountryApiService service = new CountryApiService();

    @future(callout=true)
	public static void updateCountriesAPI() {
		List<Country__c> results = service.makeCallout();
        upsert results Country_Code__c;
   }
}