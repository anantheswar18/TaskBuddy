import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:think_todo_list/constants/const.dart';
import 'package:think_todo_list/data/database.dart';

class OfficeHomePage extends StatefulWidget {
  const OfficeHomePage({super.key});

  @override
  State<OfficeHomePage> createState() => _OfficeHomePageState();
}

class _OfficeHomePageState extends State<OfficeHomePage> {
  final _todoBox = Hive.box('todoBox');
  ToDoDatabase db = ToDoDatabase();
  TextEditingController controller = TextEditingController();
  String selectedPriority = 'Medium'; // Default priority

  // Dark theme colors
  final Color primaryBlue = const Color(0xFF2196F3); // Bright blue for accents
  final Color darkBg = const Color(0xFF121212); // Very dark background
  final Color cardBg = const Color(0xFF1E1E1E); // Dark card background
  final Color surfaceBg = const Color(0xFF252525); // Slightly lighter surface
  final Color textColor = const Color(0xFFE0E0E0); // Light text color
  final Color secondaryTextColor = const Color(0xFFAAAAAA); // Secondary text

  final Map<String, Color> priorityColors = {
    'High': Colors.redAccent,
    'Medium': Colors.blueAccent,
    'Low': Colors.blueAccent.withOpacity(0.6),
  };

  @override
  void initState() {
    // when the app is loading very first time
    if (_todoBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // There data already exist
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
    db.updateDataBase();
  }

  int getCompletedCount() {
    return db.toDolist.where((task) => task[1] == false).length;
  }

  void saveNewTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      // Add task with priority: [task name, isCompleted, priority]
      db.toDolist.add([controller.text, false, selectedPriority]);
      controller.clear();
      selectedPriority = 'Medium'; // Reset to default
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDataBase();
  }

  void createNewTask() {
    controller.text = "";
    selectedPriority = 'Medium';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: surfaceBg,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Task text field
                  TextField(
                    controller: controller,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Enter your task',
                      hintStyle: TextStyle(color: secondaryTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryBlue, width: 2),
                      ),
                      filled: true,
                      fillColor: cardBg,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Priority selection
                  Text(
                    'Priority Level',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Priority buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['High', 'Medium', 'Low'].map((priority) {
                      bool isSelected = selectedPriority == priority;
                      return InkWell(
                        onTap: () {
                          setDialogState(() {
                            selectedPriority = priority;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? priorityColors[priority]! : cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? priorityColors[priority]!
                                  : Colors.grey.shade600,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            priority,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.white : textColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: secondaryTextColor),
                ),
              ),
              ElevatedButton(
                onPressed: saveNewTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Add Task'),
              ),
            ],
          );
        });
      },
    );
  }

  void editTask(int index) {
    controller.text = db.toDolist[index][0];
    selectedPriority =
        db.toDolist[index].length > 2 ? db.toDolist[index][2] : 'Medium';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: surfaceBg,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Edit Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Task text field
                  TextField(
                    controller: controller,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Enter your task',
                      hintStyle: TextStyle(color: secondaryTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryBlue, width: 2),
                      ),
                      filled: true,
                      fillColor: cardBg,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Priority selection
                  Text(
                    'Priority Level',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Priority buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['High', 'Medium', 'Low'].map((priority) {
                      bool isSelected = selectedPriority == priority;
                      return InkWell(
                        onTap: () {
                          setDialogState(() {
                            selectedPriority = priority;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? priorityColors[priority]! : cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? priorityColors[priority]!
                                  : Colors.grey.shade600,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            priority,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.white : textColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: secondaryTextColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    db.toDolist[index][0] = controller.text;
                    db.toDolist[index][2] = selectedPriority;
                    controller.clear();
                    selectedPriority = 'Medium';
                  });
                  Navigator.of(context).pop();
                  db.updateDataBase();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // AI Assistant button
          FloatingActionButton(
            heroTag: "btn1",
            shape: const CircleBorder(),
            onPressed: () {},
            backgroundColor: surfaceBg,
            foregroundColor: primaryBlue,
            child: const Text(
              '🤖',
              style: TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 16),
          // Add task button
          FloatingActionButton(
            heroTag: "btn2",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () => createNewTask(),
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Enhanced app bar
          SliverAppBar(
            backgroundColor: cardBg,
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                '📃 Office ToDo 📃',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [primaryBlue.withOpacity(0.7), Colors.black],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 60.0),
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: 70.0,
                      color: primaryBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Priority legend
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: surfaceBg,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPriorityIndicator('High', priorityColors['High']!),
                  _buildPriorityIndicator('Medium', priorityColors['Medium']!),
                  _buildPriorityIndicator('Low', priorityColors['Low']!),
                ],
              ),
            ),
          ),

          // Task count header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Tasks',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${db.toDolist.length} tasks',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: surfaceBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${getCompletedCount()} Remaining',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Task list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Get task priority or set default to 'Medium' for backward compatibility
                String priority = db.toDolist[index].length > 2
                    ? db.toDolist[index][2]
                    : 'Medium';

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    color: cardBg,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: priorityColors[priority]!.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    child: Dismissible(
                      // Use Dismissible here
                      key: Key(db.toDolist[index][0]),
                      background: Container(
                        decoration: BoxDecoration(
                          color: primaryBlue
                              .withOpacity(0.7), // Background for edit
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        // Use secondaryBackground
                        decoration: BoxDecoration(
                          color: Colors.red.shade300, // Background for delete
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction:
                          DismissDirection.horizontal, // Allow both directions
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          // Show edit dialog
                          editTask(index);
                          return false; // Prevent Dismissible from completing
                        } else {
                          // Show delete confirmation
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: surfaceBg,
                              title: Text(
                                'Are you sure?',
                                style: TextStyle(color: textColor),
                              ),
                              content: Text(
                                'Do you want to delete this task?',
                                style: TextStyle(color: secondaryTextColor),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false), // No
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: secondaryTextColor),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true), // Yes
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          // Only delete if the user swiped to the end
                          deleteTask(index);
                        }
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: db.toDolist[index][1],
                            onChanged: (value) => checkBoxChange(value, index),
                            activeColor: primaryBlue,
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return primaryBlue;
                                }
                                return Colors.grey.shade700;
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        title: Text(
                          db.toDolist[index][0],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: db.toDolist[index][1]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: db.toDolist[index][1]
                                ? secondaryTextColor
                                : textColor,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: priorityColors[priority]!.withOpacity(0.7),
                            ),
                          ),
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: priorityColors[priority],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: db.toDolist.length,
            ),
          ),
          // Footer padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
