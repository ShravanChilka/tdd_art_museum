import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/artwork_search_grid_view_builder.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

class SearchArtworkDelegate extends SearchDelegate {
  SearchArtworkDelegate({required this.viewModel});

  final ArtworkViewModel viewModel;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        viewModel.onQueryChangedEvent(query);
        viewModel.searchArtwork();
      }
    });
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: ArtworkSearchGridViewBuilder(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        viewModel.onQueryChangedEvent(query);
        viewModel.searchArtwork();
      }
    });
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: ArtworkSearchGridViewBuilder(),
    );
  }
}
