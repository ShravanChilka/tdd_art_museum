import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:tdd_art_museum/modules/artwork/service/artwork_remote_service.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_model.dart';

class ArtworkViewModel extends ChangeNotifier {
  ArtworkViewModel(this._remoteService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  bool _isSearchLoadingMore = false;
  bool get isSearchLoadingMore => _isSearchLoadingMore;

  int _total = 0;
  int get total => _total;
  @visibleForTesting
  set total(int value) => _total = value;

  int _totalSearch = 0;
  int get totalSearch => _totalSearch;
  @visibleForTesting
  set totalSearch(int value) => _totalSearch = value;

  List<ArtworkModel> _artworks = [];
  UnmodifiableListView<ArtworkModel> get artworks =>
      UnmodifiableListView(_artworks);
  @visibleForTesting
  set artworks(List<ArtworkModel> value) => _artworks = value;

  List<ArtworkModel> _searchedArtworks = [];
  UnmodifiableListView<ArtworkModel> get searchedArtworks =>
      UnmodifiableListView(_searchedArtworks);
  @visibleForTesting
  set searchedArtworks(List<ArtworkModel> value) => _searchedArtworks = value;

  final ArtworkRemoteService _remoteService;

  Future<void> fetchArtworks() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    final response = await _remoteService.getArtworks(page: 1, perPage: 10);
    response.fold((l) {}, (r) {
      _artworks = r.photos;
      _total = r.totalResults;
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreArtworks() async {
    if (_isLoading) return;
    if (_isLoadingMore) return;
    if (_artworks.length >= total) return;
    _isLoadingMore = true;
    notifyListeners();
    final response = await _remoteService.getArtworks(
      page: (_artworks.length ~/ 10) + 1,
      perPage: 10,
    );
    response.fold((l) {}, (r) {
      _artworks = [..._artworks, ...r.photos];
      _total = r.totalResults;
    });
    _isLoadingMore = false;
    notifyListeners();
  }

  String _query = '';
  void onQueryChangedEvent(String value) {
    if (_query == value) return;
    _query = value;
  }

  Future<void> searchArtwork() async {
    if (_isSearchLoading) return;
    _isSearchLoading = true;
    notifyListeners();
    final response = await _remoteService.searchArtwork(
      query: _query,
      page: 1,
      perPage: 10,
    );
    response.fold((l) {}, (r) {
      _searchedArtworks = r.photos;
      _totalSearch = r.totalResults;
    });
    _isSearchLoading = false;
    notifyListeners();
  }

  Future<void> searchMoreArtworks() async {
    if (_isSearchLoading) return;
    if (_isSearchLoadingMore) return;
    if (_searchedArtworks.length >= totalSearch) return;
    _isSearchLoadingMore = true;
    notifyListeners();
    final response = await _remoteService.searchArtwork(
      query: _query,
      page: (_searchedArtworks.length ~/ 10) + 1,
      perPage: 10,
    );
    response.fold((l) {}, (r) {
      _searchedArtworks = [..._searchedArtworks, ...r.photos];
      _totalSearch = r.totalResults;
    });
    _isSearchLoadingMore = false;
    notifyListeners();
  }
}
