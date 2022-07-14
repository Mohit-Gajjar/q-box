import 'package:flutter/material.dart';
import 'package:notes_app/screens/auth/login.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPath extends StatefulWidget {
  static String routeName = "authPath";
  const AuthPath({Key? key}) : super(key: key);

  @override
  State<AuthPath> createState() => _AuthPathState();
}

class _AuthPathState extends State<AuthPath> {
  @override
  void initState() {
    getLoggedInSharedPrefs();
    super.initState();
  }

  bool isLogged = false;
  getLoggedInSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLogged = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogged ? TabsScreen() : Login(),
    );
  }
}
