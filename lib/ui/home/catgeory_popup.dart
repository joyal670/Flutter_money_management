import 'package:flutter/material.dart';
import 'package:money_management/db/catgeory/category_db.dart';
import 'package:money_management/models/category/category.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

final _textEditingController = TextEditingController();

void showCategory(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add catgeory'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    hintText: 'Enter Category name',
                    border: OutlineInputBorder()),
              ),
            ),
            const RadioButtonClass(title: "Income", type: CategoryType.income),
            const RadioButtonClass(
                title: "Expence", type: CategoryType.expense),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_textEditingController.text.isEmpty) {
                      return;
                    }

                    final catgeory = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _textEditingController.text,
                        type: selectedCategoryNotifier.value);

                    categoryDb().insertCategory(catgeory);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Add')),
            )
          ],
        );
      });
}

class RadioButtonClass extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButtonClass({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
