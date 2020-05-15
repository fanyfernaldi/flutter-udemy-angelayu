import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked; //untuk mengisi value dari CheckBox
  final String taskTitle; //untuk  mengisi judul dari ListTile
  final Function checkboxCallBack;  //untuk centang dan uncentang kotak checkbox
  final Function longPressCallBack; //untuk menghapus tasklist yang di tekan tahan

  TaskTile({this.isChecked, this.taskTitle, this.checkboxCallBack, this.longPressCallBack});

  // // Tidak digunakan karena kit langsung mendeklarasikan callbacknya di property onChanged di bawh. ini cuma buat ndetailin aja
  // void checkBoxCallBack(bool checkboxState){
  //   setState((){
  //     isChecked = checkboxState;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallBack, //nantinya digunakan untuk menghapus task ketika di tekan dan tahan
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null //lineThrough digunakan untuk memberi garis pada teks
        ),
      ),
      //trailing, widget yang akan ditampilkan setelah title. Kalo sebelum pakenya leading
      trailing: Checkbox( 
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallBack,  //untuk check dan uncheck checkbox
      ),
    );
  }
}

