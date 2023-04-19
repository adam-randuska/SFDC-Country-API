/**
 * @description API Service class to retrieve and process countries from countrylayer.com endpoint
 */
public class CountryApiService {

    /**
     * @description API call to retrieve Countries data. Retunr list of Country__c records
     */
    public List<Country__c> makeCallout() {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        List<Country__c> results = new List<Country__c>();
        request.setMethod('GET');
        request.setEndpoint('http://api.countrylayer.com/v2/all?access_key=XXX');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            // successful response 
            List<Object> responseBody = (List<Object>)JSON.deserializeUntyped(response.getBody());
            // expected <300 records
            for(Object e : responseBody) {
                Country__c country = CountryApiService.mapCountryRespToSObject((Map<String, Object>) e);
                results.add(country);
            }
        } else {
            // log error
            System.debug(LoggingLevel.ERROR, response.getBody());
        }

        return results;
    }

    /**
     * @description Map Api country response to Country__c SObject
     */
    public static Country__c mapCountryRespToSObject(Map<String, Object> country) {
        Country__c c = new Country__c();
        c.Name = (String) country.get('name');
        c.Country_Code__c  = (String) country.get('alpha2Code');
        c.Country_Code_3__c = (String) country.get('alpha3Code');
        c.Capital_City__c = (String) country.get('capital');
        c.Region__c = (String) country.get('region');
        return c;
    }
}