import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategory();

  Future<void> insertCategory(CategoryModel model);
}

class categoryDb implements CategoryDBFunctions {
  @override
  Future<void> insertCategory(CategoryModel model) async {
    final _catgegory = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _catgegory.add(model);
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _catgegory = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _catgegory.values.toList();
  }
}
