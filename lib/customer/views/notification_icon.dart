import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/notifications.dart';
import 'package:grand_uae/show_model.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnNotifications>(
      builder: (_, model, child) {
        if (model.value == null) {
          return Container();
        }
        return Builder(
          builder: (BuildContext context) {
            return Badge(
              badgeColor: Theme.of(context).canvasColor,
              position: BadgePosition.topEnd(
                top: 0,
                end: 3,
              ),
              animationDuration: Duration(
                milliseconds: 300,
              ),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                "${context.watch<OnNotifications>().value.length}".toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 11,
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  if (model.value.isNotEmpty) {
                    // model.goToNotificationList();
                  } else {
                    showModel(
                      "No new notifications",
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
