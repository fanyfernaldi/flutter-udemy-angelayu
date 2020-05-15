//2
import 'package:http/http.dart' as http;  //didapat dari packagenya flutter
import 'dart:convert';  //ini akan digunakan untuk menkonversi json code

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '58DC3880-225D-45B2-A9AE-BED07EBDC1DB';

class CoinData {
  //fungsi ini akan mereturn ke variabel bertipe Map dengan key = crypto dan value = harga dari crypto tersebut
  Future getCoinData(String selectedCurrency) async {
    //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn
    //5: Return a Map of the result instead of a single value.
    Map<String, String> cryptoPrices = {};
    for(String crypto in cryptoList){
      //Update the URL to use the crypto symbol from the cryptoList
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(requestURL);
      if(response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      }else{
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
