import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //ketika memakai initialRoute, maka kita tidak boleh memakai home:

      // [Routing] CARA 1 (CARA BIASA), kelemahannya yaitu jika initialRoutenya typo, maka tidak ada pemberitahuan. AGAR typonya bisa diketahui maka pakailah cara 2 atau 3 di bawah ini
      // initialRoute: 'welcome_screen',
      // routes: {
      //   'welcome_screen' : (context) => WelcomeScreen(), //artinya current context, return to WelcomeScreen()
      //   'registration_screen' : (context) => RegistrationScreen(),
      //   'login_screen' : (context) => LoginScreen(),
      //   'chat_screen' : (context) => ChatScreen()

      // [Routing] CARA 2, dengan membuat objek, sehingga jika value dari initialRoute nya typo maka akan keluar pemberitahuan
      // initialRoute: WelcomeScreen().id,  //id merupakan variabel yang sudah dibuat di dalam class WelcomeScreen
      // routes: {
      //   WelcomeScreen().id : (context) => WelcomeScreen(), //artinya current context, return to WelcomeScreen()
      //   'registration_screen' : (context) => RegistrationScreen(),
      //   'login_screen' : (context) => LoginScreen(),
      //   'chat_screen' : (context) => ChatScreen()


      // [Routing] CARA 3, tanpa membuat objek, tujuannya sama seperti cara 2 agar ketika value dari initialRoutenya typo maka akan keluar pemberitahuan
      initialRoute: WelcomeScreen.id, //id merupakan variabel yang sudah dibuat di dalam class WelcomeScreen, bedanya sama CARA 2, disini idnya sudah diberi modifieer static. Tujuannya agar kita ngga perlu pake () pada WelcomeScreen, artinya kita mengakses id pada kelas WelcomeScreen tanpa harus membuat objek WelcomeScreen
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(), //artinya current context, return to WelcomeScreen()
        RegistrationScreen.id : (context) => RegistrationScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        ChatScreen.id : (context) => ChatScreen()
      }
    );
  }
}
