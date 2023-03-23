import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/cocktail_feature/data/model/category_model.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/cocktail.dart';
import 'package:test_new_project/cocktail_feature/domain/repository/cocktail_repository.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_categories.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_cocktails_by_category.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_random_cocktail.dart';
import 'package:test_new_project/core/usecases/usecase.dart';

class MockCocktailRepository extends Mock implements CocktailRepository {}

void main() {
  late GetCocktailsByCategory usecase;
  late MockCocktailRepository mockCocktailRepository;

  setUp(() {
    mockCocktailRepository = MockCocktailRepository();
    usecase = GetCocktailsByCategory(repository: mockCocktailRepository);
  });

  const tCocktailsList = [
    Cocktail(
        id: '15300',
        name: '3-Mile Long Island Iced Tea',
    ),
    Cocktail(
        id: '13581',
        name: '410 Gone',
    ),
    Cocktail(
        id: '14598',
        name: '50\/50',
    ),
  ];
  const category = 'Ordinary Drink';

  test('should get random cocktail from the repository', () async {
    // arrange
    when(() => mockCocktailRepository.getCocktailsByCategory(category))
        .thenAnswer((_) async => const Right(tCocktailsList));
    // act
    final result = await usecase(Params(category: 'Ordinary Drink'));
    // assert
    expect(result, const Right(tCocktailsList));
    verify(() => mockCocktailRepository.getCocktailsByCategory(category));
    verifyNoMoreInteractions(mockCocktailRepository);
  });
}