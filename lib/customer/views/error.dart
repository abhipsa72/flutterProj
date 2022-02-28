import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorMessage;
  final IconData icon;
  final Function onRetryPressed;

  const Error({
    Key key,
    this.errorMessage,
    this.icon,
    this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon ?? Icons.error,
              size: 72,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 12),
            color: Theme.of(context).accentColor,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
