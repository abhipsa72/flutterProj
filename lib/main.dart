import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/landing_page.dart';

void main() {
  runApp(MyFirst());
}

class MyFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
