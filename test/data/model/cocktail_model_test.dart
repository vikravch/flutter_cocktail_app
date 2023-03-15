import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_new_project/random_cocktail_feature/data/model/cocktail_model.dart';
import 'package:test_new_project/random_cocktail_feature/domain/entity/cocktail.dart';

import '../../fixtures/fixture_reader.dart';

void main(){

  const tCocktailModel = CocktailModel(id: '14730', name: 'Bubble Gum');

test(
    'should be a subclass of Cocktail entity',
    () async {
      expect(tCocktailModel, isA<Cocktail>());
    },
  );

group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      // arrange
      final jsonMap =
          json.decode(fixture('random_response.json')) as Map<String, dynamic>;
      // act
      final result = CocktailModel.fromJson(jsonMap);
      // assert
      expect(result, tCocktailModel);
    });
  });

}