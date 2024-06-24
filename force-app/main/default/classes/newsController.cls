public with sharing class newsController {
    @AuraEnabled
    public static Map<String, Object> retriveNews(){

        String URL = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=3a87235575f14889b8eb23c24891da63';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL);
        request.setMethod('GET');

        Map<String, Object> newsJsonData = new Map<String, Object>();
        String strResponse = null;

        try {
            Http http = new Http();
            HttpResponse response = http.send(request);
            system.System.debug('REsponse: ' + response);
            if(response.getStatusCode() == 200){
                strResponse = response.getBody();
            }else {
                throw new CalloutException(response.getBody());
            }
        } catch(Exception ex){
            throw ex;
        }
        if(!String.isBlank(strResponse)){
            newsJsonData = (map<String, Object>)JSON.deserializeUntyped(strResponse);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        } else {
            return null;
        }
    }
}