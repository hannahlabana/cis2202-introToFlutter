import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/screens/LoginScreen.dart';
import 'package:flutter_intro/services/AuthService.dart';

import '../services/EmailPassService.dart';

class Settings extends StatefulWidget {
  static String routeName = "/settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _authService = AuthService();
  final EmailPassService _emailPassService = EmailPassService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                //await _emailPassService.logout();
                await _authService.logout();
                //await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.logout,
                  size: 30,
                ),
              ))
        ],
      ),
      body: const Center(
        child: Text("Welcome to Settings"),
      ),
    );
  }
}
