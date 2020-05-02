import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double spendingPercentage;

  ChartBar(
      {@required this.day,
      @required this.amount,
      @required this.spendingPercentage});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              child: Text(
                amount.toStringAsFixed(0),
                style: TextStyle(
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          Text(
            'Rs/-',
            style: TextStyle(
              color: Colors.brown,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 70,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 70 * (1 - spendingPercentage),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Card(
            elevation: 5,
            color: Colors.green[200],
            child: Container(
              height: 15,
              width: 20,
              child: FittedBox(
                child: Text(day),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
