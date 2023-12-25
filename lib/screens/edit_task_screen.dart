import 'package:flutter/material.dart';

// Importing the Task model and TaskFormWidget for task handling.
import '../models/task.dart';
import '../widgets/task_form_widget.dart';

// Screen for editing a specific task.
class EditTaskScreen extends StatelessWidget {
  final Task task; // The task being edited.

  const EditTaskScreen({Key? key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TaskFormWidget(task: task, isEditing: true); // Displaying the task form for editing.
  }
}
