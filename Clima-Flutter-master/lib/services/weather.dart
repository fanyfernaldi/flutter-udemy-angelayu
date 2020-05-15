import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const kApiKey = '94138d892ba3221dd5290888765be45c';
const kOpenWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

//class ini digunakan untuk mendapatkan lokasi sekarang dari pengguna dan dilanjut mendapatkan data cuaca dari pengguna
//disini kita menerapkan class Location dan class NetworkHelper yang telah dibuat di file terpisah
class WeatherModel {

  // digunakan untuk mendapatkan cuaca berdasarkan kota yang di ketik pada city_screen.dart
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('$kOpenWeatherMapURL?q=$cityName&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //method yang digunakan untuk mendapatkan lokasi cuaca di tempat pengguna
  //karena return ke variabel yang bertipe dymanic, maka Futurenya juga diset ke dynamic
  //Future ini dideklarasikan karena agar saat memanggil method ini di class lain, maka class lain yang memanggil dapat menggunakan await pada method ini
  Future<dynamic> getLocationWeather() async {
    Location location = Location(); //membuat objek location dari class location yang sudah saya buat di file location.dart
    await location.getCurrentLocation();  //nah disini kan kita pakai await pada method getCurrentLocation(), maka di metod tsb harus dikasih future

    NetworkHelper networkHelper = NetworkHelper('$kOpenWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();  //karena kita menggunakan await pada methode getData milik class NetworkHelper, maka kita harus menggunakan Future di methode getData() //lokasi di networking.dart

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
