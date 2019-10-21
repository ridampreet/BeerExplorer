public class CartDetailsAuraServices {
    
    private static List<Coupon__c> getCoupon(String Name){
        List<Coupon__c> coupon = [Select Id, Price__c From Coupon__c Where Name =: Name];
        return coupon;
    }
    
    @AuraEnabled
    public static Decimal checkCoupon(String Name, String CartId){
        List<Coupon__c> couponList =  getCoupon(Name);
        if(couponList !=null && couponList.size() > 0){
            Cart__c cart = new Cart__c(Id = cartId, Coupon__c =couponList[0].Id );
            update cart;
            return couponList[0].Price__c;
        }else{
            return null;
        }
    }
    
    @AuraEnabled
    public static String createCartItems(List<String> beerList, String cartId){
        System.debug('#### beerList '+ beerList);
        List<Cart_Item__c> cartItemList = new List<Cart_Item__c>();
        List<Cart_Item__c> cartItemToUpdate = new List<Cart_Item__c>();
        Map<Id, Cart_Item__c> beerQntyMap = getCartItems(cartId);
        For(String beer : beerList){
            List<Beer__c> amount=[select Price__c from Beer__c where  id=:beer];
            Decimal amtt = amount[0].Price__c;
            system.debug(amtt);
            if(beerQntyMap != null && beerQntyMap.containsKey(beer)){
                Cart_Item__c it = beerQntyMap.get(beer);
                Cart_Item__c item = new Cart_Item__c(
                    Item_Quantity__c = it.Item_Quantity__c+1,
                    Item_Amount__c= it.Item_Amount__c + amtt,
                    Id = it.Id
                );
                cartItemToUpdate.add(item);
                system.debug(cartItemToUpdate+'jsfkhjjhsjsadjsdfjsfadsfjkadkasfhdaskdsajkdasfjadsfjk');
            }else{
                Integer Qty = 1;
                Cart_Item__c item = new Cart_Item__c(
                    Cart__c = cartId,
                    Beer__c = beer,
                    Item_Amount__c=amtt,
                    Item_Quantity__c = Qty
                );
                cartItemList.add(item);
                
            }
            system.debug(cartItemList+'jsfkhjjhsjsadjsdfjsfadsfjkadkasfhdaskdsajkdasfjadsfjk');
        }
        insert cartItemList;
        if(cartItemToUpdate != null && cartItemToUpdate.size() > 0)
            update cartItemToUpdate;
        return cartId;
    }
    
    @AuraEnabled 
    public static String getCartId(List<String> beerList){
        system.debug('cartList');
        List<Cart__c> cartList = getCart();
        if(cartList != null && cartList.size() > 0){
            createCartItems(beerList, cartList[0].Id);
            system.debug('cartlist1:'+cartList[0].Id);
            system.debug(cartList[0].Id);
            return cartList[0].Id;
            
            
        }else{
            Cart__c cart = new Cart__c(Coupon__c = getCoupon('Default')[0].Id,Cart_Id__c=String.valueOf(Math.random()),
                                       Cart_Status__c='Open', Is_Active__c=true, User__c = UserInfo.getUserId());
            insert cart;
            createCartItems(beerList, cart.Id);
            return  cart.Id;
        }
    }
    private static List<Cart__c> getCart(){
        List<Cart__c> cartList = [Select Id, Name From Cart__c Where User__c=: UserInfo.getUserId() AND Is_Active__c = true];
        system.debug('cartlist:'+cartList);
        
        return cartList;
        
    }
    
    @AuraEnabled
    public static Map<Id, Cart_Item__c> getCartItems(String CartId){
        List<Cart_Item__c> existingItemList = [Select Id, Name, Item_Amount__c,Item_Quantity__c,Cart__r.Total_Amount__c, Beer__c, Beer__r.Name From Cart_Item__c 
                                               Where Cart__c =: cartId];
        Map<Id, Cart_Item__c> beerQntyMap = new Map<Id, Cart_Item__c>();
        For(Cart_Item__c item : existingItemList){
            if(!beerQntyMap.containsKey(item.Beer__c)){
                beerQntyMap.put(item.Beer__c, item);
            }
        }
        
        return beerQntyMap;
    }
    @AuraEnabled
    public static String fetchAddressBook(){
        List<Address_Book__c> addressList = [Select Id, Name, Street__c, State__c, City__c, Postal_code__c, Country__c From Address_Book__c Where User__c =: Userinfo.getUserId()];
        return (JSON.serialize(addressList));
    }
    
    @AuraEnabled
    public static void deleteItem(String CartItemId){
        
        Database.delete(CartItemId);
    }
    
  @AuraEnabled
    public static String createOrder(String addressId,String cartId,String UserId){
        
      Order__c order = new Order__c(
                        Cart__c = cartId,
            Shipping_Address__c = addressId,
            User__c = UserId
        );
        Cart__c cart = new Cart__c(Id = CartId, Cart_Status__c='Closed', Is_Active__c=false);
        insert order;
           update cart;
        Order__c ord =[Select Id, Name From Order__c Where Id =: order.Id];
        return ord.Name+ '####' + ord.Id;
    }    
}