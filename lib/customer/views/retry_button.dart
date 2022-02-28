import 'dart:ui';

import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final Function onPressed;
  final String errorMessage;
  final bool colored;

  RetryButton({
    this.errorMessage,
    this.onPressed,
    this.colored = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            MaterialButton(
              color: colored ? Theme.of(context).accentColor : Colors.white,
              onPressed: onPressed,
              child: Text(
                "Retry",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
