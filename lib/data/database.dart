import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDolist = [];
  final _todoBox = Hive.box('todoBox');

  // When app is open for the very first time this function is called

  void createInitialData() {
    toDolist = [
      ["Welcome to Think TODO App", false],
      [
        "This is an completely free app for planning your successfull days",
        false
      ]
    ];
  }

  // To load data from the database

  void loadData() {
    toDolist = _todoBox.get("TODOLIST");
  }

// To update the database

  void updateDataBase() {
    _todoBox.put("TODOLIST", toDolist);
  }
}
