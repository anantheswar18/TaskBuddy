// import 'package:hive_flutter/hive_flutter.dart';

// class ToDoDatabase {
//   List toDolist = [];
//   final _todoBox = Hive.box('todoBox');

//   // When app is open for the very first time this function is called

//   void createInitialData() {
//     toDolist = [
//       ["Welcome to Think TODO App", false],
//       [
//         "This is an completely free app for planning your successfull days",
//         false
//       ]
//     ];
//   }

//   // To load data from the database

//   void loadData() {
//     toDolist = _todoBox.get("TODOLIST");
//   }

// // To update the database

//   void updateDataBase() {
//     _todoBox.put("TODOLIST", toDolist);
//   }
// }

import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  // Two separate lists for different todo lists
  List mainToDoList = [];
  List secondaryToDoList = [];

  // Two separate Hive boxes
  final _mainTodoBox = Hive.box('mainTodoBox');
  final _secondaryTodoBox = Hive.box('secondaryTodoBox');

  // Create initial data for the main todo list
  void createInitialMainData() {
    mainToDoList = [
      ["Welcome to Think TODO App", false],
      ["This is a completely free app for planning your successful days", false]
    ];
  }

  // Create initial data for the secondary todo list
  void createInitialSecondaryData() {
    secondaryToDoList = [
      ["Secondary List Item 1", false],
      ["Secondary List Item 2", false]
    ];
  }

  // Load data for the main todo list
  void loadMainData() {
    mainToDoList = _mainTodoBox.get("MAIN_TODOLIST") ?? [];
  }

  // Load data for the secondary todo list
  void loadSecondaryData() {
    secondaryToDoList = _secondaryTodoBox.get("SECONDARY_TODOLIST") ?? [];
  }

  // Update the main todo list database
  void updateMainDatabase() {
    _mainTodoBox.put("MAIN_TODOLIST", mainToDoList);
  }

  // Update the secondary todo list database
  void updateSecondaryDatabase() {
    _secondaryTodoBox.put("SECONDARY_TODOLIST", secondaryToDoList);
  }

  // Optional: Method to check if either database is empty
  bool isMainDatabaseEmpty() {
    return mainToDoList.isEmpty;
  }

  bool isSecondaryDatabaseEmpty() {
    return secondaryToDoList.isEmpty;
  }
}
