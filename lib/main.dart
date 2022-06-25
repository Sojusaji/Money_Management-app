import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_management/screens/db/category/category_db.dart';
import 'package:money_management/screens/home/screen_home.dart';
import 'package:money_management/screens/models/category/category_model.dart';
import 'package:money_management/screens/models/transaction_modals/transaction_modals.dart';

Future<void> main() async {
  final obj1 = CategoryDB();
  final obj2 = CategoryDB();
  print("compare the object");
  print(obj1 == obj2);

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModalsAdapter().typeId)) {
    Hive.registerAdapter(TransactionModalsAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction()
      },
    );
  }
}
