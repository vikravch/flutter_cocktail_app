import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/core/error/exception.dart';
import 'package:test_new_project/core/error/failures.dart';
import 'package:test_new_project/core/network/network_info.dart';
import 'package:test_new_project/random_cocktail_feature/data/model/cocktail_model.dart';
import 'package:test_new_project/random_cocktail_feature/data/repository/cocktail_repository.dart';
import 'package:test_new_project/random_cocktail_feature/data/source/http_api.dart';

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
}