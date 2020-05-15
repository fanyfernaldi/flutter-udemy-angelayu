import 'dart:io';

//penerapan async, await dan future

void main() {
  performTasks();
}

void performTasks()  {
   task1();
  //  String task2Result = task2();
   print(task2());
  //  task3(task2Result)
}

void task1() {
  // String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async  { //jika tidak di spefikasikan <String> maka Futurenya dinamis
  Duration threeSeconds = Duration(seconds: 3);
  //sleep(threeSeconds);  //sleep termasuk ke sync

  String result;

  await Future.delayed(threeSeconds, (){  //method Future termasuk async, sehingga kodingan akan terus kontinue tanpa harus menunggu kodingan ini
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

void task3() {
//  String result = 'task 3 data';
  print('Task 3 complete');
}