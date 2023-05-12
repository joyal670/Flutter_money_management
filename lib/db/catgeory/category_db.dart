import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategory();

  Future<void> insertCategory(CategoryModel model);
}

class categoryDb implements CategoryDBFunctions {
  categoryDb._internal();

  static categoryDb instance = categoryDb._internal();

  factory categoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenceList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel model) async {
    final _catgegory = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _catgegory.add(model);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _catgegory = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _catgegory.values.toList();
  }

  refreshUI() async {
    final _allCategory = await getCategory();
    incomeList.value.clear();
    expenceList.value.clear();

    Future.forEach(_allCategory, (CategoryModel categoryModel) {
      if (categoryModel.type == CategoryType.income) {
        incomeList.value.add(categoryModel);
      } else {
        expenceList.value.add(categoryModel);
      }
    });

    incomeList.notifyListeners();
    expenceList.notifyListeners();
  }
}
