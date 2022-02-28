import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grand_uae/colors.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/notificaions/notification_count_model.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/network/connectivity_service.dart';
import 'package:grand_uae/notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator.dart';
import 'router.dart' as router;

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  kNotificationSlideDuration = const Duration(milliseconds: 500);
  kNotificationDuration = const Duration(milliseconds: 1500);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(
    RestartWidget(
      child: OverlaySupport(
        child: GrandApp(),
      ),
    ),
  );
}

class GrandApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (_) => ConnectivityService().connectionStream,
        ),
        ChangeNotifierProvider(
          create: (_) => CartProductModel([]),
        ),
        ChangeNotifierProvider(
          create: (_) => OnNotifications([]),
        ),
        ChangeNotifierProvider<NotificationCountModel>(
          create: (_) => NotificationCountModel(),
        ),
      ],
      child: MaterialApp(
        initialRoute: routes.StartupRoute,
        /*builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(widget),
          ),
        ),*/
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Grand Hyper Market',
        theme: ThemeData(
          brightness: Brightness.light,
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
          buttonTheme: ButtonThemeData(shape: shape),
          dialogTheme: DialogTheme(shape: shape),
          primarySwatch: grandOrange,
          appBarTheme: AppBarTheme(
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.grey[900],
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
