import 'package:flutter/material.dart';

import './transaction_item.dart';
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No transactions added yet !',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * .4,
                    child: Image.asset(
                      'assets/images/myimage.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
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
              // key is passed here just for understanding or remember, no use in this widget
              // key is most useful in statelfull widgets which are direct child of a list, in that
              // case to when a list element is removed, flutter goes through the element tree and
              // removes the element and state object that corresponds to the deleted widget (otherwise 
              // flutter will not check 'key' configuration in a element of a widget and may attach this
              // element to another widget and remove the element and state of that another widget instead)
              return TransactionItem(
                key: ValueKey(transactions[index].id),
                transaction: transactions[index],
                deleteTransactionEntry: deleteTransactionEntry,
              );
            },
          );
  }
}
