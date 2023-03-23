import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_new_project/cocktail_feature/data/model/category_model.dart';
import 'package:test_new_project/cocktail_feature/data/model/cocktail_model.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/category.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/cocktail.dart';


import '../../fixtures/fixture_reader.dart';

void main(){

  const tCocktailModelList = <CategoryModel>[
    CategoryModel(strCategory: 'Ordinary Drink'),
    CategoryModel(strCategory: 'Cocktail'),
    CategoryModel(strCategory: 'Shake'),
    CategoryModel(strCategory: 'Other / Unknown'),
    CategoryModel(strCategory: 'Cocoa'),
    CategoryModel(strCategory: 'Shot'),
    CategoryModel(strCategory: 'Coffee / Tea'),
    CategoryModel(strCategory: 'Homemade Liqueur'),
    CategoryModel(strCategory: 'Punch / Party Drink'),
    CategoryModel(strCategory: 'Beer'),
    CategoryModel(strCategory: 'Soft Drink'),
  ];


test(
    'should be a subclass of Cocktail entity',
    () async {
      expect(tCocktailModelList, isA<List<CategoryDrink>>());
    },
  );
  group('fromJsonList', () {
    test('should return a valid model when the JSON number is an integer',
            () async {
      // arrange
      final jsonMap =
          json.decode(fixture('category_response.json')) as Map<String, dynamic>;
      // act
      final result = CategoryModel.fromJsonList(jsonMap);
      // assert
      expect(result, tCocktailModelList);
    });
  });
}


