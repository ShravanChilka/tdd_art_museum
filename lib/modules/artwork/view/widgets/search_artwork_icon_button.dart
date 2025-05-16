import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/search_artwork_delegate.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

class SearchArtworkIconButton extends StatelessWidget {
  const SearchArtworkIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: SearchArtworkDelegate(
            viewModel: context.read<ArtworkViewModel>(),
          ),
        );
      },
      icon: Icon(Icons.search),
    );
  }
}
