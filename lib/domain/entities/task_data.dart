/// TaskData is an entity class that represents the data of a task.
class TaskData {
  TaskData({
    required this.id,
    required this.title,
    required this.complete,
  });

  final String id;
  final String title;
  final bool complete;
}
