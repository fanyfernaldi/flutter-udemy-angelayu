import 'package:flutter/material.dart';
import 'task_tile.dart';  
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';

class TaskList extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    // [CARA BIASA], pakai ListView
    // return ListView(
    //   children: <Widget>[
    //     TaskTile(taskTitle: tasks[0].name, isChecked: tasks[0].isDone,), //TaskTile disini merupakan refaktor dari ListTile
    //     TaskTile(taskTitle: tasks[1].name, isChecked: tasks[1].isDone,), 
    //     TaskTile(taskTitle: tasks[2].name, isChecked: tasks[2].isDone,),
    //   ],
    // );

    // [CARA YANG LEBIH DINAMIS], pakai ListView.builder jadi indexnya otomatis..
    return Consumer<TaskData>(  //konsumer merupakan kelas milik package provider, berfungsi untuk menyingkat code Provider.of<kelasnya>(context) (*misal, Provider.of<TaskData>(context).task[index].name menjadi taskData.tasks[index].name
      builder: (context, taskData, child){ //taskData merupakan objek dari TaskData
        return ListView.builder(
          itemBuilder: (context, index){
            final task = taskData.tasks[index];
            return TaskTile(  //TaskTile disini merupakan refaktor dari ListTile
              taskTitle: task.name,  
              isChecked: task.isDone,
              checkboxCallBack: (bool checkboxState){ //ngga dikasih bool juga bisa, karena defaultnya otomatis bool //property checkboxCallBck ini dijalankan ketika tombol onChanged di widget CheckBox pada ListTile ditekan
                taskData.updateTask(task);
              },
              longPressCallBack: (){
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.tasks.length,  //untuk kepentingan index di atas, jadi kita cukup ngasih TaskTile 1x saja. TaskTile di atas akan dibuat sesuai dengan jumlah itemCount ini
        );
      },  
    );
  }
}