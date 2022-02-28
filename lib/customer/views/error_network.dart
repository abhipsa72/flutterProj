import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/network_error.png',
            width: 100,
            height: 70,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 32,
            ),
            child: Text(
              "No Internet",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "Please check your internet connection and try again",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MaterialButton(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).accentColor,
            onPressed: () => SystemSettings.wireless(),
            child: Text(
              "Open settings",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
