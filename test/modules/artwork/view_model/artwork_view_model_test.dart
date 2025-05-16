import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_response_model.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service.dart';
import 'package:tdd_art_museum/modules/artwork/view_model/artwork_view_model.dart';

import '../../../fixture/fixture.dart';
import 'artwork_view_model_test.mocks.dart';

@GenerateMocks([ArtworkRemoteService])
void main() {
  late ArtworkViewModel viewModel;
  late MockArtworkRemoteService mockArtworkRemoteService;

  setUp(() {
    mockArtworkRemoteService = MockArtworkRemoteService();
    viewModel = ArtworkViewModel(mockArtworkRemoteService);
  });

  test("When [ArtworkViewModel.fetchArtworks] method is called, "
      "Then if the response is Right, "
      "Then it should set [Artworks] list with the response", () async {
    // arrange
    final json = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_one.json',
    );
    final map = jsonDecode(json);
    final expected = ArtworkResponseModel.fromMap(map);
    when(mockArtworkRemoteService.getArtworks(page: 1, perPage: 10)).thenAnswer(
      (_) async {
        await Future.delayed(Duration(milliseconds: 100));
        return Right(expected);
      },
    );
    // act
    expect(viewModel.isLoading, false);
    final future = viewModel.fetchArtworks();
    expect(viewModel.isLoading, true);
    await future;
    // assert
    expect(viewModel.artworks.length, expected.photos.length);
    expect(viewModel.artworks.first, expected.photos.first);
    expect(viewModel.isLoading, false);
    verify(
      mockArtworkRemoteService.getArtworks(page: 1, perPage: 10),
    ).called(1);
  });

  test("When [ArtworkViewModel.fetchMoreArtworks] method is called, "
      "Then if the response is Right, "
      "Then it should add the [Artworks] list with the response", () async {
    // arrange
    final prevJson = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_one.json',
    );
    final prevMap = jsonDecode(prevJson);
    final prevResponse = ArtworkResponseModel.fromMap(prevMap);
    viewModel.artworks = prevResponse.photos;
    final json = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_two.json',
    );
    final map = jsonDecode(json);
    final response = ArtworkResponseModel.fromMap(map);
    final prevArtworks = viewModel.artworks;
    when(mockArtworkRemoteService.getArtworks(page: 2, perPage: 10)).thenAnswer(
      (_) async {
        await Future.delayed(Duration(milliseconds: 100));
        return Right(response);
      },
    );
    viewModel.total = 20;
    final expected = [...prevArtworks, ...response.photos];
    // act
    expect(viewModel.isLoadingMore, false);
    final future = viewModel.fetchMoreArtworks();
    expect(viewModel.isLoadingMore, true);
    await future;
    // assert
    expect(viewModel.artworks.length, expected.length);
    expect(viewModel.artworks.first, expected.first);
    expect(viewModel.artworks.last, expected.last);
    expect(viewModel.isLoadingMore, false);
    verify(
      mockArtworkRemoteService.getArtworks(page: 2, perPage: 10),
    ).called(1);
  });

  test("When [ArtworkViewModel.searchArtworks] method is called with quert cat, "
      "Then if the response is Right, "
      "Then it should set [Artworks] list with the response", () async {
    // arrange
    final json = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_search.json',
    );
    final map = jsonDecode(json);
    final expected = ArtworkResponseModel.fromMap(map);
    viewModel.onQueryChangedEvent("cat");
    when(
      mockArtworkRemoteService.searchArtwork(
        query: "cat",
        page: 1,
        perPage: 10,
      ),
    ).thenAnswer((_) async {
      await Future.delayed(Duration(milliseconds: 100));
      return Right(expected);
    });
    // act
    expect(viewModel.isSearchLoading, false);
    final future = viewModel.searchArtwork();
    expect(viewModel.isSearchLoading, true);
    await future;
    await Future.delayed(Duration(seconds: 1));
    // assert
    expect(viewModel.searchedArtworks.length, expected.photos.length);
    expect(viewModel.searchedArtworks.first, expected.photos.first);
    expect(viewModel.isSearchLoading, false);
    verify(
      mockArtworkRemoteService.searchArtwork(
        query: "cat",
        page: 1,
        perPage: 10,
      ),
    ).called(1);
  });

  test("When [ArtworkViewModel.searchMoreArtworks] method is called, "
      "Then if the response is Right, "
      "Then it should add the [Artworks] list with the response", () async {
    // arrange
    final prevJson = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_search.json',
    );
    final prevMap = jsonDecode(prevJson);
    final prevResponse = ArtworkResponseModel.fromMap(prevMap);
    final json = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_search_more.json',
    );
    viewModel.searchedArtworks = prevResponse.photos;
    viewModel.totalSearch = 20;

    final prevArtworks = viewModel.searchedArtworks;

    final map = jsonDecode(json);
    final response = ArtworkResponseModel.fromMap(map);
    viewModel.onQueryChangedEvent("cat");
    when(
      mockArtworkRemoteService.searchArtwork(
        query: "cat",
        page: 2,
        perPage: 10,
      ),
    ).thenAnswer((_) async {
      await Future.delayed(Duration(milliseconds: 100));
      return Right(response);
    });
    final expected = [...prevArtworks, ...response.photos];
    // act
    expect(viewModel.isSearchLoadingMore, false);
    final future = viewModel.searchMoreArtworks();
    expect(viewModel.isSearchLoadingMore, true);
    await future;
    // assert
    expect(viewModel.searchedArtworks.length, expected.length);
    expect(viewModel.searchedArtworks.first, expected.first);
    expect(viewModel.searchedArtworks.last, expected.last);
    expect(viewModel.isSearchLoadingMore, false);
    verify(
      mockArtworkRemoteService.searchArtwork(
        query: "cat",
        page: 2,
        perPage: 10,
      ),
    ).called(1);
  });
}
