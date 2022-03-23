import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'authentication_exception.dart';
import 'autenticador.dart';
import 'usuario.dart';

class FirebaseAutenticador implements Autenticador {
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
      final UserCredential credential = await _auth.signInWithEmailAndPassword(email: login, password: password);

      final Usuario usuario = Usuario(credential.user!.displayName!);

      return usuario;
    } on FirebaseAuthException catch (e) {
      final String mensagem = _traduzMensagem(e.code, e.message);

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<Usuario> cadastrarUsuario(String nomeUsuario, String email, String senha) async {
    try {
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      await credential.user!.updateDisplayName(nomeUsuario);

      final Usuario usuario = Usuario(nomeUsuario);

      return usuario;
    } on FirebaseAuthException catch (e) {
      final String mensagem = _traduzMensagem(e.code, e.message);

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<void> resetaSenha(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final String mensagem = _traduzMensagem(e.code, e.message);

      throw AuthenticationException(mensagem);
    }
  }

  @override
  Future<void> logout() {
    return _auth.signOut();
  }

  String _traduzMensagem(String codigo, String? mensagem) {
    String mensagemNova;

    switch (codigo) {
      case 'invalid-email':
        mensagemNova = 'Endereço de e-mail inválido.\n\nDeve estar no formato xxx@yyyy.com !';
        break;
      case 'email-already-in-use':
        mensagemNova = 'Email já em uso !\nSe você é dono deste e-mail, pode escolher a opção \'Esqueci a Senha\'';
        break;
      case 'network-request-failed':
        mensagemNova = 'Um erro de rede (timeout, conexão interrompida ou host inalcançavel) ocorreu !';
        break;
      case 'user-not-found':
        mensagemNova = 'Usuário não encontrado !\n\nVerifique se digitou o endereço de e-mail corretamente.';
        break;
      case 'weak-password':
        mensagemNova = 'A senha é muito fraca !';
        break;
      case 'wrong-password':
        mensagemNova = 'Senha errada fornecida para este usuário !';
        break;

      default:
        mensagemNova = mensagem ?? 'Erro código [$codigo]';
    }

    return mensagemNova;
  }
}
