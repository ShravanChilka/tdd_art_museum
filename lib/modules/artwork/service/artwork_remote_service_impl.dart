import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tdd_art_museum/core/errors/failure.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_response_model.dart';

class ArtworkRemoteServiceImpl implements ArtworkRemoteService {
  const ArtworkRemoteServiceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, ArtworkResponseModel>> getArtworks({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/v1/search?query=art',
        queryParameters: {"page": page, "per_page": perPage},
      );
      if (response.statusCode == 200) {
        return Right(ArtworkResponseModel.fromMap(response.data));
      }
      return Left(Failure('Something went wrong!'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArtworkResponseModel>> searchArtwork({
    required String query,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/v1/search?query=$query art',
        queryParameters: {"page": page, "per_page": perPage},
      );
      if (response.statusCode == 200) {
        return Right(ArtworkResponseModel.fromMap(response.data));
      }
      return Left(Failure('Something went wrong!'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
