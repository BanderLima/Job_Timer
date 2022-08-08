import 'package:isar/isar.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';

//Esse codigo que fará a converção do banco de dados pro status. Uma coluna pra uma classe.

class ProjectStatusConverter extends TypeConverter<ProjectStatus, int> {
  const ProjectStatusConverter();

  @override
  ProjectStatus fromIsar(int object) {
    return ProjectStatus.values[object];
  }

  @override
  int toIsar(ProjectStatus object) {
    return object.index;
  }
}
