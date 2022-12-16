import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/screens/Settings.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

// class ScreenArguments {
//   final String message;

//   ScreenArguments(this.message);
// }

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Settings.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Center(
        child: Text('Welcome \n' + user.email!),
      ),
    );
  }
}
