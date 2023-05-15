import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/catgeory/category_db.dart';
import 'package:money_management/db/transations/transations_db.dart';
import 'package:money_management/models/category/category.dart';

import '../../models/transcations/transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TrsansctionDb.instance.refersh();
    categoryDb().refreshUI();

    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: TrsansctionDb.instance.dataListNotifier,
            builder:
                (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemBuilder: (ctx, index) {
                  final valueData = newList[index];
                  return Slidable(
                    key: Key(valueData.id!),
                    startActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (ctx) {
                          TrsansctionDb.instance
                              .deleteTranscation(valueData.id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ]),
                    child: Card(
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
                                    CircleAvatar(
                                        backgroundColor:
                                            valueData.categoryType ==
                                                    CategoryType.income
                                                ? Colors.green
                                                : Colors.red,
                                        radius: 30,
                                        child: Text(
                                          parseDate(valueData.date),
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('RS ${valueData.amount}'),
                                        Text(valueData.categoryModel.name),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
                itemCount: newList.length,
              );
            }));
  }

  String parseDate(DateTime dateTime) {
    final _date = DateFormat.MMMd().format(dateTime);
    final _splitedData = _date.split(' ');
    return '${_splitedData.last}\n${_splitedData.first}';
  }
}
