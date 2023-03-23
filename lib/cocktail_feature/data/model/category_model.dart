import 'package:test_new_project/cocktail_feature/domain/entity/category.dart';

class CategoryModel extends CategoryDrink {
  const CategoryModel({ required String strCategory})
      : super(name: strCategory);

  factory CategoryModel._fromJsonObj(Map<String, dynamic> json) {
    return CategoryModel(
      strCategory: json['strCategory'],
    );
  }

  static List<CategoryModel> fromJsonList(Map<String, dynamic> json) {
    var list = json['drinks'] as List;
    return list.map((e) => CategoryModel._fromJsonObj(e as Map<String, dynamic>) ).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'strCategory': name,
    };
  }
}