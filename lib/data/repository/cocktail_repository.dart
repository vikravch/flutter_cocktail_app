import 'package:test_new_project/data/entity/mapper.dart';
import 'package:test_new_project/data/source/http_api.dart';
import 'package:test_new_project/domain/entity/cocktail.dart';
import 'package:test_new_project/domain/repository/cocktail_repository.dart';

class CocktailRepositoryImpl implements CocktailRepository {

  @override
  Future<Cocktail> getRandomCocktail() async {
    var res = await Api.getRandomCocktail();
    return randomModelToCocktail(res);
  }

}