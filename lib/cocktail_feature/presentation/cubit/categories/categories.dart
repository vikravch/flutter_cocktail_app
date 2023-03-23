import 'package:bloc/bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../domain/usecase/get_categories.dart';
import 'categories_state.dart';

class GetCategoriesCubit extends Cubit<CategoriesState> {

  final GetCategories _getCategories;

  GetCategoriesCubit({required GetCategories getCategories})
      : _getCategories = getCategories,
        super(Empty());

  void getRandom() async {
    emit(Loading());

    final value = await _getCategories(NoParams());
    value.fold((l) => emit(Error(message: l.toString())), (r) => emit(CategoriesLoaded(categories: r)));
  }
}