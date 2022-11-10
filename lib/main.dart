import 'package:flutter/material.dart';
import 'package:flutter_intro/routes.dart';
import 'package:flutter_intro/screens/LoginScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
}
