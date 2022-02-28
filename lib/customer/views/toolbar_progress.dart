import 'package:flutter/material.dart';

class ToolbarProgress extends StatelessWidget {
  final Stream<bool> _isLoading;

  ToolbarProgress(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLoading,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return SizedBox(
            height: 2.0,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).textTheme.headline6.color,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        } else
          return Container();
      },
    );
  }
}
