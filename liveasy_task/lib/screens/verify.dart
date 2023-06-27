import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liveasy_task/main.dart';
import 'package:liveasy_task/screens/home.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  var codedigit;
  var phoneNo;

  VerifyOTP({
    required this.codedigit,
    required this.phoneNo,
  });
  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhonenumber(phoneNo: widget.phoneNo, codedigit: widget.codedigit);
  }

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

  final TextEditingController _pinotpcontroller = TextEditingController();
  final FocusNode _pinotpfocusnode = FocusNode();
  String? pins;
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
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Text(
            "Verify Phone",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            "Code is sent to ${widget.phoneNo}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Pinput(
                closeKeyboardWhenCompleted: false,
                length: 6,
                focusNode: _pinotpfocusnode,
                controller: _pinotpcontroller,
                pinAnimationType: PinAnimationType.fade,
                onCompleted: ((pin) {
                  setState(() {
                    pins = pin;
                  });
                }),
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    color: "#93D2F3".toColor(),
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't recieve the code?",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Request Again",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            height: height * 0.063,
            width: width * 0.85,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all("#2E3B62".toColor()),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ))),
                onPressed: () async {
                  print(pins.toString());
                  print(widget.phoneNo.toString());
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: VerificationCode!,
                            smsCode: pins.toString()))
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                child: Text(
                  "VERIFY AND CONTINUE",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
