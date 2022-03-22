import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'authentication_exception.dart';
import 'login_authenticator.dart';
import 'usuario.dart';

class GoogleAuthenticator implements AuthenticationService {
  late FirebaseAuth _auth;

  @override
  Future<bool> init() async {
    try {
      final FirebaseApp firebaseApp = await Firebase.initializeApp();

      final List<FirebaseApp> apps = Firebase.apps;
      debugPrint('Currently initialized apps: $apps');

      final FirebaseOptions options = firebaseApp.options;
      debugPrint('Current options for app: $options');

      _auth = FirebaseAuth.instanceFor(app: firebaseApp);

      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          debugPrint('authStateChanges: User is currently signed out!');
        } else {
          debugPrint('authStateChanges: User is signed in!');
        }
      });

      _auth.idTokenChanges().listen((User? user) {
        if (user == null) {
          debugPrint('idTokenChanges: User is currently signed out!');
        } else {
          debugPrint('idTokenChanges: User is signed in!');
        }
      });

      _auth.userChanges().listen((User? user) {
        if (user == null) {
          debugPrint('userChanges: User is currently signed out!');
        } else {
          debugPrint('userChanges: User is signed in!');
        }
      });

      return true;
    } catch (e) {
      debugPrint('Firebase init: ' + e.toString());
      return false;
    }
  }

  @override
  Future<Usuario> login(String login, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: login, password: password);

      Usuario usuario = Usuario(credential.user!.displayName!);

      return usuario;
    } on FirebaseAuthException catch (e) {
      String? mensagem;

      switch (e.code) {
        case 'user-not-found':
          mensagem = 'Usuário não encontrado !\n\nVerifique se digitou o endereço de e-mail corretamente.';
          break;
        case 'wrong-password':
          mensagem = 'Senha errada fornecida para este usuário !';
          break;
        case 'invalid-email':
          mensagem = 'Endereço de e-mail inválido.\n\nDeve estar no formato xxx@yyyy.com !';
          break;
        default:
          mensagem = e.toString();
      }

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<Usuario> cadastrarUsuario(String nomeUsuario, String email, String senha) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      await credential.user!.updateDisplayName(nomeUsuario);

      Usuario usuario = Usuario(nomeUsuario);

      return usuario;
    } on FirebaseAuthException catch (e) {
      String? mensagem;

      switch (e.code) {
        case 'invalid-email':
          mensagem = 'O endereço de e-mail está mal-formatado !';
          break;
        case 'weak-password':
          mensagem = 'A senha é muito fraca !';
          break;
        case 'email-already-in-use':
          mensagem = 'Email já em uso !\nSe você é dono deste e-mail, pode escolher a opção \'Esqueci a Senha\'';
          break;
        case 'nnetwork-request-failed':
          mensagem = 'Um erro de rede (timeout, conexão interrompida ou host inalcançavel) ocorreu !';
          break;
        default:
          mensagem = e.message ?? 'Erro código [$e.code]';
      }

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<void> logout() {
    return _auth.signOut();
  }
}
