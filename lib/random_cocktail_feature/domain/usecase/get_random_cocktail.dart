import 'package:dartz/dartz.dart';

import 'package:test_new_project/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../entity/cocktail.dart';
import '../repository/cocktail_repository.dart';

class GetRandomCocktail implements UseCase<Cocktail, NoParams>{

  final CocktailRepository repository;

  GetRandomCocktail({required this.repository});

  @override
  Future<Either<Failure, Cocktail>> call(NoParams params) async {
    return repository.getRandomCocktail();
  }

}