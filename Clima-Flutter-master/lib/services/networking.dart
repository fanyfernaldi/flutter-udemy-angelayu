import 'package:http/http.dart' as http;  //didapat dari packagenya flutter
import 'dart:convert';  //ini akan saya gunakan untuk mengkonversi json code

//class ini digunakan untuk membantu mendapatkan data dari api internet sekaligus mendecode data tersebut dari JSON ke data yang dibutuhkan
class NetworkHelper{
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    //membuat variabel response(namanya terserah sebenere) dengan tipe data Response. Tipe data respone berasal dari http.dart, untuk menyimpan metod get. di dalam class Response itu ada property2 yang sangat berguna untuk kepentingan http
    //karena metod get disimpan dalam variabel, maka harus dikasih async dan await agar variabel yang menggunakan dibawahnya harus menunggu metod getnya selesai
    //disini pakai http.Response, http.get, kenapa ada httpnya? karena di import package di paling atas kita menggunakan as http, tujuannya agar menandai kalo yang di http. itu berasal dari http.dart
    http.Response response = await http.get(url); //menggunakan API di website tertera, untuk mendapatkan data cuaca, longitude, latitude, dkk
    
    if (response.statusCode == 200){    //statusCode merupakan property milik class Response, jika 200 maka sukses. adabanyak statuscode (ini sangat kental hubungannya dengan dunia per httpan / pernetworkan) misal 200,404, dkk
      String data = response.body;

      //karena API yang saya ambil itu codenya berformat json, maka saya akan mendecodenya terlebih dahulu menjadi lebih untuk memanggil data yang lebih spesifik
      // jsonDecode barasal dari import dart:convert diatas;
      // var decodedData     = jsonDecode(data);

      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }

}