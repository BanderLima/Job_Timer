import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/auth/auth_service.dart';
import 'package:job_timer/app/auth/auth_service_impl.dart';
import 'package:job_timer/app/auth/projects/projects_service.dart';
import 'package:job_timer/app/auth/projects/projects_service_impl.dart';
import 'package:job_timer/app/core/ui/database/database.dart';
import 'package:job_timer/app/core/ui/database/database_impl.dart';
import 'package:job_timer/app/modules/home/home_module.dart';
import 'package:job_timer/app/modules/project/project_module.dart';
import 'package:job_timer/app/modules/splash/login/login_module.dart';
import 'package:job_timer/app/modules/splash/splash_page.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/repositories/projects/project_repository_impl.dart';

class AppModule extends Module {
  @override // nessa parte q é adicionado os binds, exemplo, a altenticação do email junto ao google.
  List<Bind> get binds => [
        Bind.lazySingleton<AuthService>((i) => AuthServiceImpl()),
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),
        Bind.lazySingleton<ProjectRepository>(
            (i) => ProjectRepositoryImpl(database: i())),
        Bind.lazySingleton<ProjectsService>(
            (i) => ProjectsServiceImpl(projectRepository: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/project', module: ProjectModule()),
      ];
}
