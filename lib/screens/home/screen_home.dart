import 'package:flutter/material.dart';
import 'package:money_management/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_management/screens/category/category_add_popup.dart';
import 'package:money_management/screens/category/screen_category.dart';
import 'package:money_management/screens/db/category/category_db.dart';
import 'package:money_management/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management/screens/models/category/category_model.dart';
import 'package:money_management/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [ScreenTransaction(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext ctx, int updatedIndex, Widget? _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
            print('Add transactions');
          } else {
            print('Add category');
            ShowCategoryAddPopup(context);
            /*final _sample = CategoryModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: 'Travel',
              type: CategoryType.expense,
            );
            CategoryDB().insertCategory(_sample);*/
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
