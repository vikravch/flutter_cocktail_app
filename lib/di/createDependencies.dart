import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:test_new_project/cocktail_feature/domain/usecase/get_categories.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_cocktails_by_category.dart';
import 'package:test_new_project/cocktail_feature/presentation/cubit/categories/categories.dart';
import 'package:test_new_project/core/network/network_info.dart';

import '../cocktail_feature/data/repository/cocktail_repository.dart';
import '../cocktail_feature/data/source/http_api.dart';
import '../cocktail_feature/domain/repository/cocktail_repository.dart';
import '../cocktail_feature/domain/usecase/get_random_cocktail.dart';
import '../cocktail_feature/presentation/cubit/random_cocktail/random_cocktail.dart';


// Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => GetRandomCubit(getRandomCocktail: sl()));
  sl.registerFactory(() => GetCategoriesCubit(getCategories: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetRandomCocktail(repository: sl()));
  sl.registerLazySingleton(() => GetCategories(repository: sl()));
  sl.registerLazySingleton(() => GetCocktailsByCategory(repository: sl()));

  // Repository
  sl.registerLazySingleton<CocktailRepository>(()=>CocktailRepositoryImpl(api: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<Api>(()=>ApiImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}