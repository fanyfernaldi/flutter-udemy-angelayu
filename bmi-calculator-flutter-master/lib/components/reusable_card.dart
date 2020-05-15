import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  
  //disini saya membuat consruktor, agar khusus untuk warna harus diisi dan nantinya bisa di customisasi/diubah-ubah. Saya juga menambahkan cardChild agar kita bisa menambahkan widget didalamnya sesuai apa yang diinginkan.
  ReusableCard({@required this.colour, this.cardChild, this.onPress});

  //variabel/properti yang mewarisi StatelessWidget harus final
  //membuat variabel colour dengan tipe final agar tidak bisa diganti2
  final Color colour;
  final Widget cardChild;
  final Function onPress;   //138. [Dart] Functions as First Order Object. //penerapannya ini di onTap dibawah ini sama liat di construktor diatas ini

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          //variable colour-nya dijadikan value disini
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
    );
  }
}