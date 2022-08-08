import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';
import 'package:job_timer/app/modules/entities/project.dart';
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
    emit(state.copyWith(projectModel: project)); //emitindo novo estatus.
  }
}
