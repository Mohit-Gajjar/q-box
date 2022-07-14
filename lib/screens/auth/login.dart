import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/auth/signUp.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _signInFetching = false;

  final _formKey = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Login Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      const Icon(Icons.person),
                      Expanded(
                        child: SizedBox(),
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/indian_flag.png'),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  Text(
                    ' Q-Box ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Dimensions.padding20 / 2),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          onSaved: (value) {
                            _phoneNumberController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Number");
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius12),
                            ),
                            hintText: "Phone Number",
                            fillColor: Colors.grey[100],
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.padding20 / 2),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius12),
                            ),
                            hintText: "Password",
                            fillColor: Colors.grey[100],
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _signInFetching = true;
                          });
                          signIn(_phoneNumberController.text,
                              _passwordController.text);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.padding20 / 2),
                          child: Container(
                            width: double.infinity,
                            height: 51,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius5),
                            ),
                            child: Center(
                              child: _signInFetching
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Sign In",
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
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Theme.of(context).primaryColor,
                      )),
                      Text("Sign up with Us"),
                      Expanded(
                          child: Divider(
                        color: Theme.of(context).primaryColor,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Not Yet Register?"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.routeName);
                        },
                        child: Text('Create Account'),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String phoneNumber, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        // await _auth.signInWithCredential()
        await _auth.signInWithPhoneNumber(phoneNumber).then((uid) => {
              setState(() {
                _signInFetching = false;
              }),
              Fluttertoast.showToast(msg: 'Sign In Successful'),
              Navigator.popAndPushNamed(context, TabsScreen.routeName),
            });
      } on FirebaseAuthException catch (error) {
        print(error);
        // switch (error.code) {
        //   case "invalid-email":
        //     errorMessage = "Your email address appears to be malformed.";
        //     break;
        //   case "wrong-password":
        //     errorMessage = "Your password is wrong.";
        //     break;
        //   case "user-not-found":
        //     errorMessage = "User with this email doesn't exist.";
        //     break;
        //   case "user-disabled":
        //     errorMessage = "User with this email has been disabled.";
        //     break;
        //   case "too-many-requests":
        //     errorMessage = "Too many requests";
        //     break;
        //   case "operation-not-allowed":
        //     errorMessage = "Signing in with Email and Password is not enabled.";
        //     break;
        //   default:
        //     errorMessage = "An undefined Error happened.";
        // }
        Fluttertoast.showToast(msg: errorMessage!);
        setState(() {
          _signInFetching = false;
        });
      }
    }
    setState(() {
      _signInFetching = false;
    });
  }
}
