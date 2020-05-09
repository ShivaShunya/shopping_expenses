import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransactionEntry,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionEntry;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[100],
      elevation: 3,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ListTile(
        leading: Card(
          elevation: 8,
          child: Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FittedBox(
                    child: Text(transaction.amount.toStringAsFixed(2)),
                  ),
                  FittedBox(
                    child: Text('Rs/-'),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).orientation == Orientation.landscape
            ? FlatButton.icon(
                onPressed: () {
                  deleteTransactionEntry(transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.blueGrey,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.blueGrey,
                onPressed: () {
                  deleteTransactionEntry(transaction.id);
                },
              ),
      ),
    );
  }
}
