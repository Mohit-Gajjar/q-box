import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/auth/login.dart';
import '../../utilities/dimensions.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
       
          await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim())
          .then((value) => Navigator.push(context, 
          MaterialPageRoute(builder: (context) => Login()) ));
    }
    on FirebaseAuthException catch(e){
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Dimensions.screenWidth,
          height: Dimensions.screenHeight,
          padding: EdgeInsets.all(Dimensions.padding20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadius12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadius12),
                    ),
                    hintText: "enter your forget password",
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordReset();
                          // _signInFetching = true;
                        });
                      //  FirebaseAuth.instance
                      //       .sendPasswordResetEmail(
                      //           email: _emailController.text.trim())
                      //       .then((value) => 
                      //   Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => Login()),
                      //           )
                      //           );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.padding20 / 2),
                        child: Container(
                          width: 200,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.borderRadius5),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
