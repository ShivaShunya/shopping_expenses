import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping & Expenses',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
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
  bool _showChart = false;
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransantions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _onAddNewTransaction(
      String titleEntered, double amountEntered, DateTime dateEntered) {
    setState(() {
      _transactions.insert(
        0,
        Transaction(
          id: DateTime.now().toString(),
          title: titleEntered,
          amount: amountEntered,
          date: dateEntered,
        ),
      );
    });
  }

  void _deleteTransactionEntry(String transactionId) {
    showAlertDialog(context, transactionId);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_onAddNewTransaction);
      },
    );
  }

  void showAlertDialog(BuildContext context, String transactionId) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Delete Transaction Alert"),
          content: Text("Please press 'Continue' to confirm..."),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text("Continue"),
              onPressed: () {
                setState(() {
                  _transactions.removeWhere((tx) => tx.id == transactionId);
                });
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double switchButtonHight = 40;
    final appbar = AppBar(
      title: Container(
        color: Colors.pink,
        height: 40,
        width: 250,
        child: Card(
          color: Colors.pink,
          elevation: 5,
          child: Text(
            'Shopping & Expenses',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: switchButtonHight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          color: Colors.grey[300],
                          child: Text('Show Weekly Chart'),
                        ),
                        Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          color: Colors.grey[300],
                          child: Text('Show Transactions'),
                        ),
                        Switch(
                          value: !_showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = !val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .35,
                    child: Chart(_recentTransantions),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) - switchButtonHight,
                    child: TransactionList(
                      _transactions,
                      _deleteTransactionEntry,
                    ),
                  ),
            // FloatingActionButton(
            //   onPressed: () {
            //     _startAddNewTransaction(context);
            //   },
            //   child: Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            //   backgroundColor: Colors.green,
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
