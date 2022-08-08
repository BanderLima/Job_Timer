import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _projectModel;
  final ProjectsService _projectsService;

  TaskController({required ProjectsService projectsService})
      : _projectsService = projectsService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(name: name, duration: duration);
      await _projectsService.addTask(_projectModel.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
