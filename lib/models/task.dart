class Task {
  final int userId; // The ID of the user associated with the task
  final int id; // The unique identifier for the task
  final String title; // The title or description of the task
  final bool completed; // Indicates if the task is completed or not

  Task({
    required this.userId, // Constructor parameter for user ID
    required this.id, // Constructor parameter for task ID
    required this.title, // Constructor parameter for task title
    required this.completed, // Constructor parameter for task completion status
  });

  // Creates a new Task object with updated values.
  // Returns a new Task object with the provided values if they are not null,
  // otherwise retains the current values.
  Task copyWith({
    int? userId, // Updated user ID
    int? id, // Updated task ID
    String? title, // Updated task title
    bool? completed, // Updated task completion status
  }) {
    return Task(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
  
  // Creates a Task object from JSON data.
  // Expects a Map<String, dynamic> containing the task's attributes.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
}
