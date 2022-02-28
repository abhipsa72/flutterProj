import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final _icon;
  final _statusName;
  final _statusValue;
  final _color;

  StatusCard(this._icon, this._color, this._statusName, this._statusValue);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 8,
      color: _color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
              _icon,
              color: Theme.of(context).iconTheme.color.withOpacity(0.5),
                size: 30.0,
            ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  _statusName,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _statusValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
