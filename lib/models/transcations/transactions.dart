import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category.dart';
part 'transactions.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String purpose;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final CategoryType categoryType;

  @HiveField(5)
  final CategoryModel categoryModel;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.categoryType,
      required this.categoryModel}) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
