import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

class CheckOut extends StatefulWidget {
  static String routeName = 'checkout';
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool creditDebitValue = false;
  bool upiValue = false;
  bool payTmValue = false;
  bool netBankingValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(Dimensions.padding20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Summary',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Checkbox(
                value: this.creditDebitValue,
                onChanged: (bool? value) {
                  setState(() {
                    this.creditDebitValue = value!;
                    upiValue = !value;
                    payTmValue = !value;
                    netBankingValue = !value;
                  });
                },
              ),
              title: Text('Credit Card / Debit Card'),
            ),
            ListTile(
              leading: Checkbox(
                value: this.upiValue,
                onChanged: (bool? value) {
                  setState(() {
                    this.upiValue = value!;
                    creditDebitValue = !value;
                    payTmValue = !value;
                    netBankingValue = !value;
                  });
                },
              ),
              title: Text('Upi'),
            ),
            ListTile(
              leading: Checkbox(
                value: this.payTmValue,
                onChanged: (bool? value) {
                  setState(() {
                    this.payTmValue = value!;
                    creditDebitValue = !value;
                    upiValue = !value;
                    netBankingValue = !value;
                  });
                },
              ),
              title: Text('PayTm'),
            ),
            ListTile(
              leading: Checkbox(
                value: this.netBankingValue,
                onChanged: (bool? value) {
                  setState(() {
                    this.netBankingValue = value!;
                    creditDebitValue = !value;
                    upiValue = !value;
                    payTmValue = !value;
                  });
                },
              ),
              title: Text('Net Banking'),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                color: Colors.amber,
                padding: EdgeInsets.all(Dimensions.padding20),
                onPressed: () {

                },
                child: Text(
                  'Proceed',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
