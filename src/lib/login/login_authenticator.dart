abstract class AuthenticationService {
  Future<void> login(String email, String senha);

  Future<void> logout();

  Future<void> cadastrarUsuario(String nomeUsuario, String email, String senha);
}
