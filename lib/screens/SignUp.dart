import 'package:flutter/material.dart';
import 'package:flutter_intro/screens/LoginScreen.dart';
import 'package:flutter_intro/widget/CustomTextField.dart';
import 'package:flutter_intro/widget/PasswordField.dart';
import 'package:flutter_intro/widget/PrimaryButton.dart';

class SignUp extends StatefulWidget {
  static String routeName = "/signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControllerFirst = TextEditingController();
  final TextEditingController passwordControllerSecond =TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
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
                child: Column(children: [
                  Text('SIGN UP', style: TextStyle(fontSize: 32.0, color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(validation,
                      style: TextStyle(fontSize: 16.0, color: Colors.red)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                      labelText: "First Name",
                      hintText: "Enter your first name",
                      controller: firstNameController,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                      labelText: "Last Name",
                      hintText: "Enter your last name",
                      controller: lastNameController,
                      textInputType: TextInputType.text),
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
                      obscureText: obscurePassword1,
                      onTap: handleObscurePassword1,
                      labelText: "Password",
                      hintText: "Enter your password",
                      controller: passwordControllerFirst),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                      obscureText: obscurePassword2,
                      onTap: handleObscurePassword2,
                      labelText: "Confirm Password",
                      hintText: "Enter your password again",
                      controller: passwordControllerSecond),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                      text: "Register",
                      iconData: Icons.app_registration,
                      onPress: () {
                        if(emailController.text == ''
                        || firstNameController.text == ''
                        || lastNameController.text == ''
                        || passwordControllerFirst.text == ''
                        || passwordControllerSecond.text == ''){
                          setState(() {
                            validation = "Please fill in the empty fields";
                          });
                        } else if (!emailController.text.contains('@')
                                  || !emailController.text.contains('.com')) {
                          setState(() {
                            validation = "Please provide a valid email";
                          });
                        } else if (passwordControllerFirst.text !=
                            passwordControllerSecond.text) {
                          setState(() {
                            validation = "Passwords do not match. Try again";
                          });
                        } else {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        };
                  }),
                  const SizedBox(
                    height: 50.0,
                    ),
                    Container(
                      child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, LoginScreen.routeName);
                          },
                          child: const Text(
                            "Already have an account? Sign in here.",
                            style: TextStyle(fontSize: 16.0),
                          )),
                        ),
                    ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleObscurePassword1() {
    setState(() {
      obscurePassword1 = !obscurePassword1;
    });
  }

  handleObscurePassword2() {
    setState(() {
      obscurePassword2 = !obscurePassword2;
    });
  }
}
