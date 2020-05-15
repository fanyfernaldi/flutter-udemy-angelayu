import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/task_screen.dart';
import 'package:provider/provider.dart';  //package milik Flutter
import 'package:todoey_flutter/models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //menerapkan package provider.dart yang sudah saya import di atas. Ini harus di tree bagian teratas ya.. Usahakan di atasnya MaterialApp
    return ChangeNotifierProvider(  
      //cara baca create yaitu ChangeNotifierProvider menyediakan objek TaskData() untuk semua children yang ada di bawah tree (dibawahnya) untuk dapat listen pada data yang ada di TaskData()
      create: (context) => TaskData(), //TaskData merupakan kelas yg saya buat di file task_data.dart, kelas TaskData mengextends ke kelas ChangeNotifier
      child: MaterialApp( 
        home: TaskScreen(),
      ),
    );
  }
}

