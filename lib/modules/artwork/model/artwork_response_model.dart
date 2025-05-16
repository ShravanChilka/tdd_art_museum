import 'package:equatable/equatable.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_model.dart';

class ArtworkResponseModel extends Equatable {
  const ArtworkResponseModel({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  factory ArtworkResponseModel.fromMap(Map<String, dynamic> map) {
    return ArtworkResponseModel(
      page: map['page'] as int,
      perPage: map['per_page'] as int,
      photos: List<ArtworkModel>.from(
        (map['photos'] as List).map(
          (x) => ArtworkModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalResults: map['total_results'] as int,
      nextPage: map['next_page'] as String,
    );
  }

  final int page;
  final int perPage;
  final List<ArtworkModel> photos;
  final int totalResults;
  final String nextPage;

  @override
  List<Object?> get props => [page, perPage, photos, totalResults, nextPage];
}
