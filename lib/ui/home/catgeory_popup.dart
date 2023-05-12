import 'package:flutter/material.dart';
import 'package:money_management/models/category/category.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

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
              child: ElevatedButton(onPressed: () {}, child: const Text('Add')),
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
