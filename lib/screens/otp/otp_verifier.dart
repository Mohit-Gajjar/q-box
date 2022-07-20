import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OTP {
  final String _url = "https://api.textlocal.in/send/?";
  final String _apiKey = "NjU1MzU5NDY2YTRkNDQzNDRkNDQ0ZTY2Njc3NjQxNzk=";

  Future<bool> sendOtp(
    String otp,
    String numbers,
    String sender,
    String message,
    BuildContext context,
  ) async {
    String data = 'apikey=' +
        _apiKey +
        '&numbers=' +
        numbers +
        "&sender=" +
        sender +
        "&message=" +
        message;
    try {
      final response = await Dio().get(_url + data);
      if (response.statusCode == 200) {
        var json = response.data;
        print(json);
        if (json['status'] == "success") {
          return true;
        } else 
          return false;
      } else {
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return false;
  }
}
