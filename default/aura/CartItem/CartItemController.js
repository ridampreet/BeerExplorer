({
	deleteCartItem : function(component, event, helper) {
		var cartItemId = event.currentTarget.id;
        var name=component.get('v.cartItem')
        alert(JSON.stringify(name));
        //var itemId = alert(cartItemId);
        var action = component.get('c.deleteItem');
        action.setParams({
            "CartItemId" : cartItemId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            //alert(state);
            if(state === 'SUCCESS'){
                $A.get('e.force:refreshView').fire(); 
            }else{
                
            }
        });
        $A.enqueueAction(action);
	}
})