import 'package:flutter/material.dart';
import 'package:tdd_art_museum/modules/artwork/view/artwork_screen_provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: ArtworkScreenProvider(),
    );
  }
}
