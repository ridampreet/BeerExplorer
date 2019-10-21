({
    handleCompEvent : function(cmp, event,helper) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        // 
        // 
        var param = event.getParam('searchText');
        var action = cmp.get("c.searchBeer");
        action.setParams({ searchParam : param });
    action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                // Alert the user with the value returned 
                // from the server
                var responseValue=response.getReturnValue();
                console.log("From server: " + responseValue);
                cmp.set('v.beerList',responseValue);
                // You would typically fire a event here to trigger 
                // client-side notification that the server-side 
                // action is complete
            }
            else{
                console.log(response.getError());
            }
            
            
            
        });
        
        // optionally set storable, abortable, background flag here
        
        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
    updateCart : function(component, event, helper){
        var params = event.getParam('beerRecord');
        //component.set('v.beerRecord', beerRecord);
        var headerComp = component.find('headerComp');
        headerComp.updateCart(params);
    }
})