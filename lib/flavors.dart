enum Flavor {
  DEV,
  QA,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Rick and Morty Characters (Dev)';
      case Flavor.QA:
        return 'Rick and Morty Characters (Testing)';
      case Flavor.PROD:
        return 'Rick and Morty Characters (Prod)';
      default:
        return 'title';
    }
  }

}
