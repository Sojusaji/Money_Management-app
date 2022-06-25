import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:money_management/screens/category/Expense_Category_List.dart';
import 'package:money_management/screens/category/category_add_popup.dart';
import 'package:money_management/screens/db/category/category_db.dart';
import 'package:money_management/screens/models/category/category_model.dart';
import 'package:money_management/screens/models/transaction_modals/transaction_modals.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  /*
   Purpose
   Date
   Amount
   Incom/Expense
   CategoryType
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Purpose
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Purpose'),
              ),
              //Amout
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              //Calender
              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? "Select Date"
                    : _selectedDate!.toString()),
              ),

              //Category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            //  print(newValue);
                            setState(() {
                              _selectedCategoryType = CategoryType.income;
                              _categoryID = null;
                            });
                          }),
                      Text('income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategoryType,
                          onChanged: (_newValue) {
                            // print(_newValue);
                            setState(() {
                              _selectedCategoryType = CategoryType.expense;
                              _categoryID = null;
                            });
                          }),
                      Text('expense'),
                    ],
                  ),
                ],
              ),
              //Category Type
              DropdownButton<String>(
                  value: _categoryID,
                  hint: const Text('Select Category'),
                  items: (_selectedCategoryType == CategoryType.income
                          ? CategoryDB().incomeCategoryListListener
                          : CategoryDB().expenseCategoryListListener)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        print(e.toString());
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      _categoryID = selectedValue;
                    });
                    print(selectedValue);
                  }),
              //Submit
              ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amuntText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amuntText.isEmpty) {
      return;
    }
    /*if (_categoryID == null) {
      return;
    }*/
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amuntText);
    if (_parsedAmount == null) {
      return;
    }
    final _modal = TransactionModals(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
  }
}
