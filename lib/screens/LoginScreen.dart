import 'package:flutter/material.dart';
import 'package:flutter_intro/screens/Dashboard.dart';
import 'package:flutter_intro/screens/SignUp.dart';
import 'package:flutter_intro/widget/CustomTextField.dart';
import 'package:flutter_intro/widget/PasswordField.dart';
import 'package:flutter_intro/widget/PrimaryButton.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  String validation = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: Center(
        child: SingleChildScrollView(
            child: Center(
                child: Container(
                    width: width * 0.9,
                    child: Column(
                      children: [
                        Text('LOG IN', style: TextStyle(fontSize: 32.0, color: Colors.blue, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(validation,
                          style: TextStyle(fontSize: 16.0, color: Colors.red)),
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
                              if(emailController.text == '' ||
                                passwordController.text == ''){
                                  setState(() {
                                    validation = "Please fill in the empty fields";
                                  });
                              } else if (!emailController.text.contains('@')
                                  || !emailController.text.contains('.com')) {
                                setState(() {
                                  validation = "Please provide a valid email";
                                });
                              } else {
                                Navigator.pushReplacementNamed(
                                  context, Dashboard.routeName,
                                  arguments: ScreenArguments(
                                    emailController.text,
                              ));
                              }
                            }),
                        const SizedBox(
                          height: 50.0,
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
      )),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}
