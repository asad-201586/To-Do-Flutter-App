import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_flutter/db/database.dart';
import 'dialog/dialog_box_add_task.dart';
import 'items/item_to_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List toDoList = [
  //   ["Flutter Tutorial", true],
  //   ["Daily 5 Hadis", true],
  //   ["Daily 5 times Salah", true],
  // ];

  final _box = Hive.box("ToDoBox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    super.initState();
    if(_box.get(db.KEY_TODOLIST) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }


  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  final _textController = TextEditingController();

  void onSave() {
    setState(() {
      db.toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text(
          "To Do App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoListItem(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(db.toDoList[index][1], index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }
}
