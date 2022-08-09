import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/payments/fill_payment_info.dart';
import 'package:notes_app/utilities/dimensions.dart';

class PaymentOption extends StatefulWidget {
  final String courseName, cat;
  const PaymentOption({Key? key, required this.courseName, required this.cat})
      : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  bool activateMaterial = true;
  Map<String, dynamic> payments = {};
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;
  List courseDuration = [];
  List courseDurationPrice = [];
  String catName = "";
  String courseName = "";
  void getData() async {
    setState(() {
      catName = widget.cat;
      courseName = widget.courseName.toLowerCase();
      isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('cat')
        .where("title", isEqualTo: catName)
        .snapshots()
        .listen((event) {
      Map<String, dynamic> data = event.docs[0].data();
      setState(() {
        payments = data["courses"][courseName]["payment"];
        courseDuration = payments.keys.toList();
        courseDurationPrice = payments.values.toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.all(Dimensions.padding20 / 2),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 3),
                          color: Colors.black87.withOpacity(0.2),
                          blurRadius: 3,
                          spreadRadius: 2),
                    ]),
                child: Column(
                  children: [
                    Text(
                      'Payment Plans',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                    ),
                    Text(
                      'Make Life easy with the plans given',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimensions.padding20 / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            color:
                                activateMaterial ? Colors.white : Colors.grey,
                            elevation: activateMaterial ? 3 : 0,
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(Dimensions.borderRadius12),
                                bottomLeft:
                                    Radius.circular(Dimensions.borderRadius12)),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  activateMaterial = true;
                                });
                              },
                              child: Text(
                                'Month Plans',
                                style: TextStyle(
                                  color: activateMaterial
                                      ? Colors.amberAccent
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color:
                                !activateMaterial ? Colors.white : Colors.grey,
                            elevation: !activateMaterial ? 3 : 0,
                            borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(Dimensions.borderRadius12),
                                bottomRight:
                                    Radius.circular(Dimensions.borderRadius12)),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  activateMaterial = false;
                                });
                              },
                              child: Text(
                                'Year Plans',
                                style: TextStyle(
                                  color: !activateMaterial
                                      ? Colors.amberAccent
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.padding20 / 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.borderRadius12),
                          color: Colors.amber,
                        ),
                        child: activateMaterial
                            ? Row(
                                children: [
                                  Container(
                                    width: (size.width / 2) -
                                        ((Dimensions.width10) + 8),
                                    padding: EdgeInsets.all(
                                        Dimensions.padding20 / 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          courseDuration[0],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Selected Course: ${courseName}",
                                          textAlign: TextAlign.center,
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  courseDurationPrice[0] != null
                                                      ? '₹ ${courseDurationPrice[0]}/Inc GST'
                                                      : '₹ 0/Inc GST',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                'Per Month',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Live Classes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text(
                                                'Unlimited chapter\n wise practice\n question with \nindividual video\n solution ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('PDF Notes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Level Up Test')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Full Length Test ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('24*7 Doubt solving')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Teacher Review')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Parents – Teacher\n meeting')
                                          ],
                                        ),
                                        Material(
                                          color: Colors.white,
                                          type: MaterialType.button,
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadius12),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          FillPaymentInformation(
                                                            price:
                                                                courseDurationPrice[
                                                                    0],
                                                            selectedCourse:
                                                                widget
                                                                    .courseName,
                                                            duration:
                                                                courseDuration[
                                                                    0],
                                                          ))));
                                            },
                                            child: Text('Pay Now'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  Container(
                                    width: (size.width / 2) -
                                        ((Dimensions.width10) + 8),
                                    padding: EdgeInsets.all(
                                        Dimensions.padding20 / 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          courseDuration[1],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Selected Course: ${courseName}",
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                courseDurationPrice[1] != null
                                                    ? '₹ ${courseDurationPrice[1]}/Inc GST'
                                                    : '₹ 0/Inc GST',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              'Per Month',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                       Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Live Classes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text(
                                                'Unlimited chapter\n wise practice\n question with \nindividual video\n solution ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('PDF Notes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Level Up Test')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Full Length Test ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('24*7 Doubt solving')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Teacher Review')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Parents – Teacher\n meeting')
                                          ],
                                        ),
                                        Material(
                                          color: Colors.white,
                                          type: MaterialType.button,
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadius12),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          FillPaymentInformation(
                                                            price:
                                                                courseDurationPrice[
                                                                    1],
                                                            selectedCourse:
                                                                widget
                                                                    .courseName,
                                                            duration:
                                                                courseDuration[
                                                                    1],
                                                          ))));
                                            },
                                            child: Text('Pay Now'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    width: (size.width / 2) -
                                        ((Dimensions.width10) + 8),
                                    padding: EdgeInsets.all(
                                        Dimensions.padding20 / 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          courseDuration[2],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Selected Course: ${courseName}",
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                courseDurationPrice[2] != null
                                                    ? '₹ ${courseDurationPrice[2]}/Inc GST'
                                                    : '₹ 0/Inc GST',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              'Per Month',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Live Classes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text(
                                                'Unlimited chapter\n wise practice\n question with \nindividual video\n solution ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('PDF Notes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Level Up Test')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Full Length Test ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('24*7 Doubt solving')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Teacher Review')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Parents – Teacher\n meeting')
                                          ],
                                        ),
                                        Material(
                                          color: Colors.white,
                                          type: MaterialType.button,
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadius12),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          FillPaymentInformation(
                                                            price:
                                                                courseDurationPrice[
                                                                    2],
                                                            selectedCourse:
                                                                widget
                                                                    .courseName,
                                                            duration:
                                                                courseDuration[
                                                                    2],
                                                          ))));
                                            },
                                            child: Text('Pay Now'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  Container(
                                    width: (size.width / 2) -
                                        ((Dimensions.width10) + 8),
                                    padding: EdgeInsets.all(
                                        Dimensions.padding20 / 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          courseDuration[3],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Selected Course: ${courseName}",
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                courseDurationPrice[3] != null
                                                    ? '₹ ${courseDurationPrice[3]}/Inc GST'
                                                    : '₹ 0/Inc GST',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              'Per Month',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Live Classes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text(
                                                'Unlimited chapter\n wise practice\n question with \nindividual video\n solution ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('PDF Notes')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Level Up Test')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Full Length Test ')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('24*7 Doubt solving')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Teacher Review')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            Text('Parents – Teacher\n meeting')
                                          ],
                                        ),
                                        Material(
                                          color: Colors.white,
                                          type: MaterialType.button,
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadius12),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          FillPaymentInformation(
                                                            price:
                                                                courseDurationPrice[
                                                                    3],
                                                            selectedCourse:
                                                                widget
                                                                    .courseName,
                                                            duration:
                                                                courseDuration[
                                                                    3],
                                                          ))));
                                            },
                                            child: Text('Pay Now'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Dismiss',
                        style: TextStyle(fontSize: 15, letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
