class Task {
  final String name;
  bool isDone;

  Task({this.name, this.isDone = false}); //menset default awal dari isDone yaitu false

  void toggleDone(){
    isDone = !isDone;
  }
}