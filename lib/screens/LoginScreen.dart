import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/screens/Dashboard.dart';
import 'package:flutter_intro/screens/SignUp.dart';
import 'package:flutter_intro/services/StorageService.dart';
import 'package:flutter_intro/widget/CustomTextField.dart';
import 'package:flutter_intro/widget/PasswordField.dart';
import 'package:flutter_intro/widget/PrimaryButton.dart';
import 'package:flutter_intro/services/AuthService.dart';
import 'package:flutter_intro/services/EmailPassService.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/StorageItem.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final EmailPassService _emailPassService = EmailPassService();
  final StorageService _storageService = StorageService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLogginIn = false;
  String validation = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLogginIn,
          child: SingleChildScrollView(
              child: Center(
                  child: Container(
                      width: width * 0.9,
                      child: Column(
                        children: [
                          Text('LOG IN',
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(validation,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.red)),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                              labelText: "Email",
                              hintText: "Enter your email address",
                              controller: emailController,
                              textInputType: TextInputType.emailAddress),
                          const SizedBox(
                            height: 20.0,
                          ),
                          PasswordField(
                              obscureText: obscurePassword,
                              onTap: handleObscurePassword,
                              labelText: "Password",
                              hintText: "Enter your password",
                              controller: passwordController),
                          const SizedBox(
                            height: 20.0,
                          ),
                          PrimaryButton(
                              text: "Login",
                              iconData: Icons.login,
                              onPress: () {
                                loginWithEmailPass();
                                // insert email and pass auth
                              }),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    loginWithProvider();
                                  },
                                  child: const Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.blue),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, SignUp.routeName);
                                  },
                                  child: const Text(
                                    "Don't have an account? Sign up here.",
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                            ),
                          ),
                        ],
                      )))),
        ),
      )),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  loginWithProvider() async {
    try {
      setState(() {
        isLogginIn = true;
      });
      var user = await _authService.signInWithGoogle();
      var accessToken =
          StorageItem("accessToken", user.credential?.accessToken as String);
      await _storageService.saveData(accessToken);
      Navigator.pushReplacementNamed(context, Dashboard.routeName);
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLogginIn = false;
    });
  }

  loginWithEmailPass() async {
    if (emailController.text == '' || passwordController.text == '') {
      setState(() {
        validation = "Please fill in the empty fields";
      });
    } else if (!emailController.text.contains('@') ||
        !emailController.text.contains('.com')) {
      setState(() {
        validation = "Please provide a valid email";
      });
    } else {
      try {
        setState(() {
          isLogginIn = true;
        });
        var user = await _emailPassService.EmailPassSignIn(
            emailController.text, passwordController.text);
        Navigator.pushReplacementNamed(context, Dashboard.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            validation = "No user found for that email.";
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            validation = e.toString();
          });
        }
      }
    }
  }
}
