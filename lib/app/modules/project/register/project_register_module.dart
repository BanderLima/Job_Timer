import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:job_timer/app/modules/project/register/project_register_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectRegisterModule extends Module {
  //configuração da rota

  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
            (i) => ProjectRegisterController(projectsService: i())) //appmodule
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ProjectRegisterPage(
            controller: Modular.get(),
          ),
        ),
      ];
}
