import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

// Service class to fetch tasks from an API.
class TaskService {
  // Fetches a list of tasks from a remote API.
  // Throws an exception on failure, including network errors or bad responses.
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((taskJson) => Task.fromJson(taskJson)).toList();
      } else {
        throw Exception('Failed to load tasks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
}
