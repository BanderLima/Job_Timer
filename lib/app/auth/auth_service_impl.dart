import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_service.dart';

class AuthServiceImpl implements AuthService {
  // esse codigo é a autenticação do email junto com o google, e login automático
  @override
  Future<void> signIn() async {
    final googleUser = await GoogleSignIn()
        .signIn(); //essa linha de codigo faz abrir a tela para escolha do email.
    //essa interrogação é indicando que se ele não for nulo
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override // logout
  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  } //apos isso , é necessário configurar o bind no app.module----
}
