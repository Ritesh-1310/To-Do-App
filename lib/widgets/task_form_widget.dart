import 'package:flutter/material.dart';

// Importing the Task model and TaskProvider for managing tasks.
import '../models/task.dart';
import '../providers/task_provider.dart';

// Importing Provider for state management.
import 'package:provider/provider.dart';


// A form widget for adding or editing tasks.
class TaskFormWidget extends StatefulWidget {
  final Task? task; // Task being edited, if any.
  final bool isEditing; // Flag to determine if editing or adding a task.

  const TaskFormWidget({Key? key, this.task, required this.isEditing}) : super(key: key);

  @override
  _TaskFormWidgetState createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task?.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Task' : 'Add Task'), // Displaying appropriate title.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Form field for entering task details.
            TextFormField(
              controller: _taskController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Enter your task here',
                fillColor: Colors.grey[200],
                filled: true,
              ),
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20), // Spacer for visual separation.
            ElevatedButton(
              onPressed: () {
                final taskTitle = _taskController.text;
                if (taskTitle.isNotEmpty) {
                  // Handling task addition or update based on editing flag.
                  if (widget.isEditing) {
                    final updatedTask = widget.task!.copyWith(title: taskTitle);
                    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
                  } else {
                    final newTask = Task(
                      userId: 1,
                      id: Provider.of<TaskProvider>(context, listen: false).tasks.length + 1,
                      title: taskTitle,
                      completed: false,
                    );
                    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                  }
                  Navigator.pop(context); // Closing the form after task addition/editing.
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a task title')), // Showing an error if the task title is empty.
                  );
                }
              },
              child: Text(widget.isEditing ? 'Save Changes' : 'Add Task'), // Button text based on editing state.
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
