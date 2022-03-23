import 'usuario.dart';

abstract class AuthenticationService {
  Future<bool> init();

  Future<Usuario> login(String email, String senha);

  Future<void> logout();

  Future<Usuario> cadastrarUsuario(String nomeUsuario, String email, String senha);

  Future<void> resetaSenha(String email);
}
