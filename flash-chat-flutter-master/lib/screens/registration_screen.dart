import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';  //dari packagenya flutter, untuk menampilkan spinning ketika sedang proses login dkk

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;  //instance ini merupakan variabel static milik class FirebaseAuth yang sudah saya import di atas
  bool showSpinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD( //class dari package import di atas
        inAsyncCall: showSpinner, // inAsyncCall nilainya hanya 2 yaitu false dan true. False artinya tidak spin dan true berarti melakukan spinning di layar hp
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //tujuan dikasih flexible agar Widget Hero didalamnya bisa menghandle ukuran screen yang berbeda dan aspek rasio
              //dengan flexible ini maka ukuran dari class Hero (logo didalamnya) bisa menyesuaikan layar (logo ngga harus 200px tingginya, bisa mengecil sesuai layar)
              Flexible( 
                child: Hero( //animasi milik flutter
                  tag: 'logo', //nama tagnya harus sama dengan welcome_screen
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,  //agar textnya ke tengah
                keyboardType: TextInputType.emailAddress, //agar keyboardnya berubah menjadi ada tombol @ nya (keyboard untuk email)
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,    //agar tulisan yang diinput tidak terlihat, jadi bunder2 (kalau di web type="password")
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'
                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true; ///melakukan spinning di layar
                  });
                  //memeakai try and catch untk mengantisipasi adanya email yang telah terdaftar atau kesalahan dalam mengisi form email atau password
                  try{
                    //jika kamu hover method createUserWithEmailAndPassword berikut, variabel tersebut merupakan variabel bertipe Future, saya akan membungkusnya ke dalam variabel newUser, dan karena methode ini membutuhkan waktu untuk selesai maka harus diberi async dan await. await digunakan agar kode di bawah menunggu method ini selesai prosses dulu
                    //dan ketika memanggil methode createUserWithEmailAndPassword, maka si _auth sudah menyimpan data email dan password dari user yang baru ini. (Kasus sama seperti di laravel, ketika kita login maka authnya akan menyimpan data user login tersebut)
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
                    if(newUser != null){  
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;  //berhenti spinning
                    });
                  }
                  catch(e){
                    print(e);
                  }
                },
                title: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }
}
