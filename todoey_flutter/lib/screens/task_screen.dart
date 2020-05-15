import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/task_list.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:provider/provider.dart';  //package milik Flutter

class TaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // //Penerapan CONTOH 1, buildBottomSheet sudah dibuat Widgetnya di atas (udah kehapus deng :V)
          // showModalBottomSheet(context: context, builder: buildBottomSheet);

          // //[CONTOH2], cara yang lebih simpel, langsung mendeklarasikan widget di builder
          // showModalBottomSheet(context: context, builder: (context) => Container());

          //CONTOH 3, membuat class di luar file ini (yaitu di file add_task_screen.dart)
          //AddTaskScreen ada di file add_task_screen.dart gar lebih rapi, nanti fungsi tsb diterapkan di property onPrssed di FlatButton
          //showModalBottomSheet merupakan class milik flutter, digunakan untuk menampilkan pop up dari bawah layar.
          //pada kasus ini pop up akan akan keluar jika kita menekan floatingActionButton
          showModalBottomSheet(
            context: context, 
            builder: (context) => AddTaskScreen()
          );
          
          // // CONTOH 4, seperti CONTOH 3 intinya untuk memflexibelkan pop up agar bisa di scroll 
          // // dan AddTaskScreennya akan selalu ada di atas keyboard (lihat bagian MediaQuery.of(context).viewInsets.bottom) //BOTTOM
          //  showModalBottomSheet(
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) => SingleChildScrollView( //SingleChildScrollView itu widget milik flutter
          //       child:Container(
          //         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //         child: AddTaskScreen(),  //AddTaskScreennya disini
          //       )
          //     )
          //   );

        }, // onPressed
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // color: Colors.yellow, //testing sebagai alternative inspect element
            padding: EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(  //nested Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0, // semakin besar radius maka semakin besar CircleAvatarnya
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                    color: Colors.lightBlueAccent,
                  )
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  //setiap kali ada perubahan pada TaskData, maka perubahan tersebut akan ditulis disini juga
                  //jika ingin agar setiap perubahan tidak ditulis disini (yg ditulis cuman nilai default/awalnya saja), maka tinggal dikasih property listen: false pada parameter kedua, setelah context
                  '${Provider.of<TaskData>(context).taskCount} Task',  //Provider ini milik package provider yg sudah saya input di atas, taskCount merupakan method yang saya buat di TaskData() untuk menghitung panjang/length dari tasks (return ke tasks.length)
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              // height: 50.0, tadinya ini buat ngetes container, karena container akan muncul di layar kalau punya child atau punya tinggi/lebar. Karena kita dibungkus expanded jadi ini ngga usah
              // color: Colors.white, tidak dipakai karena kita memekai decoration, jadi declarasi colornya di decoration saja
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), 
                  topRight: Radius.circular(20.0),
                )
              ),
              child: TaskList(),  //TaskList disini merupakan refaktor dari ListView
            ),
          )
        ],
      )
    );
  }
}



