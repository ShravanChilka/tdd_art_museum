import 'package:flutter/material.dart';
import 'package:tdd_art_museum/application.dart';
import 'package:tdd_art_museum/core/di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupLocator();
  runApp(Application());
}
