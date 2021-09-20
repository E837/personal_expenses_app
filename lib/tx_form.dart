import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TxForm extends StatefulWidget {
  final Function addNewTransaction;

  TxForm(this.addNewTransaction);

  @override
  _TxFormState createState() => _TxFormState();
}

class _TxFormState extends State<TxForm> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  var dateInput;

  void submitData() {
    if (titleInput.text.isNotEmpty &&
        amountInput.text.isNotEmpty &&
        dateInput != null) {
      widget.addNewTransaction(
        titleInput.text,
        double.parse(amountInput.text),
        dateInput,
      );
      Navigator.of(context).pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            onSubmitted: (_) => submitData(),
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              labelText: 'Title',
              fillColor: Theme.of(context).primaryColor,
            ),
            controller: titleInput,
          ),
          TextField(
            onSubmitted: (_) => submitData(),
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            controller: amountInput,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(dateInput == null
                  ? 'no date picked yet'
                  : DateFormat.yMEd().format(dateInput)),
              SizedBox(width: 10),
              OutlinedButton(
                child: Text('pick date'),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 180)),
                          lastDate: DateTime.now())
                      .then((pickedDate) {
                    if (pickedDate == null) return;
                    setState(() {
                      dateInput = pickedDate;
                    });
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Add Transaction'),
            onPressed: submitData,
          ),
        ],
      ),
    );
  }
}
