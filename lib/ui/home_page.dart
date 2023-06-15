import 'package:flutter/material.dart';
import 'dialog/dialog_box_add_task.dart';
import 'items/item_to_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ["Flutter Tutorial", true],
    ["Daily 5 Hadis", true],
    ["Daily 5 times Salah", true],
  ];

  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  final _textController = TextEditingController();

  void onSave() {
    setState(() {
      toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          "To Do App",
          style: TextStyle(color: Colors.yellow[800]),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoListItem(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkboxChanged(toDoList[index][1], index),
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
