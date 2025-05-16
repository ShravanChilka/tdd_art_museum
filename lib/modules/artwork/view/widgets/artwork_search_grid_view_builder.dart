import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_model.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/artwork_grid_loader_widget.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/artwork_grid_view.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

class ArtworkSearchGridViewBuilder extends StatelessWidget {
  const ArtworkSearchGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ArtworkViewModel, Tuple2<List<ArtworkModel>, bool>>(
      selector: (_, vm) => Tuple2(vm.searchedArtworks, vm.isSearchLoading),
      builder: (context, tuple, child) {
        if (tuple.value2) {
          return ArtworkGridLoaderWidget();
        }
        return ArtworkGridView(artworks: tuple.value1, onLoadMore: () {});
      },
    );
  }
}
