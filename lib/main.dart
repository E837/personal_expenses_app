import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'models/transactions_list.dart';
import 'tx_form.dart';
import 'list_of_expenses.dart';
import 'chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Glory',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Glory',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Glory',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      sampleData.add(Transaction(
          title: title,
          amount: amount,
          date: date,
          id: DateTime.now().toString()));
    });
  }

  void removeCurrentTransaction(int index) {
    setState(() {
      sampleData.removeWhere((item) => sampleData[index].id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add a new transaction',
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return TxForm(addNewTransaction);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            //TODO: A ROUNDED MODAL SHEET?
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) {
            return TxForm(addNewTransaction);
          },
        ),
      ),
      body: Column(
        children: [
          Chart(),
          sampleData.length == 0
              ? Container(
                  height: 500,
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.scaleDown,
                    color: Theme.of(context).accentColor,
                  ),
                )
              : ListOfExpenses(removeCurrentTransaction),
        ],
      ),
    );
  }
}
