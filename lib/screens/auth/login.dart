// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/auth/signUp.dart';
import 'package:notes_app/screens/otp/otp_verifier.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool otpSent = false;
  bool otpSended = false;
  bool isVerified = false;
  TextEditingController _otpController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  FocusNode _otpFocusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

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
                otpSent
                    ? otpSended
                        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Enter OTP sent to your phone number",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Text(_phoneNumberController.text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: 34,
            child: Pinput(
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsRetrieverApi,
              length: length,
              controller: _otpController,
              focusNode: _otpFocusNode,
              defaultPinTheme: defaultPinTheme,
              onCompleted: (pin) {
                setState(() {
                  if (pin == otp) {
                     Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TabsScreen()));
                    Fluttertoast.showToast(
                        msg: "Phone number verified Sucessfully");
                  } else
                    Fluttertoast.showToast(msg: "Envalid OTP");
                });
              },
              focusedPinTheme: defaultPinTheme.copyWith(
                height: 34,
                width: 32,
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: borderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: errorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Didn't receive OTP?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextButton(
            onPressed: () {
              setState(() => otpSent = false);
            },
            child: Text(
              "Resend OTP",
              style:
                  TextStyle(fontSize: 20, decoration: TextDecoration.underline),
            )),
      ],
    )
                        : Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Verify Phone Number",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            backColor: Theme.of(context).primaryColor,
                            onTapHandler: () {
                              if (_phoneNumberController.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                              "Please enter your phone number"),
                                          actions: [
                                            FlatButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              } else {
                                setState(() => otpSent = true);
                                generateOtpAndSendOtp();
                                if (isVerified) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabsScreen()));
                                }
                              }
                            },
                            text: "Verify",
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
    );
  }
}
