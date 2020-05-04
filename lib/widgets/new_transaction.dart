import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _onAddNewTransaction;

  NewTransaction(this._onAddNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputController = TextEditingController();
  DateTime _selectedDate;

  void _onUserInput() {
    if (_titleInputController.text.isEmpty) {
      print(
          'Invalid Title entered by user for adding new transaction ! Entry ignored.');
    } else if (double.tryParse(_amountInputController.text) == null) {
      print(
          'Invalid Amount entered by user for adding new transaction ! Entry ignored.');
    } else if (double.tryParse(_amountInputController.text) < 0) {
      print(
          'Negative Amount entered by user for adding new transaction ! Entry ignored.');
    } else {
      widget._onAddNewTransaction(
        _titleInputController.text,
        double.parse(_amountInputController.text),
        _selectedDate == null ? DateTime.now() : _selectedDate,
      );
      Navigator.of(context).pop();
    }
  }

  void _showTheDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((onValue) {
      if (onValue != null) {
        setState(() {
          _selectedDate = onValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        // padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleInputController,
                onSubmitted: (_) {
                  _onUserInput();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountInputController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  _onUserInput();
                },
              ),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : DateFormat.yMMMd().format(_selectedDate),
                  ),
                  FlatButton(
                    textColor: Colors.purple,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showTheDatePicker,
                  ),
                ],
              ),
              RaisedButton(
                onPressed: _onUserInput,
                child: Text('Add Transaction'),
                textColor: Colors.white,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
