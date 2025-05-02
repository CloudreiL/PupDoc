import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../classes/bottomBar.dart';
import '../pages/logregpages/email.dart';
import '../pages/logregpages/loginpage.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return EmailVerification();
          }
          return BottomNavBar();
        } else{
          return LoginPage();
        }
      },
    );
  }
}