import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

// se tem formulário na tela, precisa de um StateFulWidget, atalho alt + enter.
class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<
      FormState>(); //form global e add no body ela. Esse underline significa que é privado.
  final _nameEC =
      TextEditingController(); //essas variaveis vao entrar nos formularios criados abaixo...procura ai elas.
  final _estimateEC = TextEditingController();

  @override
  //noa sei ainda pra q serve, mas precisa disso aqio ...kkk
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            Navigator.pop(context); // navegar para tela anterior
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar projeto').show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                  validator: Validatorless.required(//validaçoes dos formulários
                      'Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _estimateEC,
                  //isso aqui faz com que somente seja digitado numeros no formulário.
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                  validator: Validatorless.multiple([
                    //validaçoes dos formulários
                    Validatorless.required('Estimativa obrigatória'),
                    Validatorless.number('Permitido somento números'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height:
                      49, //isso q da o tamanho do botao em relacao ao comprimento de tela. Se for alterar , add no cod * .tamanho que quer.
                  child: ButtonWithLoader<ProjectRegisterController,
                      ProjectRegisterStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () async {
                      final formValid = _formKey.currentState?.validate() ??
                          false; // se for nulo ele é false, entao vai mostrar as mensagens acima.

                      if (formValid) {
                        final name = _nameEC.text;
                        final estimate = int.parse(_estimateEC.text);

                        await widget.controller.register(name, estimate);
                      } // e se for true, ele vai fazer algo...
                    },
                    label: 'Salvar',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
