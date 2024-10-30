import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ref the hive box
  final mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  final controller = TextEditingController();

  @override
  void initState() {
    // if this is the 1st time ever openin, create default data
    if (mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // already exist data
      db.loadData();
    }

    super.initState();
  }

  void checkeBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${db.toDoList[index][0]} deleted',
        ),
        duration: const Duration(
          seconds: 2,
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.endToStart,
        elevation: 0,
      ),
    );

    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        elevation: 0,
        title: const Text('TO DO'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          return TodoTile(
            taskName: db.toDoList[i][0],
            taskCompleted: db.toDoList[i][1],
            onCheckBoxChanged: (value) => checkeBoxChanged(value, i),
            onTaskDeleted: (p0) => deleteTask(i),
          );
        },
        itemCount: db.toDoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
    );
  }
}
