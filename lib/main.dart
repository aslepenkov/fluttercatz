import 'package:flutter/material.dart';
import 'package:fluttercats/pages/LoginPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Cats',
      home: new LoginPage(),
    );
  }
}
