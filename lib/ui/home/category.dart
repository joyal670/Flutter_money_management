import 'package:flutter/material.dart';
import 'package:money_management/ui/home/expense.dart';
import 'package:money_management/ui/home/income.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.amber,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 5.0,
          tabs: [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expence',
            ),
          ],
        ),
        body: TabBarView(
          children: [IncomeScreen(), ExpenseScreen()],
        ),
      ),
    );
  }
}
