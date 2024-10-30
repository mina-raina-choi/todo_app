import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final myBox = Hive.box('mybox');

  // first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Make Tea", false]
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = myBox.get('TODOLIST');
  }

  // update the db
  void updateDataBase() {
    myBox.put('TODOLIST', toDoList);
  }
}
