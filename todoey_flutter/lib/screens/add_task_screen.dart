import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';

//untuk membuat pop up
class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;  //untuk menyimpan apapun yang user ketik di TextField

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,  //harus dibawahnya 'text' ya
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,  //agar ketika pengguna menekan FloatingButon/add task screen button maka keyboardnya auto muncul
              textAlign: TextAlign.center,  //agar teks yang diinput dimulai dari tengah
              onChanged: (newValue){
                newTaskTitle = newValue;
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: (){  //note: jika kita ngga pakai onPressed() maka tombolnya kotaknya ngga keluar, yang ada cuman tulisan Add
                // // Cara 1, ngga pakai method
                // final task = Task(name: newTaskTitle);
                // Provider.of<TaskData>(context).tasks.add(task);
                // Navigator.pop(content);

                //Cara 2, pakai method addTask yang ada di task_data.dart
                //ternyata kalo di dalam onPressed harus pakai listen: false gaes.. kalo ngga ada jd error
                Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
                Navigator.pop(context);
              }, 
            )
          ],
        ),
      ),
    );
  }
}