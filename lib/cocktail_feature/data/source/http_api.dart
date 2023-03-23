import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_new_project/cocktail_feature/domain/entity/cocktail.dart';

import '../../../core/error/exception.dart';
import '../model/category_model.dart';
import '../model/cocktail_model.dart';

abstract class Api {
  Future<CocktailModel> getRandomCocktail();
  Future<List<CategoryModel>> getCategories();
  Future<List<Cocktail>> getCocktailByCategory(String category);

}

class ApiImpl implements Api {

  final http.Client client;

  ApiImpl({required this.client});

  @override
  Future<CocktailModel> getRandomCocktail() async {
    final response = await client.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CocktailModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CategoryModel.fromJsonList(
          json.decode(response.body) as Map<String, dynamic>
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Cocktail>> getCocktailByCategory(String category) async {
    final categoryURLPath = category.replaceAll(' ', '_');
    final response = await client.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$categoryURLPath'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CocktailModel.fromJsonList(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}