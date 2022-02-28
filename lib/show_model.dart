import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

OverlaySupportEntry showModel(String message, {Color color = Colors.green}) {
  return showOverlayNotification(
    (_) => SafeArea(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
    duration: Duration(
      seconds: 3,
    ),
  );
}
