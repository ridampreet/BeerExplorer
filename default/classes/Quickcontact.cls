public class Quickcontact {
    @Auraenabled
    public static Contact hello(contact con,Id accountid){
        /*system.debug('--------------'+con+'-----------------');
        system.debug('--------------'+accountid+'-----------------');
        */
        con.AccountId=accountid;
      	
        insert con;
        system.debug('inserted');
      return con;
  }
}