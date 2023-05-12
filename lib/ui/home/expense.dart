import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/catgeory/category_db.dart';
import '../../models/category/category.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDb().expenceList,
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
