import 'package:flutter/cupertino.dart';
import 'package:flutter_intro/screens/Dashboard.dart';
import 'package:flutter_intro/screens/LoginScreen.dart';
import 'package:flutter_intro/screens/Settings.dart';
import 'package:flutter_intro/screens/SignUp.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  Dashboard.routeName: (BuildContext context) => Dashboard(),
  Settings.routeName: (BuildContext context) => Settings(),
  SignUp.routeName: (BuildContext context) => SignUp(),
};
