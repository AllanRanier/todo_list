import 'package:sqflite/sqflite.dart';
import 'package:todo_list/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description VARCHAR(500) NOT NULL,
        date_time DATETIME,
        done INTEGER
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
}