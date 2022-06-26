import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/screens/db/category/category_db.dart';
import 'package:money_management/screens/db/transactions/transaction_db.dart';
import 'package:money_management/screens/models/category/category_model.dart';
import 'package:money_management/screens/models/transaction_modals/transaction_modals.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModals> newList, Widget? _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                final _value = newList[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          TransactionDB.instance.deleteTransaction(_value.id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        child: Text(
                          parseDate(_value.date),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: _value.type == CategoryType.income
                            ? Colors.red
                            : Colors.green,
                      ),
                      title: Text('RS ${_value.amount}'),
                      subtitle: Text(_value.category.name),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length),
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    //'${_splitedDate.last}\n${_splitedDate.first}';
    //return '${date.day}\n${date.month}';
  }
}
