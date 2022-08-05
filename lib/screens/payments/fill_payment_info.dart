import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/screens/payments/payuIntegration.dart';
import 'package:notes_app/utilities/dimensions.dart';

class FillPaymentInformation extends StatefulWidget {
  final String selectedCourse, price;
  final String duration;
  const
  FillPaymentInformation(
      {Key? key, required this.selectedCourse, required this.price, required this.duration})
      : super(key: key);

  @override
  State<FillPaymentInformation> createState() => _FillPaymentInformationState();
}

class _FillPaymentInformationState extends State<FillPaymentInformation> {
  TextEditingController _emailController = TextEditingController();
  bool hasEnterdEmail = false;
  Map<String, dynamic> _userData = {};
  String _userId = "";
  bool hasSetedUpPayment = false;
  void fetchInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _emailController.text)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        setState(() {
          _userData = value.docs.first.data();
          hasEnterdEmail = true;
        });
      } else {
        Fluttertoast.showToast(msg: "No Account Found");
      }
    });
  }

  @override
  void initState() {
    fetchUserId();
    super.initState();
  }

  void fetchUserId() async {
    User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      _userId = user.uid;
    });
    print(_userId);
  }

  Future<String> generateHash() async {
    var digest = sha512.convert(utf8.encode(
        "${merchantKey}|${_userId}|${widget.price}|${widget.selectedCourse}|${_userData['firstName']}|${_userData['email']}|udf1|udf2|udf3|udf4|udf5||||||${saltVersion1}"));
    return digest.toString();
  }

  void fillPaymentInfo() {
    // var hash = await generateHash();
    // PaymentHelper().initializePayment(
    //   _userId,
    //   widget.price,
    //   widget.selectedCourse,
    //   _userData['firstName'],
    //   _userData['email'],
    //   _userData['phone'].toString().replaceFirst("91", ""),
    //   hash,
    // );

    initializePayment(_userData['email'], _userData['firstName'], _userData['phone'].toString().replaceFirst("91", ""), widget.price, widget.selectedCourse, widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment Information'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.done),
            onPressed: () {
              fillPaymentInfo();
            },
            label: Text("Confirm")),
        body: hasEnterdEmail
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    listTile("First Name", _userData['firstName']),
                    listTile("Last Name", _userData['lastName']),
                    listTile("Email", _userData['email']),
                    listTile("Phone Number", _userData['phone']),
                    listTile("Address", _userData['address']),
                    listTile("Selected Course", widget.selectedCourse),
                    listTile("Price", widget.price + " \Rs, Inc GST"),
                    TextButton(
                      onPressed: () => setState(() {
                        hasEnterdEmail = false;
                      }),
                      child: Text(
                        'Dismiss',
                        style: TextStyle(fontSize: 15, letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
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
                    GestureDetector(
                      onTap: () {
                        if (_emailController.text.isNotEmpty) {
                          fetchInfo();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.padding20 / 2),
                        child: Container(
                          width: double.infinity,
                          height: 51,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.borderRadius5),
                          ),
                          child: Center(child: Text("Confirm")),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}

Widget listTile(String title, String subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
  );
}
