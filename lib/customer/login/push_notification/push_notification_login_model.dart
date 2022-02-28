import 'package:flutter/cupertino.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class PushNotificationLoginModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage;
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  PushNotificationLoginModel();

  Future<bool> login() async {
    if (emailController.text == "notification@grand.com" &&
        passwordController.text == "ghe@test.com") {
      errorMessage = null;
      return true;
    } else {
      showModel("Please check email and password");
      return false;
    }
  }

  void navigateNotification() {
    _navigationService.navigateTo(routes.PushNotificationRoute);
  }
}
