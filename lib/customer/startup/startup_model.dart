import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/service/push_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _notificationService =
      locator<PushNotificationService>();

  Future handleStartUpLogic(BuildContext context) async {
    await _notificationService.initialise(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String country = prefs.getString(selectedCountry) ?? '';
    bool isLogin = prefs.getBool(isLoggedIn) ?? false;
    if (country.isEmpty) {
      await _navigationService.navigateTo(routes.CountrySelectionRoute);
    } else {
      String token = prefs.getString(apiToken) ?? "";
      if (token.isEmpty && isLogin) {
        await _navigationService.navigateTo(routes.LoginRoute);
      } else {
        await _navigationService.navigateTo(routes.SplashRoute);
      }
    }
  }
}
