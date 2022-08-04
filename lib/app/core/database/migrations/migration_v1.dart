import 'package:sqflite/sqflite.dart';
import 'package:todo_list/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo(
        id Interge primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado interge
      )
    ''');
  }

  @override
  void update(Batch batch) {
    // TODO: implement update
  }
}
