import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/cocktail_feature/data/model/category_model.dart';
import 'package:test_new_project/cocktail_feature/data/model/cocktail_model.dart';
import 'package:test_new_project/cocktail_feature/data/source/http_api.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/category.dart';
import 'package:test_new_project/core/error/exception.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiImpl api;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    api = ApiImpl(client: mockHttpClient);
  });

  void setUpHttpClientSuccess200(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('random_response.json'), 200));
  }
  void setUpHttpClientSuccess200Categories(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('category_response.json'), 200));
  }
  void setUpHttpClientSuccess200CocktailByCategory(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('cocktails_by_category.json'), 200));
  }

  void setUpHttpClientFailure404(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getRandom', () {
    final url =
        Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php');

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      // arrange
      setUpHttpClientSuccess200(url);
      // act
      api.getRandomCocktail();
      // assert
      verify(
        () => mockHttpClient
            .get(url, headers: {'Content-Type': 'application/json'}),
      );
    });

    final tRandomCocktailModel = CocktailModel.fromJson(
      json.decode(fixture('random_response.json')) as Map<String, dynamic>,
    );

    test('should return CocktailModel when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200(url);
      // act
      final result = await api.getRandomCocktail();
      // assert
      expect(result, equals(tRandomCocktailModel));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpHttpClientFailure404(url);
      // act
      final call = api.getRandomCocktail;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getCategories', () {
    final url =
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list');

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
            () {
          // arrange
          setUpHttpClientSuccess200(url);
          // act
          api.getCategories();
          // assert
          verify(
                () => mockHttpClient
                .get(url, headers: {'Content-Type': 'application/json'}),
          );
        });

    final tRandomCocktailModel = CategoryModel.fromJsonList(
      json.decode(fixture('category_response.json')) as Map<String, dynamic>,
    );

    test('should return CocktailModel when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200Categories(url);
      // act
      final result = await api.getCategories();
      // assert
      expect(result, equals(tRandomCocktailModel));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
            () async {
          // arrange
          setUpHttpClientFailure404(url);
          // act
          final call = api.getCategories;
          // assert
          expect(() => call(), throwsA(isA<ServerException>()));
        });
  });

  group('getCocktailsByCategory', () {
    final url =
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink');
    const category = 'Ordinary Drink';

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
            () {
          // arrange
          setUpHttpClientSuccess200(url);
          // act
          api.getCocktailByCategory(category);
          // assert
          verify(
                () => mockHttpClient
                .get(url, headers: {'Content-Type': 'application/json'}),
          );
        });

    final tRandomCocktailModel = CocktailModel.fromJsonList(
      json.decode(fixture('cocktails_by_category.json')) as Map<String, dynamic>,
    );

    test('should return CocktailModel when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200CocktailByCategory(url);
      // act
      final result = await api.getCocktailByCategory(category);
      // assert
      expect(result, equals(tRandomCocktailModel));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
            () async {
          // arrange
          setUpHttpClientFailure404(url);
          // act
          final call = api.getCocktailByCategory;
          // assert
          expect(() => call(category), throwsA(isA<ServerException>()));
        });
  });
}
