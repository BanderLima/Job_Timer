import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/app_module.dart';
import 'package:job_timer/app/app_widget.dart';
import 'package:job_timer/firebase_options.dart';

Future<void> main() async {
  // para iniciar a aplicação
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); //carregar a plataforma

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
