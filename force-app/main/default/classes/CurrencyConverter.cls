public with sharing class CurrencyConverter {
  private static final String BASE_URL = 'https://api.frankfurter.app/latest';

  @AuraEnabled
  public static String getExchangeRates(
    String amount,
    String fromCurrency,
    String toCurrency
  ) {
    String responseBody;
    String endpoint =
      BASE_URL +
      '?amount=' +
      amount +
      '&from=' +
      fromCurrency +
      '&to=' +
      toCurrency;

    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');
    try {
      Http http = new Http();
      HttpResponse response = http.send(request);
      system.System.debug('Response: ' + response);
      if (response.getStatusCode() == 200) {
        responseBody = response.getBody();
        system.debug('Response body: ' + responseBody);
      } else {
        system.debug('Error: ' + response.getStatusCode());
        throw new CalloutException(response.getBody());
      }
    } catch (Exception ex) {
      throw ex;
    }
    return responseBody;
  }
}
