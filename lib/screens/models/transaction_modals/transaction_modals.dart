import 'package:hive_flutter/adapters.dart';
import 'package:money_management/screens/models/category/category_model.dart';
part 'transaction_modals.g.dart';

@HiveType(typeId: 2)
class TransactionModals {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final CategoryModel category;

  TransactionModals({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}
