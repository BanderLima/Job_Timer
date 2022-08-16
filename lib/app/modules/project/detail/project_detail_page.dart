import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

//essa é a outra tela, de detalhes, quando clicado no projeto criado, abre essa tela.

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;

  const ProjectDetailPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Erro interno');
          }
        },
        builder: (context, state) {
          final projectModel = state.projectModel;

          switch (state.status) {
            // codições de estado.
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando projeto'),
              );

            case ProjectDetailStatus.loading:
              return const Center(
                child:
                    CircularProgressIndicator(), //bolinha de carregamento de load
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);

            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                return _buildProjectDetail(context, projectModel);
              }
              return const Center(
                child: Text('Erro ao carregar projeto'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    final totalTasks = projectModel.tasks.fold<int>(0, (totalValue, task) {
      return totalValue += task.duration;
    });

    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(
          projectModel: projectModel,
        ),
        SliverList(
          //essa cara q tem a rolagem...
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50),
              child: ProjectPieChart(
                  projectEstimate: projectModel.estimate,
                  totalTasks: totalTasks),
            ),
            ...projectModel
                .tasks // essa parte q faz com que os nomes das tasks apareçam no tela.
                .map(
                  (task) => ProjectTaskTile(
                    task: task,
                  ),
                )
                .toList(),
          ]),
        ),
        SliverFillRemaining(
          //aqui eu to falando q ele nao tem scroll, por isso false.
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Visibility(
                visible: projectModel.status != ProjectStatus.finalizado,
                child: ElevatedButton.icon(
                    onPressed: () {
                      controller.finishProject();
                    },
                    icon: const Icon(JobTimerIcons.ok_circled2),
                    label: const Text('Finalizar Projeto')),
              ),
            ),
          ),
        ) //esse Sliverremain utiliza o resto da tela, usar sempre no fim das telas, ai so add o que quer pra ficar no fim.
      ],
    );
  }
}
