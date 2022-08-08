import 'package:isar/isar.dart';
import 'package:job_timer/app/modules/entities/project.dart';
import 'package:job_timer/app/modules/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

import './database.dart';

//Implementando banco de dados ISAR DART ou instanciando o classe de banco de dados.

class DatabaseImpl implements Database {
  Isar? _dataBaseInstance;

  @override
  Future<Isar> openConnection() async {
    if (_dataBaseInstance == null) {
      final dir = await getApplicationSupportDirectory();
      _dataBaseInstance = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return _dataBaseInstance!;
  }
}
