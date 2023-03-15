import 'package:dartz/dartz.dart';
import 'package:test_new_project/core/error/failures.dart';

import '../../../core/error/exception.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entity/cocktail.dart';
import '../../domain/repository/cocktail_repository.dart';
import '../source/http_api.dart';

class CocktailRepositoryImpl implements CocktailRepository {

  final Api api;
  final NetworkInfo networkInfo;

  CocktailRepositoryImpl({required this.api, required this.networkInfo});

  @override
  Future<Either<Failure, Cocktail>> getRandomCocktail() async {
    if (await networkInfo.isConnected) {
      try {
        final cocktail = await api.getRandomCocktail();
        return Right(cocktail);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }


}