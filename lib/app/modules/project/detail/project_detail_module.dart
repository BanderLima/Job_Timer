import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_page.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

//modulo criado, precisa associar ele dentro do project-model., que o o module do projeto.

class ProjectDetailModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectDetailController(projectsService: i()), //appModule
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            final ProjectModel projectModel = args.data;
            return ProjectDetailPage(
              controller: Modular.get()..setProject(projectModel),
            );
          },
        )
      ];
}
