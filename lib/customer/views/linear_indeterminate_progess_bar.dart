import 'package:flutter/material.dart';

class LinearIndeterminateProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2.0,
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Theme.of(context).textTheme.headline6.color,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
