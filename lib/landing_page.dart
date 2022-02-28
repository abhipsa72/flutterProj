import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final pdfUrl =
        "https://drive.google.com/file/d/16r6Xesm_xlm3L-igzyMa4njcbWjdjanw/view?usp=sharing";
    bool downloading = false;
    var progress = "";
    var path = "No Data";
    var platformVersion = "Unknown";
    Permission permission1 = Permission.WriteExternalStorage;
    var _onPressed;
    final Random random = Random();
    Directory externalDir;
    Future<void> downloadFile() async {
      Dio dio = Dio();
      bool checkPermission1 =
          await SimplePermissions.checkPermission(permission1);
      // print(checkPermission1);
      if (checkPermission1 == false) {
        await SimplePermissions.requestPermission(permission1);
        checkPermission1 = await SimplePermissions.checkPermission(permission1);
      }
      if (checkPermission1 == true) {
        String dirloc = "";
        if (Platform.isAndroid) {
          dirloc = "/sdcard/download/";
        } else {
          dirloc = (await getApplicationDocumentsDirectory()).path;
        }

        var randid = random.nextInt(10000);

        try {
          FileUtils.mkdir([dirloc]);
          await dio.download(pdfUrl, dirloc + randid.toString() + ".pdf",
              onReceiveProgress: (receivedBytes, totalBytes) {
            setState(() {
              downloading = true;
              progress =
                  ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            });
          });
        } catch (e) {
          print(e);
        }

        setState(() {
          downloading = false;
          progress = "Download Completed.";
          path = dirloc + randid.toString() + ".pdf";
        });
      } else {
        setState(() {
          progress = "Permission Denied!";
          _onPressed = () {
            downloadFile();
          };
        });
      }
    }

    @override
    void initState() {
      super.initState();
      downloadFile();
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.blueGrey, Colors.black, Colors.black])
            // image: DecorationImage(
            //     image: AssetImage("assets/background.jpeg"),
            //     fit: BoxFit.cover)
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                    "assets/port.jpeg",
                  ))),
              // child: CircleAvatar(
              //   backgroundImage: ExactAssetImage(
              //     "assets/port.jpeg",
              //   ),
              //   minRadius: 30,
              //   maxRadius: 70,
              // ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Text(
              "Hi there,My name is",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Abhipsa Samantaray",
              style: TextStyle(
                  fontSize: 30.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Flutter developer with an experience over 1 year",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 15.5,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  Text(
                    "Resume",
                    style: TextStyle(color: Colors.white, fontSize: 10.2),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.5,
            ),
            Text(
              "Contact with me:",
              style: TextStyle(color: Colors.white, fontSize: 20.5),
            ),
            SizedBox(
              height: 9.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Image.asset("assets/linkedIn.png",
                      height: 40.0, width: 40.0),
                  onTap: () => launch(
                      "https://www.linkedin.com/in/abhipsa-samantaray-730517172"),
                ),
                SizedBox(width: 5.0),
                GestureDetector(
                  child: Image.asset("assets/facebook.png",
                      height: 39.0, width: 39.0),
                  onTap: () => launch(
                      "https://www.facebook.com/profile.php?id=100008149938958"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
