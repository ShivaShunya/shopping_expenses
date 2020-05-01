import 'package:flutter/material.dart';


class NewTransaction extends StatefulWidget {
  final Function onAddNewTransaction;

  NewTransaction(this.onAddNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();

  void _onUserInput() {
    if (titleInputController.text.isEmpty) {
      print('Invalid Title entered by user for adding new transaction ! Entry ignored.');
    }
    else if (double.tryParse(amountInputController.text) == null) {
      print('Invalid Amount entered by user for adding new transaction ! Entry ignored.');
    }
    else if (double.tryParse(amountInputController.text) < 0) {
      print('Negative Amount entered by user for adding new transaction ! Entry ignored.');
    }
    else {
      widget.onAddNewTransaction(titleInputController.text, double.parse(amountInputController.text));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleInputController,
                    onSubmitted: (_) { _onUserInput();},
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    controller: amountInputController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) { _onUserInput();},
                  ),
                  FlatButton(
                    onPressed: _onUserInput,
                    child: Text('Add Transaction'),
                    textColor: Colors.purple,
                  ),
                ],
              ),
            ),
          );
  }
}