import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/transcations/transactions.dart';

const TRANSATION_DB_NAME = 'TRANSACTION_DB';

abstract class TranscationDBFunctions {
  Future<void> addTransation(TransactionModel model);
  Future<List<TransactionModel>> getTranscation();
  Future<void> deleteTranscation(String id);
}

class TrsansctionDb implements TranscationDBFunctions {
  TrsansctionDb._internal();
  static TrsansctionDb instance = TrsansctionDb._internal();

  factory TrsansctionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> dataListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransation(TransactionModel model) async {
    final db = await Hive.openBox<TransactionModel>(TRANSATION_DB_NAME);
    db.put(model.id, model);
  }

  @override
  Future<List<TransactionModel>> getTranscation() async {
    final model = await Hive.openBox<TransactionModel>(TRANSATION_DB_NAME);
    return model.values.toList();
  }

  refersh() async {
    final _list = await getTranscation();
    _list.sort((first, second) => second.date.compareTo(first.date));
    dataListNotifier.value.clear();
    dataListNotifier.value.addAll(_list);
    dataListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTranscation(String id) async {
    final model = await Hive.openBox<TransactionModel>(TRANSATION_DB_NAME);
    await model.delete(id);
    refersh();
  }
}
