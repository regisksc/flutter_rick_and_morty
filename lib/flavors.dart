enum Flavor {
  dev,
  qa,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Rick and Morty Characters (Dev)';
      case Flavor.qa:
        return 'Rick and Morty Characters (Testing)';
      case Flavor.prod:
        return 'Rick and Morty Characters (Prod)';
      default:
        return 'title';
    }
  }
}
