import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return const Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  '12\ndec',
                  textAlign: TextAlign.center,
                ),
                radius: 50,
              ),
              title: Text('RS 10000'),
              subtitle: Text('Travel'),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
