import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:think_todo_list/constants/const.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext) deleteFunction;

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width;
    double h = screenSize.height;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(8),
            onPressed: (context) => deleteFunction(context),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: tileColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
                checkColor: Colors.white,
              ),
              SizedBox(
                width: w / 2,
                child: Text(
                  taskName,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor:
                        taskCompleted ? Colors.black : Colors.transparent,
                    decorationThickness: 3,
                    color: mainTextColor,
                    fontSize: 18,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
