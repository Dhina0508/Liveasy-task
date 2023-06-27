import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_task/main.dart';
import 'package:liveasy_task/screens/verify.dart';

class PhoneNumberVerfication extends StatefulWidget {
  PhoneNumberVerfication({Key? key}) : super(key: key);

  @override
  State<PhoneNumberVerfication> createState() => _PhoneNumberVerficationState();
}

class _PhoneNumberVerficationState extends State<PhoneNumberVerfication> {
  TextEditingController _controller = TextEditingController();
  String dialCodeDigits = "+91";
  String? VerificationCode;
  verifyPhonenumber({@required phoneNo, @required codedigit}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${codedigit + phoneNo}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ));
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            VerificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            VerificationCode = vID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                size: 25,
              )),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: height * 0.09,
          ),
          Center(
            child: Text(
              "Please enter your mobile number",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            "You'll receive a 6 digit code",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "to verify next",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Container(
            height: height * 0.064,
            width: width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            child: Row(children: [
              CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: "IN",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: ["+91"],
              ),
              Text(
                "-",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Mobile Number",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 19,
                        fontWeight: FontWeight.normal),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            height: height * 0.065,
            width: width * 0.9,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all("#2E3B62".toColor()),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ))),
                onPressed: () {
                  if (_controller.text != "") {
                    verifyPhonenumber(
                        phoneNo: _controller.text, codedigit: dialCodeDigits);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyOTP(
                                codedigit: dialCodeDigits,
                                verificationCode: VerificationCode,
                                phoneNo: _controller.text)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please enter a Mobile number"),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Text(
                  "CONTINUE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white),
                )),
          ),
          Spacer(),
        ]),
        bottomNavigationBar: Image.asset(
          "images/second_pg.png",
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ));
  }
}
