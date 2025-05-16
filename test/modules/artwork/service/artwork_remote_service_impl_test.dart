import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_art_museum/core/errors/failure.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service_impl.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_response_model.dart';

import '../../../fixture/fixture.dart';
import 'artwork_remote_service_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late ArtworkRemoteServiceImpl remoteService;

  setUp(() {
    mockDio = MockDio();
    remoteService = ArtworkRemoteServiceImpl(mockDio);
  });

  test(
    'When [ArtworkRemoteServiceImpl.getArtworks] method is called, '
    'Then it should return [ArtworkResponseModel] for success case',
    () async {
      // arrange
      final json = await Fixture.fromPath(
        'test/modules/artwork/fixture/artwork_response_model_fixture_one.json',
      );
      final map = jsonDecode(json);
      final mockResponse = Response(
        statusCode: 200,
        requestOptions: RequestOptions(
          method: 'GET',
          path: '/v1/search?query=art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
        data: map,
      );
      final expected = ArtworkResponseModel.fromMap(map);
      when(
        mockDio.get(
          '/v1/search?query=art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final actual = await remoteService.getArtworks(page: 1, perPage: 1);
      // assert
      expect(actual, Right(expected));
      verify(
        mockDio.get(
          '/v1/search?query=art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).called(1);
    },
  );
  test('When [ArtworkRemoteServiceImpl.getArtworks] method is called, '
      'Then it should return [Failure] for failure case', () async {
    // arrange
    final mockResponse = Response(
      statusCode: 500,
      requestOptions: RequestOptions(
        method: 'GET',
        path: '/v1/search?query=art',
        queryParameters: {"page": 1, "per_page": 1},
      ),
    );
    final expected = Failure('Something went wrong!');
    when(
      mockDio.get(
        '/v1/search?query=art',
        queryParameters: {"page": 1, "per_page": 1},
      ),
    ).thenAnswer((_) async => mockResponse);
    // act
    final actual = await remoteService.getArtworks(page: 1, perPage: 1);
    // assert
    expect(actual, Left(expected));
    verify(
      mockDio.get(
        '/v1/search?query=art',
        queryParameters: {"page": 1, "per_page": 1},
      ),
    ).called(1);
  });

  test(
    'When [ArtworkRemoteServiceImpl.searchArtworks] method is called with query "cat", '
    'Then it should return [ArtworkResponseModel] for success case',
    () async {
      // arrange
      final json = await Fixture.fromPath(
        'test/modules/artwork/fixture/artwork_response_model_fixture_search.json',
      );
      final map = jsonDecode(json);
      final mockResponse = Response(
        statusCode: 200,
        requestOptions: RequestOptions(
          method: 'GET',
          path: '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
        data: map,
      );
      final expected = ArtworkResponseModel.fromMap(map);
      when(
        mockDio.get(
          '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final actual = await remoteService.searchArtwork(
        query: "cat",
        page: 1,
        perPage: 1,
      );
      // assert
      expect(actual, Right(expected));
      verify(
        mockDio.get(
          '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).called(1);
    },
  );

  test(
    'When [ArtworkRemoteServiceImpl.searchArtworks] method is called with query "cat", '
    'Then it should return [Failure] for failure case',
    () async {
      // arrange
      final mockResponse = Response(
        statusCode: 500,
        requestOptions: RequestOptions(
          method: 'GET',
          path: '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      );
      final expected = Failure('Something went wrong!');
      when(
        mockDio.get(
          '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final actual = await remoteService.searchArtwork(
        query: "cat",
        page: 1,
        perPage: 1,
      );
      // assert
      expect(actual, Left(expected));
      verify(
        mockDio.get(
          '/v1/search?query=cat art',
          queryParameters: {"page": 1, "per_page": 1},
        ),
      ).called(1);
    },
  );
}
