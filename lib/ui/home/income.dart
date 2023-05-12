import 'package:flutter/material.dart';
import 'package:money_management/db/catgeory/category_db.dart';
import 'package:money_management/models/category/category.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDb().incomeList,
        builder: (BuildContext ctx, List<CategoryModel> category, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text(category[index].name),
                  trailing: IconButton(
                      onPressed: () {
                        categoryDb.instance.deleteCategory(category[index].id);
                      },
                      icon: Icon(Icons.delete)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: category.length,
          );
        });
  }
}
