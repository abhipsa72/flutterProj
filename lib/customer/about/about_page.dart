import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _info = info;
    });
  }

  PackageInfo _info = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Widget _infoTile(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return GestureDetector(
      onLongPress: () {
        Provider.of<FirebaseMessaging>(
          context,
          listen: false,
        ).getToken().then((value) {
          print(value);
          Clipboard.setData(
            ClipboardData(text: value),
          );
        });
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Token copied'),
          ),
        );
      },
      child: Text(
        "$title $subtitle[${_info.buildNumber}]",
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onLongPress: () async {
                  _navigationService.navigateTo(
                    routes.AdminLoginRoute,
                  );
                },
                onDoubleTap: () {
                  _navigationService.navigateTo(
                    routes.PushNotificationLoginRoute,
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("images/grand_logo.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Grand Hyper Market",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            _infoTile(
              context,
              "Version",
              _info.version,
            ),
            GestureDetector(
              onTap: () async {
                var url =
                    "https://www.grandhypermarkets.com/$useCountryCode/about_us";
                if (await canLaunch(url)) {
                  launch(url);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About us",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Copyright © 2020 Grand Hyper. All Rights Reserved.Design by Grand Hyper",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendingMail() async {
    await FLog.exportLogs();
    final path = "${await _localPath}/${Constants.DIRECTORY_NAME}";
    var file = File("$path/flog.txt");

    var buffer = '<p>App: Grand Hyper</p>'
        '<p>Version: ${_info.version}[${_info.buildNumber}]</p>'
        '<p>Package Name: ${_info.packageName}</p>';

    final Email email = Email(
      body: 'The attachment contains logs from App<br /> ${buffer.toString()}',
      subject: 'Grand Hyper Logs',
      recipients: ['hemanth@grandhyper.com'],
      attachmentPaths: [file.path],
      isHTML: true,
    );
    await FlutterEmailSender.send(email);
  }
}

Future<String> get _localPath async {
  var directory;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getExternalStorageDirectory();
  }
  return directory.path;
}
