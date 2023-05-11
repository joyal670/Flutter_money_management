import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: Material(
              child: InkWell(
                highlightColor: Colors.indigo,
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text('12 Dec'),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('XXXXXX'),
                              Text('Salary'),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
        itemCount: 50,
      ),
    );
  }
}
