public with sharing class FinanceDataCallout {
  private static final String BASE_URL = 'https://real-time-finance-data.p.rapidapi.com/search?query=';
  private static final String RAPIDAPI_HOST = 'real-time-finance-data.p.rapidapi.com';
  private static final String RAPIDAPI_KEY = 'd42c46f507msh53f1216892357a8p17c44bjsn0cb85a4ac995';

  @AuraEnabled
  public static String searchStockdata(String stockName) {
    String responseBody;
    String endpoint = BASE_URL + stockName;

    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');
    request.setHeader('COntent-Type', 'application/json');
    request.setHeader('x-rapidapi-host', RAPIDAPI_HOST);
    request.setHeader('x-rapidapi-key', RAPIDAPI_KEY);

    try {
      Http http = new Http();
      HttpResponse response = http.send(request);
      system.System.debug('Response: ' + response);
      if (response.getStatusCode() == 200) {
        responseBody = response.getBody();
        system.debug('Response body:=> ' + responseBody);
      } else {
        system.debug('Error Status Code: ' + response.getStatusCode());
        system.debug('Error Response body: ' + response.getBody());
        throw new CalloutException(response.getBody());
      }
    } catch (Exception ex) {
      throw ex;
    }
    return responseBody;
  }
}
