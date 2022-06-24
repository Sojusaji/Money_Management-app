import 'package:flutter/material.dart';
import 'package:money_management/screens/db/category/category_db.dart';
import 'package:money_management/screens/models/category/category_model.dart';

ValueNotifier<CategoryType> SelectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
final _nameEditingController = TextEditingController();
Future<void> ShowCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Category Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = SelectedCategoryNotifier.value;
                    final _category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    CategoryDB.instance.insertCategory(_category);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add')),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: SelectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    SelectedCategoryNotifier.value = value;
                    SelectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
