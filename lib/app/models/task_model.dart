// ignore_for_file: public_member_api_docs, sort_constructors_first

class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      description: task['description'],
      dateTime: DateTime.parse(task['date_time']),
      finished: task['done'] == 1,
    );
  }
}
