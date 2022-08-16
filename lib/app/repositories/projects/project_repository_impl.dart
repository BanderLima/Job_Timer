import 'dart:developer' as developer;
import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/ui/database/database.dart';
import 'package:job_timer/app/core/ui/exception/failure.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';
import 'package:job_timer/app/modules/entities/project_task.dart';

import '../../modules/entities/project.dart';
import './project_repository.dart';

//toda parte de conexao com banco de dados é feita aqui nos arquivos de repositorys.

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();

      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      developer.log('Erro ao cadastrar projeto', error: e, stackTrace: s);
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();

    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final project = await findById(projectId);

    project.tasks.add(task);
    connection.writeTxn(
      (isar) => project.tasks.save(),
    );

    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);

    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }
    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConnection(); //abrindo a conexao
      final project = await findById(projectId); //buscando o projeto pelo id
      project.status =
          ProjectStatus.finalizado; // alterando o estatus para finalizado
      await connection.writeTxn(
        (isar) => connection.projects.put(project, saveLinks: true),
      );
    } on IsarError catch (e, s) {
      //tratamento de erro com a conexao com banco de dados
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
