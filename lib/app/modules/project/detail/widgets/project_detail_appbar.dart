import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({required ProjectModel projectModel, super.key})
      : super(
          expandedHeight: 100, // tamanho de tipo nav-bar.
          pinned: true, //quando move a tela pra cima, ele fica fixo no final.
          toolbarHeight: 100, //centraliza os itens
          title: Text(projectModel.name),
          centerTitle: true, // centraliza o titulo na tela.
          shape: const RoundedRectangleBorder(
              //para arredondar as bordas, apenas as do bottom.
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0,
                    1.6), //eixo x como primeiro parametro, e o seguindo é a parte que ajusta o container para baixo na tela
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    //faz com que apareça esse container elevado em relação ao background.
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, //isso  esta jogando o icone de + para a esquerda da tela.
                        children: [
                          Text('${projectModel.tasks.length} tasks'),
                          Visibility(
                            //esse codigo que faz com que só deixe visível esse texto acima quando for true nessa condiçao abaixo.
                            visible:
                                projectModel.status != ProjectStatus.finalizado,
                            replacement: const Text('Projeto Finalizado'),
                            child: _NewTasks(projectModel: projectModel),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}

class _NewTasks extends StatelessWidget {
  final ProjectModel projectModel;

  const _NewTasks({Key? key, required this.projectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //atualização de tela, await.
      onTap: () async {
        await Modular.to.pushNamed('/project/task/', arguments: projectModel);
        Modular.get<ProjectDetailController>()
            .updateProject(); //após criada a regra, essa é a chamada da atualização da tela.
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text('Adicionar Tasks')
        ],
      ),
    );
  }
}
