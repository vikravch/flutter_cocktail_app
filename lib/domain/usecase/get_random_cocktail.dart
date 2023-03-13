import '../entity/cocktail.dart';
import '../repository/cocktail_repository.dart';

class GetRandomCocktail{

  CocktailRepository repository;

  GetRandomCocktail({required this.repository});

  Future<Cocktail> call() async {
    return repository.getRandomCocktail();
  }
}