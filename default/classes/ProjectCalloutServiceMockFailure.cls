@isTest
global class ProjectCalloutServiceMockFailure {
     global HTTPResponse respond(HTTPRequest request){
        HttpResponse r=new HttpResponse();
        r.setStatusCode(400);
        r.setStatus('Bad Request');
        return r;
        
}
}