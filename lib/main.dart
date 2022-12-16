import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/routes.dart';
import 'package:flutter_intro/screens/Dashboard.dart';
import 'package:flutter_intro/screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    routes: routes,
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Dashboard();
            } else {
              return LoginScreen();
            }
          }));
}
