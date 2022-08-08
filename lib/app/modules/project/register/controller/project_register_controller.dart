import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectsService _projectsService;

  ProjectRegisterController({required ProjectsService projectsService})
      : _projectsService = projectsService,
        super(ProjectRegisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    emit(ProjectRegisterStatus.loading);
    try {
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.em_andamento,
        tasks: [],
      );
      await _projectsService.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
