class Conversor {
  static double getPoundsFromKilos(double kilos) {
    return kilos * 2.205;
  }

  static double getFeetsFromMetros(double metros) {
    return metros * 3.28084;
  }

  static double getKilosFromPounds(double pounds) {
    return pounds / 2.205;
  }

  static double getMetrosFromFeets(double feets) {
    return feets / 3.28084;
  }
}
