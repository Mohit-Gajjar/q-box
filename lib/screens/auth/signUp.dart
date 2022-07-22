import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/models/userModel.dart';
import 'package:notes_app/screens/explore.dart';
import 'package:notes_app/screens/otp/otp_verifier.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinput/pinput.dart';

class SignUp extends StatefulWidget {
  static String routeName = 'signUp';
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool otpSent = false;
  bool otpSended = false;
  bool userVerified = false;
  bool _signUpFetching = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  TextEditingController _otpController = TextEditingController();
  FocusNode _otpFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _classController = TextEditingController();
  final _courseController = TextEditingController();

  String otp = '';
  Future<void> generateOtpAndSendOtp() async {
    print("Generate Otp Methord Called");
    int one = Random().nextInt(9);
    int two = Random().nextInt(9);
    int three = Random().nextInt(9);
    int four = Random().nextInt(9);
    int five = Random().nextInt(9);
    int six = Random().nextInt(9);

    String _otp = one.toString() +
        two.toString() +
        three.toString() +
        four.toString() +
        five.toString() +
        six.toString();

    otp = _otp;
    setState(() {});
    otpSended = await OTP().sendOtp(
        _otp,
        _phoneNumberController.text,
        "QBUSER",
        _otp +
            " is your OTP for mobile number verification. Please use it to proceed with your registration for free QRIOCTYBOX Classes. This is valid for 5 minutes!",
        context);
    setState(() {});
    print(otpSended);
    print(otp);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _otpController.dispose();
    _otpFocusNode.dispose();
    _classController.dispose();
    _courseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      height: 34,
      width: 32,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      body: Container(
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Q-Box ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                  otpSent == true
                      ? otpSended == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Enter OTP sent to your phone number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(_phoneNumberController.text,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 34,
                                    child: Pinput(
                                      androidSmsAutofillMethod:
                                          AndroidSmsAutofillMethod
                                              .smsRetrieverApi,
                                      length: length,
                                      controller: _otpController,
                                      focusNode: _otpFocusNode,
                                      defaultPinTheme: defaultPinTheme,
                                      onCompleted: (pin) {
                                        setState(() {
                                          if (pin == otp) {
                                            signUp();

                                            Fluttertoast.showToast(
                                                msg:
                                                    "Phone number verified Sucessfully");
                                          } else
                                            Fluttertoast.showToast(
                                                msg: "Envalid OTP");
                                        });
                                      },
                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        height: 34,
                                        width: 32,
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          border:
                                              Border.all(color: borderColor),
                                        ),
                                      ),
                                      errorPinTheme: defaultPinTheme.copyWith(
                                        decoration: BoxDecoration(
                                          color: errorColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Didn't receive OTP?",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                TextButton(
                                    onPressed: () {
                                      setState(() => otpSent = false);
                                    },
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.underline),
                                    )),
                              ],
                            )
                          : Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: TextFormField(
                                controller: _firstNameController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _firstNameController.text = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Your First Name");
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
                                  hintText: "First Name",
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: TextFormField(
                                controller: _lastNameController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _lastNameController.text = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Your Last Name");
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
                                  hintText: "Last Name",
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                ),
                              ),
                            ),
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
                                    return ("Please Enter Your Phone Number");
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
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                                  hintText: "Email",
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: TextFormField(
                                controller: _addressController,
                                keyboardType: TextInputType.streetAddress,
                                onSaved: (value) {
                                  _addressController.text = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Your Address");
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
                                  hintText: "Address",
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
                                    return ("Password is required for signUp");
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
                                  hintText: "password",
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: TextFormField(
                                obscureText: true,
                                controller: _confirmedPasswordController,
                                onSaved: (value) {
                                  _confirmedPasswordController.text = value!;
                                },
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return ("Password is required for signUp");
                                  }
                                  if (_passwordController.text !=
                                      _confirmedPasswordController.text) {
                                    return ("Password should be same");
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
                                  hintText: "confirm password",
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
                                  _signUpFetching = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  setState(() => otpSent = true);
                                  generateOtpAndSendOtp();
                                }
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Dimensions.padding20 / 2),
                                child: Container(
                                  width: double.infinity,
                                  height: 51,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadius5),
                                  ),
                                  child: Center(
                                    child: _signUpFetching
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Sign Up",
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
                        child: Text("I am Member!"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('LogIn'),
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

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      final _email = _emailController.text.trim();
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: _email, password: _passwordController.text.trim())
            .then((uid) => {
                  setState(() {
                    _signUpFetching = false;
                  }),
                  Fluttertoast.showToast(msg: 'Sign Up Successful'),
                  Navigator.popAndPushNamed(context, Explore.routeName),
                });
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${_email}')
            .set(UserModel(
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              email: _emailController.text.trim(),
              address: _addressController.text.trim(),
              course: [],
            ).toJson())
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
    _signUpFetching = false;
    setState(() {});
  }
}
