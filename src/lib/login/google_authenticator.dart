import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_exception.dart';
import 'login_authenticator.dart';

class GoogleAuthenticator implements AuthenticationService {
  late FirebaseAuth _auth;

  GoogleAuthenticator(FirebaseAuth auth) {
    _auth = auth;
  }

  @override
  Future<void> login(String login, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: login, password: password);
    } on FirebaseAuthException catch (e) {
      String? mensagem;

      switch (e.code) {
        case 'user-not-found':
          mensagem = 'Usuário não encontrado !';
          break;
        case 'wrong-password':
          mensagem = 'Senha errada fornecida para este usuário !';
          break;
        case 'invalid-email':
          mensagem = 'Usuário fornecido precisa ser um endereço de e-mail !';
          break;
        default:
          mensagem = e.toString();
      }

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<void> cadastrarUsuario(String nomeUsuario, String email, String senha) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      await credential.user!.updateDisplayName(nomeUsuario);
    } on FirebaseAuthException catch (e) {
      String? mensagem;

      switch (e.code) {
        case 'weak-password':
          mensagem = 'A senha é muito fraca !';
          break;
        case 'email-already-in-use':
          mensagem = 'Email já em uso !\nSe você é dono deste e-mail, pode escolher a opção \'Esqueci a Senha\'';
          break;
        default:
          mensagem = e.toString();
      }

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<void> logout() {
    return _auth.signOut();
  }
}
