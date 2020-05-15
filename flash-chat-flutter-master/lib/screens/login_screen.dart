import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _auth = FirebaseAuth.instance; //instance ini merupakan variabel static milik class FirebaseAuth yang sudah saya import di atas. Saya buat variabel ini buat sign in. Lihat onChanged pada tombol login pada code di bawah
  bool showSpinner = false;
  String email;
  String password;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero( //widget animasi milik flutter
                  tag: 'logo',  //namanya harus sama dengan welcome_screen karena berhubungan
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
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                )
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                onPressed: () async { //pakai async and await ya.. karena method signInWithEmailAndPassword butuh proses buat ngecek sedangkan variabel user langsung di panggil di method tsb.. jadi dikasih await biar nunggu methodnya selesai dulu.
                  setState(() {
                    showSpinner = true;
                  });
                  try{
                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);  //maka _auth akan menyimpan data login. data email dan password yang sedang login. Lalu data tersebut di simpan dalam variabel user
                    if(user != null){ //jika email dan passwordnya benar
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    showSpinner = false;
                  }catch(e){
                    print(e);
                  }
                },
                title: 'Log In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
