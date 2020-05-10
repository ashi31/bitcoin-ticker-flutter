import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const String coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = '9845D75D-8F01-4A97-9046-70CE12BF33C3';

class CoinData {
  Future<Map<String, int>> getCoinData(String currency) async {
    Map<String, int> exchangeRates = {};
    for (String cryptoCurrency in cryptoList) {
      http.Response response = await http
          .get('$coinAPIURL/$cryptoCurrency/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        var decodedBTCData = jsonDecode(
          response.body,
        );
        exchangeRates[cryptoCurrency] = decodedBTCData["rate"].toInt();

        if (exchangeRates.length == 3) {
          return exchangeRates;
        }
      } else {
        print(response.statusCode);
        throw ("cannot get response");
      }
    }
    return {};
  }
}
