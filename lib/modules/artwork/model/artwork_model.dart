import 'package:equatable/equatable.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_src_model.dart';

class ArtworkModel extends Equatable {
  const ArtworkModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.avgColor,
    required this.src,
    required this.alt,
  });

  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerUrl;
  final String avgColor;
  final ArtworkSrcModel src;
  final String alt;

  factory ArtworkModel.fromMap(Map<String, dynamic> map) {
    return ArtworkModel(
      id: map['id'] as int,
      width: map['width'] as int,
      height: map['height'] as int,
      url: map['url'] as String,
      photographer: map['photographer'] as String,
      photographerUrl: map['photographer_url'] as String,
      avgColor: map['avg_color'] as String,
      alt: map['alt'] as String,
      src: ArtworkSrcModel.fromMap(map['src'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [
    id,
    width,
    height,
    url,
    photographer,
    avgColor,
    src,
  ];
}
