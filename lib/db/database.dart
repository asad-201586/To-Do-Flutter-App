import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {

  final KEY_TODOLIST = "TODOLIST";

  // list
  List toDoList = [];

  //reference the box
  final _box = Hive.box('ToDoBox');

  // run this method when the app is first time opened
  void createInitialData() {
    toDoList = [
        ["Learn Flutter Tutorial",false],
        ["Do Excercise",false],
    ];
  }

  void loadData() {
    toDoList = _box.get(KEY_TODOLIST);
  }

  void updateDatabase() {
    _box.put(KEY_TODOLIST, toDoList);
  }
}