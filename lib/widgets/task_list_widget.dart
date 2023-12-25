import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importing the screens needed for this widget.
import 'package:todo_app/screens/edit_task_screen.dart';

// Importing the TaskProvider for task management.
import '../providers/task_provider.dart';

// A widget displaying a list of tasks.
class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    // Accessing the TaskProvider using Provider.
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      body: tasks.isEmpty
          ? Center(child: CircularProgressIndicator()) // Display a loading indicator if tasks are empty.
          : Stack(
              children: [
                ListView.builder(
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == tasks.length) {
                      return SizedBox(height: 80); // Placeholder height for the last task.
                    }
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.completed,
                            onChanged: (value) {
                              taskProvider.toggleTaskCompletion(task.id, value ?? false);
                            },
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: task.completed ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTaskScreen(task: task),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(task: tasks.last),
                        ),
                      );
                    },
                    child: Container(
                      height: 60, // Height of the task container.
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: const Text(
                        '', // Placeholder text or empty text for the last task.
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}