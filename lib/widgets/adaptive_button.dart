import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Function handler;
  final String text;

  AdaptiveButton({this.handler, this.text});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          )
        : FlatButton(
            textColor: Colors.purple,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          );
  }
}
