({
   showInfo : function(component, event, helper) {
        var eventSource = event.getSource();
        var beerObj = eventSource.get('v.name');
        console.log(beerObj);
        component.set('v.beerId', beerObj);
        $A.createComponent(
            "c:BeerDetails",
            {
                "beerId" : beerObj
            },
            function(beerDetails, status, errorMessage){
                if (status === "SUCCESS"){
                   
                    component.find ('overLayLib').showCustomModal({
                        header: "Beer Details",
                        body: beerDetails,
                        footer: 'Footer',
                        showCloseButton: true,
                        closeCallback: function(){
                           
                        }
                    });
                   
                }
                else if(status === "INCOMPLETE"){
                    console.log("No response from the server or client is offline.")
                }
                    else if(status === "ERROR"){
                        console.log("Error: ", errorMessage);
                    }
            }
        );
       
    },
    addToCart : function(component,event,helper){
       
    var eventSource = event.getSource();
        var beerId = eventSource.get('v.name');
        var index = eventSource.get('v.value');
        var selectedBeer = component.get('v.recordList')[index];
        //alert(JSON.stringify(component.get('v.recordList')));
        console.log(' selectedBeer '+ selectedBeer.Id);
        //alert(JSON.stringify(selectedBeer.Id));
		var addToCartEvent=component.getEvent('addToCart');
      addToCartEvent.setParams({
            beerRecord : selectedBeer
        });
        addToCartEvent.fire();
    },
})