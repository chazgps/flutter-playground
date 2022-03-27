abstract class TTS {
  Future<void> init();
  bool get isInitialized;
  List<String> getInstalledLangages();
  String getDefaultLanguage();
  Future<void> setLanguage(String language);
  Future<void> setSpeed(double speed);
  Future<void> setVolume(double volume);
  Future<void> setPitch(double pitch);
  Future<void> speak(String sentence);
}
