enum Flavor {
  dev,
  qa,
  prod,
}

class AppFlavor {
  static Flavor? current;

  static String get title {
    switch (current) {
      case Flavor.dev:
        return 'Characters (Dev)';
      case Flavor.qa:
        return 'Characters (Testing)';
      case Flavor.prod:
        return 'Characters (Prod)';
      default:
        return 'title';
    }
  }
}
