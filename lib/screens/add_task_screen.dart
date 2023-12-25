import 'package:flutter/material.dart';

// Importing the TaskFormWidget for task addition.
import '../widgets/task_form_widget.dart';

// Screen for adding a new task.
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return TaskFormWidget(isEditing: false); // Displaying the task form for adding a new task.
  }
}
