import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/screens/home/screen_home.dart';
import 'package:money_management/screens/models/transaction_modals/transaction_modals.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModals obj);
  Future<List<TransactionModals>> getAllTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModals>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModals obj) async {
    final _db = await Hive.openBox<TransactionModals>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    print(obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransaction();
    _list.sort((first, second) => first.date.compareTo(second.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModals>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModals>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModals>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
