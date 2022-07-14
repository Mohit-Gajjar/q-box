// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/screens/otp/otp_verifier.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
            " is your OTP for mobile number verification. Please use it to proceed with your registration for free QRIOCTYBOX Classes. This is valid for 5 minutes!");
    setState(() {});
  }

  bool showError = false;
  bool otpSent = false;
  bool otpSended = false;

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
        body: otpSent
            ? otpSended
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Enter OTP sent to your phone number",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(_phoneNumberController.text,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Phone number verified Sucessfully")));
                                } else
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Envalid OTP")));
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Verify Phone Number",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                                    content:
                                        Text("Please enter your phone number"),
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
                        }
                      },
                      text: "Send OTP",
                    ),
                  ],
                ),
              ));
  }
}
