import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:notes_app/models/userModel.dart';
import  'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

Future<bool> initializePayment(String email,String firstName,String? phone, String amount, String prodInf) async{
  var txn = new DateTime.now().millisecondsSinceEpoch;
  var input = "QPYCdRUI|$txn|$amount|$prodInf|${firstName}|${email}|||||||||||iqbBeP0l";
  var hash = sha512.convert(utf8.encode(input)).toString();
  if (phone!=null) {
    final response= await  PayumoneyProUnofficial.payUParams(
        email: '${email}',
        firstName: '${firstName}',
        merchantName: 'Prime Vogue',
        isProduction: true,
        merchantKey: 'QPYCdRUI',
        merchantSalt: 'iqbBeP0l',
        amount: '$amount',
        hashUrl: hash,
        productInfo: prodInf,
        transactionId: '$txn',
        showExitConfirmation:true,
        showLogs:false, // true for debugging, false for production
        userCredentials:'QPYCdRUI:' + '${email}',
        userPhoneNumber: phone
    );

    if (response['status'] == PayUParams.success)
      handlePaymentSuccess();
    if (response['status'] == PayUParams.failed)
      handlePaymentFailure(response['message']);

    return true;
  }
  return false;

}

handlePaymentSuccess(){
 print("success");
}

handlePaymentFailure(String errorMessage){
  print(errorMessage);
}