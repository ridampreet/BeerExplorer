({
	validate : function(component, event, helper) {
        var isValid = component.find('address').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            inputCmp.set('v.validity', {valid:false, badInput :true});
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        return isValid; 
	},
    fetchAddress : function(component, event, helper){
   var isTrue = component.get('v.isCheckout');
        alert(isTrue);
        if(isTrue){  
            alert('test');
            // create a one-time use instance of the serverEcho action
            // in the server-side controller
            var action = component.get("c.fetchAddressBook");
            //action.setParams();
           
            // Create a callback that is executed after
            // the server-side action returns
            action.setCallback(this, function(response) {
                var state = response.getState();
                alert('state--->' + state);
                if (state === "SUCCESS") {
                    // Alert the user with the value returned
                    // from the server
                    alert("From server: " + response.getReturnValue());
                    var resultData = JSON.parse(response.getReturnValue())
                    component.set('v.addressList' , resultData);
                   
                    // You would typically fire a event here to trigger
                    // client-side notification that the server-side
                    // action is complete
                }
                else if (state === "INCOMPLETE") {
                    // do something
                }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " +
                                            errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
            });
           
            // optionally set storable, abortable, background flag here
           
            // A client-side action could cause multiple events,
            // which could trigger other events and
            // other server-side action calls.
            // $A.enqueueAction adds the server-side action to the queue.
            $A.enqueueAction(action);
        }
    }
})