import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

class ArtworkGridViewPaginationLoaderWidget extends StatelessWidget {
  const ArtworkGridViewPaginationLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ArtworkViewModel, bool>(
      selector: (_, vm) => vm.isLoadingMore,
      builder: (context, isLoadingMore, child) {
        return SizedBox(
          height: 40,
          width: 40,
          child: isLoadingMore ? child : null,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}
