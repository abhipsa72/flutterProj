import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future initialise(BuildContext context) async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true,
          provisional: false,
        ),
      );
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showOverlayNotification((context) {
          return SafeArea(
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 4,
              ),
              child: ListTile(
                onTap: () {
                  OverlaySupportEntry.of(context).dismiss();
                  _checkAndNavigate(message);
                },
                leading: SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: ClipOval(
                    child: Image.asset("images/grand_logo.jpg"),
                  ),
                ),
                title: Text(
                  message['notification']['title'],
                ),
                subtitle: Text(
                  message['notification']['body'],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    OverlaySupportEntry.of(context).dismiss();
                  },
                ),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _checkAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _checkAndNavigate(message);
      },
    );
  }

  void _checkAndNavigate(Map<String, dynamic> message) {
    var type = message['data']['notification_type'];
    if (type == 'product_list') {
      final categoryId = message['data']['category_id'];
      final categoryName = message['data']['category_name'];
      _navigationService.navigateTo(
        routes.ProductsRoute,
        arguments: Category(
          categoryId: categoryId,
          name: categoryName,
        ),
      );
    } else if (type == 'product_details') {
      final productId = message['data']['product_id'];
      _navigationService.navigateTo(
        routes.ProductDetailsRoute,
        arguments: productId,
      );
    } else {
      toast(message['notification']['title']);
    }
  }
}
