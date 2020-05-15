import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  var leftDiceNumber = 1;
  var rightDiceNumber = 1;

  void changeDiceNumber(){
    setState((){ //pakai setState agar saat button di klik maka gambar (codingan image dibawah ini) akan berubah. Karena ini akan dijalankan dari build method setiap kali klin onPress Button
      leftDiceNumber = Random().nextInt(6) + 1; //ini akan merandom dari 1 sampai 6
      rightDiceNumber = Random().nextInt(6) + 1;
      print('kiri $leftDiceNumber'); //di app tidak terlihat, tapi tulisannya keluar di debug console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded( //expended gunanya agar mengisi semua space yang tersedia (dalam hal ini image). Juga dalam hal ini agar si image tidak menabrak keluar area layar
            child: FlatButton(  //flat button ini defaultnya memiliki padding kanan dan kiri sebesar 16.0
              onPressed: (){
                changeDiceNumber();
              },
              child: Image.asset('images/dice$leftDiceNumber.png'), //cara panggil image versi simpel
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: (){
                changeDiceNumber();
              },
              child: Image(
              image: AssetImage('images/dice$rightDiceNumber.png'), //cara panggil image versi biasa
              ),
            )),
        ],
      ),
    );
  }
}

