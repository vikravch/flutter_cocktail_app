import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/cocktail.dart';
import 'package:test_new_project/cocktail_feature/domain/repository/cocktail_repository.dart';
import 'package:test_new_project/cocktail_feature/domain/usecase/get_random_cocktail.dart';
import 'package:test_new_project/core/usecases/usecase.dart';

class MockCocktailRepository extends Mock implements CocktailRepository {}

void main() {
  late GetRandomCocktail usecase;
  late MockCocktailRepository mockCocktailRepository;

  setUp(() {
    mockCocktailRepository = MockCocktailRepository();
    usecase = GetRandomCocktail(repository: mockCocktailRepository);
  });

  const tCocktail = Cocktail(id: '1', name: 'test', );

  test('should get random cocktail from the repository', () async {
    // arrange
    when(() => mockCocktailRepository.getRandomCocktail())
        .thenAnswer((_) async => const Right(tCocktail));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tCocktail));
    verify(() => mockCocktailRepository.getRandomCocktail());
    verifyNoMoreInteractions(mockCocktailRepository);
  });
}