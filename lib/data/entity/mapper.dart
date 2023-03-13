import '../../domain/entity/cocktail.dart';

Future<Cocktail> randomModelToCocktail(Map<String, dynamic> data) async{
  return Future(() => Cocktail(id: data['drinks'][0]['idDrink'], name: data['drinks'][0]['strDrink']));
}