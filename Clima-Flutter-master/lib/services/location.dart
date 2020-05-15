import 'package:geolocator/geolocator.dart'; //ambil dari package webnya flutter

//class ini digunakan untuk mencari tahu lokasi pengakses dengan mendapatkan latitude dan longitude si pengakses
class Location{
  
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async { //kalo didalamnya ada await maka harus ada async, namun jika ada async ngga harus ada await
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);  //ambil dari package geolocatornya flutter
      
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch(e){
      print(e);
    }
  }

}