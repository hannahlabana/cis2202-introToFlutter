import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class EmailPassService {
  Future EmailPassSignIn(email, pass) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
  }

  Future EmailPassRegister(email, pass) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );

    Future logout() async {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        return null;
      }
    }
  }
}
