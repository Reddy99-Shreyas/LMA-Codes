public with sharing class newsController {
  private static final String BASE_URL = 'https://newsapi.org/v2/top-headlines?country=';
  private static final String API_KEY = '3a87235575f14889b8eb23c24891da63';

  @AuraEnabled
  public static Map<String, Object> retriveNews() {
    String country = 'us';
    String endpoint = BASE_URL + country + '&apiKey=' + API_KEY;

    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');

    Map<String, Object> newsJsonData = new Map<String, Object>();
    String strResponse = null;

    try {
      Http http = new Http();
      HttpResponse response = http.send(request);
      system.System.debug('REsponse: ' + response);
      if (response.getStatusCode() == 200) {
        strResponse = response.getBody();
      } else {
        throw new CalloutException(response.getBody());
      }
    } catch (Exception ex) {
      throw ex;
    }
    if (!String.isBlank(strResponse)) {
      newsJsonData = (map<String, Object>) JSON.deserializeUntyped(strResponse);
    }
    if (!newsJsonData.isEmpty()) {
      return newsJsonData;
    } else {
      return null;
    }
  }
}
