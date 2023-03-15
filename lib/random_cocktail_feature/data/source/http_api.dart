import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/error/exception.dart';
import '../model/cocktail_model.dart';

abstract class Api {
  Future<CocktailModel> getRandomCocktail();
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
}