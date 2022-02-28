import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zel_app/constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage> {
  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle ?? 'Not set'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(userDetailsBox).listenable(),
        builder: (_, Box box, __) {
          Hive.openBox(userDetailsBox);
          String name = box.get(userNameBoxKey);
          String email = box.get(userEmailBoxKey);
          String number = box.get(userContactNoKey);
          return Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
                backgroundColor: Colors.deepOrange,
              ),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _infoTile('Name', name.toString()),
                    _infoTile('Email Id', email.toString()),
                    _infoTile('phone no.', number.toString()),
                  ],
                ),
              ));
        });
  }
}
