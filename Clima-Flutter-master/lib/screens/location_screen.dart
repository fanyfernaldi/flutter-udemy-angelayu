import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();  //membuat objek weather dari class WeatherModel yang ada di weather.dart. Tujuan dibuat yaitu nanti akan dipakai sebagai parameter dari method updateUI yang diluar method initState
  int temperature;
  String weatherIcon;
  String weatherMessage;
  String cityName;

  @override
  void initState() {
    super.initState();

    //Disini, penulisannya harus didahului oleh widget terlebih dahulu, karena ini merupakan statefulWidget
    //dimana konstruktornya dideklarasikan di luar locationscreenstate, yaitu di class locationscreen.
    //Keculai kalo ini stateless widget maka kita bisa mengakses locationWeathernya ngga usah pake kata widget didepan
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      //if ini digunakan agar ketika kita ngga menyalakan akses lokasi di hp kita atau openweathermap sedang down atau latitude dan longitude salah
      //atau segala sesuatu yang memungkinkan bahwa weatherData == null, maka akan tampil hal berikut.. untuk memberi tahu error ke pengguna
      if(weatherData == null){
        temperature     = 0;
        weatherIcon     = 'Error';
        weatherMessage  = 'Unable to get weather data';
        cityName        = '';
        return;
      }
      //cara menyimpan data tertentu dari file JSON yang ada di API yang saya fetch pada get diatas,
      //file JSONnya sudah saya decode di file networking.dart
      var temp     = weatherData['main']['temp'];
      temperature     = temp.toInt();
      var condition   = weatherData['weather'][0]['id'];    //sebenarnya condition ini menyimmpan nilai yg bertipe integer
      weatherIcon     = weather.getWeatherIcon(condition); 
      weatherMessage  = weather.getMessage(temperature);  
      cityName        = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async { //pakai async ya, karena dibawah kita pakai await
                      // KASUS1, kalo kita cuman pindah ke halaman city_screen.dart saja:
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return CityScreen();
                      // }));

                      // KASUS2, kalo ternyata di cityScreen mempassing data backward, maka data yang dipassing akan disimpan ke variabel typedName (nama variabelnya bebas ya)
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));

                      if(typedName != null){
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


