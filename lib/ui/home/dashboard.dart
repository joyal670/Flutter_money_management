import 'package:flutter/material.dart';
import 'package:money_management/db/catgeory/category_db.dart';
import 'package:money_management/ui/home/add_transations.dart';
import 'package:money_management/models/category/category.dart';
import 'package:money_management/ui/home/category.dart';
import 'package:money_management/ui/home/catgeory_popup.dart';
import 'package:money_management/ui/home/home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPageIndex = 0;
  final _currentPage = const [HomeScreen(), CategoryScreen()];
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Money Manager",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Scaffold(
        body: _currentPage[_currentPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          selectedItemColor: Colors.amber,
          onTap: (value) {
            setState(() {
              _currentPageIndex = value;
              selectedIndexNotifier.value = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('home');
            Navigator.of(context).pushNamed(AddTranscations.routeName);
          } else {
            print('category');
            // final sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'travel',
            //     type: CategoryType.expense);
            // categoryDb().insertCategory(sample);
            showCategory(context);
          }
        },
        elevation: 12,
        highlightElevation: 100,
        tooltip: 'Add details',
        child: Text("Add"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
