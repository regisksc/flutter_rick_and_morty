extension ListExtensions on Iterable {
  List<String> get stringifyMembers {
    return map((e) => e.toString()).toList();
  }
}
