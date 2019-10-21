public class BeerSearchAuraService {
@Auraenabled
    //function searchBeer being used to return the details of beers and searchParam contains the search text input in the search bar in the home page.
    public static List<sObject> searchBeer(String searchParam){
        system.debug(searchParam);
        String likeParam='%'+searchParam+'%';
        String Query='';
        system.debug(searchParam);
            //'select Id,Name from Beer__c where Name Like :likeParam LIMIT 10';
        if(searchParam!=null){
            Query='Select Id,Name,Alcohol__c,brewery_id__c,brewery_Name__c,Id__c,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c From Beer__c where Name Like :likeParam LIMIT 10';
        }
        else{
        Query='Select Id,Name,Alcohol__c,brewery_id__c,brewery_Name__c,Id__c,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c From Beer__c LIMIT 10';
            }
        
		List<sObject> sObjectList=Database.query(Query);
        system.debug(sObjectList);
        return sObjectList;
    }
}