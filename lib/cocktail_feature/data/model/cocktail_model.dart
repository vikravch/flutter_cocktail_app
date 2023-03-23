import '../../domain/entity/cocktail.dart';

class CocktailModel extends Cocktail{

  const CocktailModel({required String id, required String name}): super(id: id, name: name);

  factory CocktailModel.fromJson(Map<String, dynamic> json) {
    return CocktailModel(
      id: json['drinks'][0]['idDrink'],
      name: json['drinks'][0]['strDrink'],
    );
  }

  factory CocktailModel.fromJsonObj(Map<String, dynamic> json) {
    return CocktailModel(
      id: json['idDrink'],
      name: json['strDrink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<CocktailModel> fromJsonList(Map<String, dynamic> json) {
    var list = json['drinks'] as List;
    return list.map((e) => CocktailModel.fromJsonObj(e as Map<String, dynamic>) ).toList();
  }
}