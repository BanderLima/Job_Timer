import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectsService _projectsService;

  HomeController({required ProjectsService projectsService})
      : _projectsService = projectsService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectsService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log("Erro ao buscar os projetos", error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

//implementando o metodo de filter para funcionar os status de em andamento e finalizado.
  Future<void> filter(ProjectStatus status) async {
    //aqui quanto mudar o status ele entra em loading e limpa tela.
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    //aqui ele faz a busca do status dentro do projectservices e emite os estados completados, recebendo o novo projeto com o novo status.
    final projects = await _projectsService.findByStatus(status);
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status,
      ),
    );
  }
}
