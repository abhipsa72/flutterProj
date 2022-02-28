import 'package:flutter/material.dart';

class Loading with ChangeNotifier {
  bool isLoading = false;

  setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
