import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    return Platform.isIOS ? CupertinoApp(
            title: 'Shopping & Expenses',
      theme: CupertinoThemeData(
      ),
      home: MyHomePage(),
    ) : MaterialApp(
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
    final isLandscapeMOde =
        MediaQuery.of(context).orientation == Orientation.landscape;
    const double switchButtonHight = 40;

    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Shopping & Expenses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
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

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscapeMOde)
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
                          // Making Switch adaptive to both Android + iOS
                          Switch.adaptive(
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
                          Switch.adaptive(
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
            if (_showChart || !isLandscapeMOde)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    (isLandscapeMOde ? .6 : .35),
                child: Chart(_recentTransantions),
              ),
            if (!_showChart || !isLandscapeMOde)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top -
                        (isLandscapeMOde ? switchButtonHight : 0)) *
                    (isLandscapeMOde ? 1 : .65),
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
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
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
