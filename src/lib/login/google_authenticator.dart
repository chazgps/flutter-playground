import 'package:firebase_auth/firebase_auth.dart';

import 'login_authenticator.dart';

class GoogleAuthenticator implements LoginAuthenticator {
  late FirebaseAuth _auth;

  GoogleAuthenticator(FirebaseAuth auth) {
    _auth = auth;
  }

  @override
  Future<void> authenticate(String login, String password) async {
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

      throw Exception(mensagem);
    }
  }
}
