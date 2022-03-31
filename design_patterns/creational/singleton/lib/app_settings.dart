class AppSettings {
  // Instancia um objeto da classe e mantém a instância privada
  static final AppSettings _singleton = AppSettings._internal();

  // Retorna sempre a mesma instância
  factory AppSettings() => _singleton;

  // Define um construtor privado
  AppSettings._internal();
}
