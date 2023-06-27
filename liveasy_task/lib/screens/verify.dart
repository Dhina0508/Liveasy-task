import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  var codedigit;
  var phoneNo;

  VerifyOTP({required this.codedigit, required this.phoneNo});
  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
    );
  }
}
