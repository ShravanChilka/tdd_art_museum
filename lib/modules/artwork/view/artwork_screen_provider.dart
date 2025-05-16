import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/core/di/locator.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';
import 'package:tdd_art_museum/modules/artwork/view/artwork_screen.dart';

class ArtworkScreenProvider extends StatelessWidget {
  const ArtworkScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ArtworkViewModel>(),
      child: ArtworkScreen(),
    );
  }
}
