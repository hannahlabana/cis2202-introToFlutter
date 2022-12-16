import 'package:firebase_auth/firebase_auth.dart';

class EmailPassService {
  Future EmailPassSignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: , password: password)
  }


}