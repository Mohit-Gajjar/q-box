import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/screens/auth/login.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class AuthPath extends StatelessWidget {
  static String routeName = "authPath";
  const AuthPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TabsScreen();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
