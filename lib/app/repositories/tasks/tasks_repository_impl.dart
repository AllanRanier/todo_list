import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todos', {
      'id': null,
      'description': description,
      'date_time': date.toIso8601String(),
      'done': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select *
      from todos
      where date_time between ? and ?
      order by date_time
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
}
