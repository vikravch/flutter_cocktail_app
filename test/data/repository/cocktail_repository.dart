import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/cocktail_feature/data/model/category_model.dart';
import 'package:test_new_project/cocktail_feature/data/model/cocktail_model.dart';
import 'package:test_new_project/cocktail_feature/data/repository/cocktail_repository.dart';
import 'package:test_new_project/cocktail_feature/data/source/http_api.dart';
import 'package:test_new_project/core/error/exception.dart';
import 'package:test_new_project/core/error/failures.dart';
import 'package:test_new_project/core/network/network_info.dart';

import '../../fixtures/fixture_reader.dart';

class MockApi extends Mock implements Api {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  late CocktailRepositoryImpl repository;
  late MockApi mockApi;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockApi = MockApi();
    mockNetworkInfo = MockNetworkInfo();
    repository = CocktailRepositoryImpl(api: mockApi, networkInfo: mockNetworkInfo);
  });

  group('getRandom', () {
    final tRandomCocktailModel = CocktailModel.fromJson(
      json.decode(fixture('random_response.json')) as Map<String, dynamic>,
    );

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getRandomCocktail()).thenAnswer((_) async => tRandomCocktailModel);
      // act
      repository.getRandomCocktail();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getRandomCocktail()).thenAnswer((_) async => tRandomCocktailModel);
      // act
      final result = await repository.getRandomCocktail();
      // assert
      verify(() => mockApi.getRandomCocktail());
      expect(result, equals(Right(tRandomCocktailModel)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getRandomCocktail()).thenThrow(ServerException());
      // act
      final result = await repository.getRandomCocktail();
      // assert
      verify(() => mockApi.getRandomCocktail());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return server failure when there is no internet connection', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getRandomCocktail();
      // assert
      verifyZeroInteractions(mockApi);
      expect(result, equals(Left(ServerFailure())));
    });
  });


  group('getCategories', () {
    final tCategoriesModel = CategoryModel.fromJsonList(
      json.decode(fixture('category_response.json')) as Map<String, dynamic>,
    );

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(() => mockApi.getCategories()).thenAnswer((_) async => tCategoriesModel);
      // act
      repository.getCategories();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getCategories()).thenAnswer((_) async => tCategoriesModel);
      // act
      final result = await repository.getCategories();
      // assert
      verify(() => mockApi.getCategories());
      expect(result, equals(Right(tCategoriesModel)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getCategories()).thenThrow(ServerException());
      // act
      final result = await repository.getCategories();
      // assert
      verify(() => mockApi.getCategories());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return server failure when there is no internet connection', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getCategories();
      // assert
      verifyZeroInteractions(mockApi);
      expect(result, equals(Left(ServerFailure())));
    });
  });


  group('getCocktailByCategory', () {
    final tCocktailsModel = CocktailModel.fromJsonList(
      json.decode(fixture('cocktails_by_category.json')) as Map<String, dynamic>,
    );
    const category = 'Ordinary_Drink';

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(() => mockApi.getCocktailByCategory(category)).thenAnswer((_) async => tCocktailsModel);
      // act
      repository.getCocktailsByCategory(category);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getCocktailByCategory(category)).thenAnswer((_) async => tCocktailsModel);
      // act
      final result = await repository.getCocktailsByCategory(category);
      // assert
      verify(() => mockApi.getCocktailByCategory(category));
      expect(result, equals(Right(tCocktailsModel)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockApi.getCocktailByCategory(category)).thenThrow(ServerException());
      // act
      final result = await repository.getCocktailsByCategory(category);
      // assert
      verify(() => mockApi.getCocktailByCategory(category));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return server failure when there is no internet connection', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getCocktailsByCategory(category);
      // assert
      verifyZeroInteractions(mockApi);
      expect(result, equals(Left(ServerFailure())));
    });
  });
}