import 'package:dartz/dartz.dart';

import 'package:test_new_project/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../entity/category.dart';
import '../repository/cocktail_repository.dart';

class GetCategories implements UseCase<List<CategoryDrink>, NoParams>{

  final CocktailRepository repository;

  GetCategories({required this.repository});

  @override
  Future<Either<Failure, List<CategoryDrink>>> call(NoParams params) async {
    return repository.getCategories();
  }

}