import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entity/cocktail.dart';
import '../repository/cocktail_repository.dart';

class GetCocktailsByCategory implements UseCase<List<Cocktail>, Params>{

  final CocktailRepository repository;

  GetCocktailsByCategory({required this.repository});

  @override
  Future<Either<Failure, List<Cocktail>>> call(Params params) async {
    return repository.getCocktailsByCategory(params.category);
  }

}

class Params {
  final String category;

  Params({required this.category});
}