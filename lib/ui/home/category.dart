import 'package:flutter/material.dart';
import 'package:money_management/ui/home/expense.dart';
import 'package:money_management/ui/home/income.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              )
            ]),
        Expanded(
          child: TabBarView(
            children: [IncomeScreen(), ExpenseScreen()],
            controller: _tabController,
          ),
        )
      ],
    );
  }
}
