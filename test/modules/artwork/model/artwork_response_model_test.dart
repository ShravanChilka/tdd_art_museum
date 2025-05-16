import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_model.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_response_model.dart';
import 'package:tdd_art_museum/modules/artwork/model/artwork_src_model.dart';

import '../../../fixture/fixture.dart';

void main() {
  test('When [ArtworkResponseModel.fromJson] method is called, '
      'Then it should return [ArtworkResponseModel]', () async {
    // arrange
    final ArtworkResponseModel expected = ArtworkResponseModel(
      page: 1,
      perPage: 1,
      photos: [
        ArtworkModel(
          id: 3246665,
          width: 1983,
          height: 2643,
          url: "https://www.pexels.com/photo/painting-of-giraffe-3246665/",
          photographer: "Gül Işık",
          photographerUrl: "https://www.pexels.com/@ekrulila",
          avgColor: "#9B7765",
          alt:
              "A watercolor painting of a giraffe surrounded by leaves and painting tools.",
          src: ArtworkSrcModel(
            original:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png",
            large2x:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
            large:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&h=650&w=940",
            medium:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&h=350",
            small:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&h=130",
            portrait:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
            landscape:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
            tiny:
                "https://images.pexels.com/photos/3246665/pexels-photo-3246665.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280",
          ),
        ),
      ],
      totalResults: 1,
      nextPage: "https://api.pexels.com/v1/search?page=1&per_page=1&query=art",
    );
    // act
    final json = await Fixture.fromPath(
      'test/modules/artwork/fixture/artwork_response_model_fixture_one.json',
    );
    final map = jsonDecode(json);
    final actual = ArtworkResponseModel.fromMap(map);
    // assert
    expect(actual, expected);
  });
}
