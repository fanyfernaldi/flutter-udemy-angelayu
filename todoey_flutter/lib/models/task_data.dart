
import 'dart:collection'; 
import 'package:flutter/foundation.dart'; //kalo mau pakai material.dart juga bisa karena didalamnya ada foundation.dart
import 'package:todoey_flutter/models/task.dart';


class TaskData extends ChangeNotifier{  //ChangeNotifier digunakan untuk listen dan update semua perubahan, dalam hal ini pada TaskData(), sehingga memungkinkan kelas lain bisa mengetahui perubahan didalam TaskData (seperti subscribe)
  List<Task> _tasks = [
    Task(name: 'Buy milk'), //Task merupakan class yang saya buat di widgets/task.dart. di dalam Task ada String name dan bool isDone
    Task(name: 'Buy egg'),
    Task(name: 'Buy bread'),
  ]; 

  UnmodifiableListView<Task> get tasks{ //ini bukan ListView widget ya. Didapat dari import collection
    return UnmodifiableListView(_tasks);  //maksunya: mereturn versi Unmodifiable dari _tasks
  }

  int get taskCount{
    return _tasks.length;
  }

  void addTask(String newTaskTitle){
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();  //method milik flutter, tujuannya untuk memberi tahu ke listener kalo bahwa ada perubahan, yg dimaksud listener disini yaitu yg memakai Provider.of...
  }

  void updateTask(Task task){ //method ini dipakai ketika user menekan checkbox, agar bisa check dan uncheck
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){ //method ini digunakan untuk menghapus task yang user tekan dan tahan pada tasklist
    _tasks.remove(task);
    notifyListeners();
  }

}