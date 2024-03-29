global class BillingCalloutServiceMockFailure implements WebServiceMock {



    private final BillingServiceProxy.billProjectResponse_element responseElement;



    global BillingCalloutServiceMockFailure() {

        responseElement = new BillingServiceProxy.billProjectResponse_element();

        responseElement.status = 'UNAUTHORIZED';

    }



    global void doInvoke(

            Object stub,

            Object request,

            Map<String, Object> response,

            String endpoint,

            String soapAction,

            String requestName,

            String responseNS,

            String responseName,

            String responseType) {



        response.put('response_x', responseElement);

    }

}