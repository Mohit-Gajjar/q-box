import 'package:flutter/material.dart';
import 'package:notes_app/screens/batches/batches_screen.dart';
import 'package:notes_app/screens/payments/checkout_page.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';

class PaymentOption extends StatefulWidget {
  static String routeName = 'paymentOption';
  const PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  bool activateMaterial = true;

  @override
  Widget build(BuildContext context) {
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
                                    'Lorem text ipsoum trvg sxjvvtybuancimiubaickvai bucicm',
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Rs.1000/Inc Gst',
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
                                        // Navigator.pushNamed(
                                        //     context, CheckOut.routeName);

                                        Navigator.pushNamed(
                                            context, BatchesScreen.routeName);
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
                                    'Lorem text ipsoum trvg sxjvvtybuancimiubaickvai bucicm',
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Rs.6000/Inc Gst',
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
                                        Navigator.pushNamed(
                                            context, CheckOut.routeName);
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
                                    'Lorem text ipsoum trvg sxjvvtybuancimiubaickvai bucicm',
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Rs.1000/Inc Gst',
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
                                        Navigator.pushNamed(
                                            context, CheckOut.routeName);
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
                                    '2 Year',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Lorem text ipsoum trvg sxjvvtybuancimiubaickvai bucicm',
                                    textAlign: TextAlign.center,
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Rs.6000/Inc Gst',
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
                                        Navigator.pushNamed(
                                            context, CheckOut.routeName);
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
                    Navigator.pushNamed(context, TabsScreen.routeName),
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
