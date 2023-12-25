import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  final TaskService _taskService = TaskService();

  // Fetches tasks from a remote data source asynchronously.
  // Handles different exceptions such as SocketException and FormatException,
  // providing specific error messages for each case.
  Future<void> fetchTasks() async {
    try {
      _tasks = await _taskService.fetchTasks();
      notifyListeners();
    } catch (e) {
      if (e is SocketException) {
        throw 'No internet connection'; // Handle no internet error
      } else if (e is FormatException) {
        throw 'Invalid data format'; // Handle invalid API response format error
      } else {
        throw 'Failed to load tasks';
      }
    }
  }

  // Adds a new task to the task list.
  // Inserts the task at the beginning of the list and notifies listeners.
  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  // Updates an existing task in the task list.
  // Finds the task by its ID, replaces it with the updated task, and notifies listeners.
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Toggles the completion status of a task in the task list.
  // Finds the task by its ID and updates its completion status.
  // Notifies listeners of the change.
  void toggleTaskCompletion(int taskId, bool completed) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(completed: completed);
      notifyListeners();
    }
  }
}
