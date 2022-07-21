
import 'package:notes_app/constants/constants.dart';
import 'package:payu_money_flutter/payu_money_flutter.dart';

class PaymentHelper {
  PayuMoneyFlutter payuMoneyFlutter = PayuMoneyFlutter();
  Future<bool> setupPayment() async {
    bool response = await payuMoneyFlutter.setupPaymentKeys(
        merchantKey: merchantKey,
        merchantID: "AwuZ5FVG4c",
        isProduction: false,
        activityTitle: "Payment Screen Title",
        disableExitConfirmation: false);
    return response;
  }

  void createPayment(
    String txnId,
    String amount,
    String productInfo,
    String firstName,
    String email,
    String phone,
    String hash,
  ) async {
    try {
      Map<String, dynamic> response = await payuMoneyFlutter.startPayment(
        txnid: txnId,
        amount: amount,
        name: firstName,
        email: email,
        phone: phone,
        productName: productInfo,
        hash: hash);
    print("EROROWROIWEURIWUERIUWRIOEU : $response");
    } catch (e) {
      print(e);
    }
  }
}
// "key" => "KSXB9Z3J",
//        "txnid" => $_POST["txnid"],
//        "amount" => $_POST["amount"],
//        "SALT_KEY" => "AwuZ5FVG4c",
//        "productinfo" => $_POST["productinfo"],
//        "firstname" => $_POST["firstname"],
//        "email" => $_POST["email"],
//        "phone"=> $_POST["phone"],
//        "udf1" => "",
//        "udf2" => "",
//        "udf3" => "",
//        "udf4" => "",
//        "udf5" => "",
//        "udf6" => "",
//        "udf7" => "",
//        "udf8" => "",
//        "udf9" => "",
//        "udf10" => ""