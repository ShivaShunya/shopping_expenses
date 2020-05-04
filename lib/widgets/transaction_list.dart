import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionEntry;

  TransactionList(this.transactions, this.deleteTransactionEntry);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No transactions added yet !',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * .4,
                    child: Image.asset(
                      'assets/images/myimage.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kipte sala...😒😒😒 !',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (itemContext, index) {
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
                              child: Text(transactions[index]
                                  .amount
                                  .toStringAsFixed(2)),
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
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? FlatButton.icon(
                          onPressed: () {
                            deleteTransactionEntry(transactions[index].id);
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
                            deleteTransactionEntry(transactions[index].id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
