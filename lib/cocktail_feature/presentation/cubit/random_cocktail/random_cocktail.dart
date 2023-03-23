import 'package:bloc/bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../domain/usecase/get_random_cocktail.dart';
import 'random_cocktail_state.dart';

class GetRandomCubit extends Cubit<RandomCocktailState> {

  final GetRandomCocktail _getRandomCocktail;

  GetRandomCubit({required GetRandomCocktail getRandomCocktail})
      : _getRandomCocktail = getRandomCocktail,
        super(Empty());

  void getRandom() async {
    emit(Loading());

    final value = await _getRandomCocktail(NoParams());
    value.fold((l) => emit(Error(message: l.toString())), (r) => emit(RandomCocktailLoaded(cocktail: r)));
  }
}