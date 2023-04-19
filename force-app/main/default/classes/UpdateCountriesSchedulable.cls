/**
 * @description Schedulable apex class to retrieve and update Countries (Country__c). 
 * Scheduled every day at 3:00 am
 */
global class UpdateCountriesSchedulable implements Schedulable {

	global void execute(System.SchedulableContext sc) {
        UpdateCountriesController.updateCountriesAPI();
   }
}