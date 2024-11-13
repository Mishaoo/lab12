import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/reset_password_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
