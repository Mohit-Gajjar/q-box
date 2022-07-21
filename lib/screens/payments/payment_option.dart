

import 'package:flutter/material.dart';
import 'package:notes_app/screens/course/select_course.dart';
import 'package:notes_app/screens/payments/fill_payment_info.dart';
import 'package:notes_app/utilities/dimensions.dart';

class PaymentOption extends StatefulWidget {
  static String routeName = 'paymentOption';
  const PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  bool activateMaterial = true;
  Map<String, dynamic> payments = {};

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(routeArgs['course']);
    setState(() {
      payments = routeArgs['payment'] as Map<String, dynamic>;
    });
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(Dimensions.padding20 / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.borderRadius5),
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
                      color: activateMaterial ? Colors.white : Colors.grey,
                      elevation: activateMaterial ? 3 : 0,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.borderRadius12),
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
                      color: !activateMaterial ? Colors.white : Colors.grey,
                      elevation: !activateMaterial ? 3 : 0,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.borderRadius12),
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
                              width:
                                  (size.width / 2) - ((Dimensions.width10) + 8),
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '1 Month',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Selected Course: ${routeArgs['course']}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          payments['1month'] != null
                                              ? '₹ ${payments['1month']}/Inc GST'
                                              : '₹ 0/Inc GST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                      Text('You Saves 10%')
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
                                      Text('You Saves 10%')
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
                                                          payments['1month'],
                                                      selectedCourse:
                                                          routeArgs['course'],
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
                              width:
                                  (size.width / 2) - ((Dimensions.width10) + 8),
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '6 Month',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Selected Course: ${routeArgs['course']}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          payments['6month'] != null
                                              ? '₹ ${payments['6month']}/Inc GST'
                                              : '₹ 0/Inc GST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                      Text('You Saves 12%')
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
                                      Text('You Saves 12%')
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
                                                          payments['6month'],
                                                      selectedCourse:
                                                          routeArgs['course'],
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
                              width:
                                  (size.width / 2) - ((Dimensions.width10) + 8),
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '1 year',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Selected Course: ${routeArgs['course']}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          payments['12month'] != null
                                              ? '₹ ${payments['12month']}/Inc GST'
                                              : '₹ 0/Inc GST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                      Text('You Saves 15%')
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
                                      Text('You Saves 15%')
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
                                                          payments['12month'],
                                                      selectedCourse:
                                                          routeArgs['course'],
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
                              width:
                                  (size.width / 2) - ((Dimensions.width10) + 8),
                              padding: EdgeInsets.all(Dimensions.padding20 / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "2 year",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Selected Course: ${routeArgs['course']}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          payments['24months'] != null
                                              ? '₹ ${payments['24months']}/Inc GST'
                                              : '₹ 0/Inc GST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                      Text('You Saves 18%')
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
                                      Text('You Saves 18%')
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
                                                          payments['24months'],
                                                      selectedCourse:
                                                          routeArgs['course'],
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
                onPressed: () =>
                    Navigator.pushNamed(context, SelectCourse.routeName),
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
