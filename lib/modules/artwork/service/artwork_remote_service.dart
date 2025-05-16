import 'package:dartz/dartz.dart';
import 'package:tdd_art_museum/core/errors/failure.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_response_model.dart';

abstract class ArtworkRemoteService {
  Future<Either<Failure, ArtworkResponseModel>> getArtworks({
    int page = 1,
    int perPage = 10,
  });

  Future<Either<Failure, ArtworkResponseModel>> searchArtwork({
    required String query,
    int page = 1,
    int perPage = 10,
  });
}
