import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(   //melihat di floatingActionButton(jika di ctrl+klik) maka akan mereturn ke RawMaterialButton, nah disini RawMaterialButtonnya kita copy dan modif. Ini merupakan cara di flutter untuk menduplikasi dan memodifikasi tombol yang sudah ada.
      elevation: 0.0, //agar tidak ada efek bayangan pada tombol yang kita buat
      child: Icon(icon),
      onPressed: onPressed, //RawMaterialButon wajib ada onPressed
      constraints: BoxConstraints.tightFor(  //ini melihat dari RawMaterialButton yang ada di FloatingActionButton.dart, untuk menyamakan lebar dan tinggi tombol yang kita buat seperti FloatingActionButton milik Flutter
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),  //agar lingkaran
      fillColor: Color(0xFF4C4F5E), //memberi warna button
    );
  }
}