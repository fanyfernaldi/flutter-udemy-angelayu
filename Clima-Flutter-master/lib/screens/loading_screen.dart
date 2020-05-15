import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {  //kode di dalam method initState akan dieksekusi terlebih dahulu saat file ini dijalankan (hanya sekali setiap file ini dijalankan)
    super.initState();
    getLocationData();
  }  

  //untuk mendapatkan lokasi saya
  void getLocationData() async {  //async dan await sudah saya buat catatan di github
    
    //CARA 1 Membuat objek weatherModel dari class WeatherModel yang ada di weather.dart
    // WeatherModel weatherModel = WeatherModel;
    // var weatherData = await weatherModel.getLocationWeather();

    //Cara 2, tanpa membuat objek, dengan inline saja
    var weatherData = await WeatherModel().getLocationWeather();  //alasan dikasih await karena weatherData mau dipakai di return dibawah ini persis, jadi biar nunggu selesai dulu

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData,);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}
