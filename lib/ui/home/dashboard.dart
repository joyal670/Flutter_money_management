import 'package:flutter/material.dart';
import 'package:money_management/ui/home/category.dart';
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
          } else {
            print('category');
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
