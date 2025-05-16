import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/search_artwork_icon_button.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/artwork_grid_view_builder.dart';

class ArtworkScreen extends StatefulWidget {
  const ArtworkScreen({super.key});

  @override
  State<ArtworkScreen> createState() => _ArtworkScreenState();
}

class _ArtworkScreenState extends State<ArtworkScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) context.read<ArtworkViewModel>().fetchArtworks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Works'),
        actions: [SearchArtworkIconButton()],
      ),
      body: ArtworkGridViewBuilder(),
    );
  }
}
