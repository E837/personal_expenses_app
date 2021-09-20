import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transactions_list.dart';

class ListOfExpenses extends StatefulWidget {
  final Function removeCurrentTransaction;

  ListOfExpenses(this.removeCurrentTransaction);

  @override
  _ListOfExpensesState createState() => _ListOfExpensesState();
}

class _ListOfExpensesState extends State<ListOfExpenses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sampleData[index].amount.toString()),
                ),
              ),
              radius: 30,
            ),
            title: Title(
              child: Text(
                sampleData[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              color: ThemeData.light().primaryColor,
            ),
            subtitle: Text(DateFormat.yMEd().format(sampleData[index].date)),
            trailing: IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () => widget.removeCurrentTransaction(index),
            ),
          );
        },
        itemCount: sampleData.length,
      ),
    );
  }
}
