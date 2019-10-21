public class AccountWeatherController {
   

    
    @Auraenabled
	public static Map<String,Object> hello(Id recordId){
        
	/*	Account account = (Account)stdController.getRecord();*/
		Account account = [SELECT Id, ShippingCity FROM Account WHERE Id =:recordId];
		
		String accountCity = account.ShippingCity;
		String apiKey = '724f273513e4e45ab701758cae1cd982';

		String requestEndpoint = 'http://api.openweathermap.org/data/2.5/weather';
		requestEndpoint += '?q=' + accountCity;
		requestEndpoint += '&units=metric';
		requestEndpoint += '&APPID=' + apiKey;
		
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(requestEndpoint);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
List<Double> l=new List<Double>();
         map<String,Object> animals ;
		// If the request is successful, parse the JSON response.
		if (response.getStatusCode() == 200) {
            
/*Map<String> Data=response.getBody();
            system.debug(Data);*/
		   // Deserialize the JSON string into collections of primitive data types.
		        map<String, Object> results = (map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('results @@@ ' + results);
            animals = (map<String,Object>) results.get('main');
		  	system.debug(animals);
            
        
            system.debug('---------------------'+recordId);
            
            
		} 
return animals;
	}
}