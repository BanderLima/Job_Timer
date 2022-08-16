import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';

import 'package:job_timer/app/view_models/project_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectsService _projectsService;

  ProjectDetailController({required ProjectsService projectsService})
      : _projectsService = projectsService,
        super(const ProjectDetailState.initial());

  void setProject(ProjectModel projectModel) {
    emit(state.copyWith(
        projectModel: projectModel, status: ProjectDetailStatus.complete));
  }

  //regra de atualizaçao de tela
  Future<void> updateProject() async {
    final project =
        await _projectsService.findById(state.projectModel!.id!); //buscando
    emit(state.copyWith(
        projectModel: project,
        status: ProjectDetailStatus.complete)); //emitindo novo estatus.
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectModel!
          .id!; //essas exclamações força para q nao seja nulo esses campos...
      await _projectsService.finish(projectId);
      updateProject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
