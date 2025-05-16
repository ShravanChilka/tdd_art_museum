import 'package:flutter/material.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_model.dart';
import 'package:tdd_art_museum/modules/artwork/view/widgets/artwork_grid_view_pagination_loader_widget.dart';

class ArtworkGridView extends StatelessWidget {
  const ArtworkGridView({super.key, required this.artworks, this.onLoadMore});

  final List<ArtworkModel> artworks;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          onLoadMore?.call();
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 6, right: 6, top: 6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                final artwork = artworks[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(artwork.src.medium),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            artwork.photographer,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(200),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            artwork.alt,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            ArtworkGridViewPaginationLoaderWidget(),
          ],
        ),
      ),
    );
  }
}
