//2. Import the required packages.
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'TL',
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'XXXXXXXXXXXXXXXXXXXXXXXX';

class CoinData {
  Future getCoinData(String choosenMoney) async {
    List<double> lastPricesGroup = [];
    http.Response response;
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$choosenMoney?apikey=$apiKey';
      response = await http.get(requestURL);
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      lastPricesGroup.add(lastPrice);
    }
    if (response.statusCode == 200) {
      return lastPricesGroup;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
