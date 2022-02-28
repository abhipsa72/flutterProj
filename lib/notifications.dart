import 'package:flutter/material.dart';

class OnNotifications extends ValueNotifier<List<Map<String, dynamic>>> {
  OnNotifications(List<Map<String, dynamic>> value) : super(value);

  void addItem(Map<String, dynamic> message) {
    print(message);
    value.add(message);
    notifyListeners();
  }
}
