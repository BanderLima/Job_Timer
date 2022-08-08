import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/splash/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context)
        .size; //isso aqui é o espaçamento entre a imagem e o imput na tela de login.
    //criando a var que vai pegar todo o contexto do tamanho e aplicar em porcentagem.
    //aqui to to habilitando isso, so isso nao faz nada. Ver var abaixo.

    // essa parte do codigo fica ouvindo a mudança de estado.
    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: ((previous, current) => previous.status != current.status),
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ??
              'Erro ao realizar login'; // se for nula, mostra essa mensagem.
          AsukaSnackbar.alert(message).show();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF0092B9),
                Color(0XFF0167B2),
              ],
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(
                height: screenSize.height *
                    .1, // aqui que é usada, e dessa forma. 1 quer dizer 10% e assim por diante.
              ),
              SizedBox(
                width: screenSize.width *
                    .8, //aqui a mesma coisa, esta pegando e colando o tamanho do imput.
                height: 49, // aqui a largura dele.
                child: ElevatedButton(
                  // isso que cria o botao de imput.
                  onPressed: () {
                    controller.signIn();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                  child: Image.asset('assets/images/google.png'),
                ),
              ),
              //Configuração para mostrar o estado.
              BlocSelector<LoginController, LoginState, bool>(
                bloc: controller,
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, show) {
                  return Visibility(
                    visible: show,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
