import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importing the provider class for managing tasks.
import 'providers/task_provider.dart';

// Importing the screen where the task list will be displayed.
import 'screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

// The main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Providing the TaskProvider to the entire app.
      create: (context) => TaskProvider(),
      child: MaterialApp(
        // Setting the application title.
        title: 'To-Do App',
        // Hiding the debug banner in the top-right corner.
        debugShowCheckedModeBanner: false,
        // Defining the primary theme color for the app.
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Setting the initial screen as the TaskListScreen.
        home: TaskListScreen(),
      ),
    );
  }
}
