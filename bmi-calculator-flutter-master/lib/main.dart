import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/screens/input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //#menggunakan tema secara manual, kita mengisi warna2nya sendiri
      // theme: ThemeData(
      //   // primaryColor: Colors.red,
      //   //hash #0A0E21 didapat dari colorZilla firefox, 1B merupakan R(Red), 1D merupakan G(Green), 2F merupakan B(Blue) jadinya #RGB. Namun di flutter value dari color yaitu ARGB dengan A yaitu transparancy, sehingga kita harus mereplace # menjadi 0xFF. Hasilnya dari #0A0E21 menjadi 0xFF0A0E21
      //   primaryColor: Color(0xFF0A0E21),  //merubah warna background appBar
      //   scaffoldBackgroundColor: Color(0xFF0A0E21), //merubah warna background body
      //   textTheme: TextTheme(body1: TextStyle(color: Colors.white)),  //merubah warna text yang ada di body 
      //   accentColor: Colors.purple  //merubah warna floatingButton  
      // ),
      //#menggunakan tema yang sudah ada yaitu dark(), namun kita mengedit beberapa bagian. Perubahannya disimpan didalam copyWith
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),  //merubah warna background appBar
        scaffoldBackgroundColor: Color(0xFF0A0E21), //merubah warna background body
      ),
      home: InputPage(),
    );
  }
}


