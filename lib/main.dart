import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';

void main() => runApp(LifeLineApp());

class LifeLineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Line',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4A90E2),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
      ),
      home: LoginPage(),
    );
  }
}
