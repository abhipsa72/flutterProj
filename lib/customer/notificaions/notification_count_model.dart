import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/notification_payload.dart';
import 'package:grand_uae/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationCountModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  List<NotificationPayload> _notificationList = [];

  List<NotificationPayload> get notificationList => _notificationList;

  void addNotification(NotificationPayload payload) {
    print(payload.data.categoryName);
    _notificationList.add(payload);
    print(_notificationList.length);
    notifyListeners();
  }

  void goToNotificationList() {
    _navigationService.navigateTo(routes.NotificationListRoute);
  }
}
