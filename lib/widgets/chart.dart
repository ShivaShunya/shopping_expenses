import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransantions;

  Chart(this.recentTransantions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
        days: index,
      ));
      double totalSum = 0;

      for (var i = 0; i < recentTransantions.length; i++) {
        if (recentTransantions[i].date.day == weekDay.day &&
            recentTransantions[i].date.month == weekDay.month &&
            recentTransantions[i].date.year == weekDay.year) {
          totalSum += recentTransantions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalInAWeek {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.lightGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((value) {
            return ChartBar(
              day: value['day'],
              amount: value['amount'],
              spendingPercentage: totalInAWeek > 0 
                                  ? (value['amount'] as double) / totalInAWeek 
                                  : 0,
            );
          }).toList(),
        ),
      ),
    );
  }
}
