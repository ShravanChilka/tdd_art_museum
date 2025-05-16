import 'dart:io';

class Fixture {
  const Fixture._();

  static Future<String> fromPath(String path) async {
    return await File(path).readAsString();
  }
}
