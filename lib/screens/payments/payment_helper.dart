// import 'dart:convert';
//
// import 'package:crypto/crypto.dart';
// // import 'package:flutter_payu_unofficial/flutter_payu_unofficial.dart';
// // import 'package:flutter_payu_unofficial/models/payment_params_model.dart';
// // import 'package:flutter_payu_unofficial/models/payment_result.dart';
// // import 'package:flutter_payu_unofficial/models/payment_status.dart';
// import 'package:notes_app/constants/constants.dart';
//
// class PaymentHelper {
//   Future<void> initializePayment(
//     String txnId,
//     String amount,
//     String productInfo,
//     String firstName,
//     String email,
//     String phone,
//     String hash,
//   ) async {
//     String trxId = DateTime.now().millisecondsSinceEpoch.toString();
//
//     PaymentParams _paymentParam = PaymentParams(
//       merchantID: txnId,
//       merchantKey: merchantKey,
//       salt: saltVersion1,
//       amount: amount,
//       transactionID: trxId,
//       firstName: firstName,
//       email: email,
//       productName: productInfo,
//       phone: phone,
//       fURL: "https://www.payumoney.com/mobileapp/payumoney/failure.php",
//       sURL: "https://www.payumoney.com/mobileapp/payumoney/success.php",
//       udf1: "udf1",
//       udf2: "udf2",
//       udf3: "udf3",
//       udf4: "udf4",
//       udf5: "udf5",
//       udf6: "",
//       udf7: "",
//       udf8: "",
//       udf9: "",
//       udf10: "",
//       hash:
//           hash, //Hash is required will initialise with empty string now to set actuall hash later
//       isDebug: true, // true for Test Mode, false for Production
//     );
//     var bytes = utf8.encode(
//         "${_paymentParam.merchantKey}|${_paymentParam.transactionID}|${_paymentParam.amount}|${_paymentParam.productName}|${_paymentParam.firstName}|${_paymentParam.email}|udf1|udf2|udf3|udf4|udf5||||||${_paymentParam.salt}");
//     String localHash = sha512.convert(bytes).toString();
//     _paymentParam.hash = localHash;
//     //Generating local hash
//
//     try {
//       PayuPaymentResult _paymentResult =
//           await FlutterPayuUnofficial.initiatePayment(
//               paymentParams: _paymentParam, showCompletionScreen: true);
//
//       //Checks for success and prints result
//
//       // ignore: unnecessary_null_comparison
//       if (_paymentResult != null) {
//         //_paymentResult.status is String of course. Directly fetched from payU's Payment response. More statuses can be compared manually
//
//         if (_paymentResult.status == PayuPaymentStatus.success) {
//           print("Success: ${_paymentResult.response}");
//         } else if (_paymentResult.status == PayuPaymentStatus.failed) {
//           print("Failed: ${_paymentResult.response}");
//         } else if (_paymentResult.status == PayuPaymentStatus.cancelled) {
//           print("Cancelled by User: ${_paymentResult.response}");
//         } else {
//           print("Response: ${_paymentResult.response}");
//           print("Status: ${_paymentResult.status}");
//         }
//       } else {
//         print("Something's rotten here");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
