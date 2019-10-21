({
	doOrder : function(component, event, helper) {
       
	var navComp = component.find("navigation");
    var pageReference = {   
            "type": "standard__component",
            "attributes": {
                "componentName": "c__CreateBeerOrder"   
            },
       "state": {
                "c__beerId": component.get('v.beerId')
            }
        }
        //alert(pageReference.state.myAttr);
   // alert(pageReference.state.beerId);
        navComp.navigate(pageReference);
	}
})