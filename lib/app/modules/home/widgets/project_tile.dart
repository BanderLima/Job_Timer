import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  //criando a classe para criar a configuração dessa tela.
  final ProjectModel projectModel;

  const ProjectTile({super.key, required this.projectModel});

  @override //criando as bordas
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('/project/detail', arguments: projectModel);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width:
                  4, //esse exclamação significa force o no null, como sabemos q existe esse padrao de cor no projeto, forçamos o uso dela.
            )),
        child: Column(children: [
          _ProjectName(
              projectModel:
                  projectModel), //fazendo isso, precisa criar esse componente logo a baixo, com atalho stl, mesma coisa no codigo abaixo
          Expanded(child: _ProjectProgress(projectModel: projectModel)),
        ]), //pode esticar ate no máximo 90.
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  //aqui a classe para construir o icon na tela e configurar as posiçoes de texto
  final ProjectModel projectModel;
  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //cada row é um elemento da tela.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
//calculo da soma das tasks
    final totalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);

    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //essa cor para expandir por precisa dentro do build progress, fazer o atalho pro wrap widget...e add o expanded
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            //essa parte da linha progressiva
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400]!,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
                '${projectModel.estimate}h'), //essa parte das horas estimadas.
          )
        ],
      ),
    );
  }
}
