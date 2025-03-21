import 'package:flutter/material.dart';
import 'package:think_todo_list/constants/const.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteShade,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task ...."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: onSave,
                  color: appBarColor,
                  child: Text("Save"),
                ),
                SizedBox(
                  width: 8,
                ),
                MaterialButton(
                  onPressed: onCancel,
                  color: appBarColor,
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
