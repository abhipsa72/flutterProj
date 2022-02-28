import 'package:flutter/material.dart';

class ColorProgress extends StatelessWidget {
  final Color _color;

  ColorProgress(this._color);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(
        _color,
      ),
    );
  }
}
