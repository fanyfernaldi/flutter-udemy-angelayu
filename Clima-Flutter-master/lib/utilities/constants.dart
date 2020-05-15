import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,           //fungsinya agar kolom inputnya bisa terisi diwarnai
  fillColor: Colors.white, //background kolom input menjadi putih, jika ngga ada property filled maka fillColor tidak berpengaruh
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',  //kalau di web, ini itu placeholdernya
  hintStyle: TextStyle(
    color: Colors.grey, //default hinText warnanya putih, jadi kita ganti warnannya biar keliatan
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);