import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/cocktail_feature/data/model/category_model.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/cocktail.dart';
import 'package:test_new_project/cocktail_feature/domain/repository/cocktail_repository.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_categories.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_random_cocktail.dart';
import 'package:test_new_project/core/usecases/usecase.dart';

class MockCocktailRepository extends Mock implements CocktailRepository {}

void main() {
  late GetCategories usecase;
  late MockCocktailRepository mockCocktailRepository;

  setUp(() {
    mockCocktailRepository = MockCocktailRepository();
    usecase = GetCategories(repository: mockCocktailRepository);
  });

  const tCocktailModelList = <CategoryModel>[
    CategoryModel(strCategory: 'Ordinary Drink'),
    CategoryModel(strCategory: 'Cocktail'),
    CategoryModel(strCategory: 'Shake'),
    CategoryModel(strCategory: 'Other / Unknown'),
    CategoryModel(strCategory: 'Cocoa'),
    CategoryModel(strCategory: 'Shot'),
    CategoryModel(strCategory: 'Coffee / Tea'),
    CategoryModel(strCategory: 'Homemade Liqueur'),
    CategoryModel(strCategory: 'Punch / Party Drink'),
    CategoryModel(strCategory: 'Beer'),
    CategoryModel(strCategory: 'Soft Drink'),
  ];

  test('should get random cocktail from the repository', () async {
    // arrange
    when(() => mockCocktailRepository.getCategories())
        .thenAnswer((_) async => const Right(tCocktailModelList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tCocktailModelList));
    verify(() => mockCocktailRepository.getCategories());
    verifyNoMoreInteractions(mockCocktailRepository);
  });
}