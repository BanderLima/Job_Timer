import 'dart:developer';
// import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/auth/auth_service.dart'; //estado inicial da aplicação, note q parte do import está no outro arquivo login_state.

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.signIn();
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }
}
