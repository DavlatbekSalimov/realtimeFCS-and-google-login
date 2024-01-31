
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_fcs/pages/home_page/home.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<User?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
    return null;
  }

  //? Google login

  static Future<User?> googlLogin(BuildContext context) async {
    UserCredential? userCredential;
    GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
    if (signInAccount != null) {
      GoogleSignInAuthentication gauth = await signInAccount.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (contex) => const HomePage(),
        ),
      );
      debugPrint(
        userCredential.user.toString(),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xatolik'),
        ),
      );
    }
    return userCredential!.user;
  }
}
