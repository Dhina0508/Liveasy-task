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

    // String? VerificationCode;
    // final TextEditingController _pinotpcontroller = TextEditingController();
    // final FocusNode _pinotpfocusnode = FocusNode();

    // verifyPhonenumber({@required phone, @required codeDigits}) async {
    //   await FirebaseAuth.instance.verifyPhoneNumber(
    //       phoneNumber: "${codeDigits + phone}",
    //       verificationCompleted: (PhoneAuthCredential credential) async {
    //         await FirebaseAuth.instance
    //             .signInWithCredential(credential)
    //             .then((value) {
    //           if (value.user != null) {
    //             Navigator.push(context,
    //                 MaterialPageRoute(builder: (context) => Login_Page()));
    //           }
    //         });
    //       },
    //       verificationFailed: (FirebaseAuthException e) {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text(e.message.toString()),
    //           duration: Duration(seconds: 3),
    //         ));
    //       },
    //       codeSent: (String vID, int? resentToken) {
    //         setState(() {
    //           VerificationCode = vID;
    //         });
    //       },
    //       codeAutoRetrievalTimeout: (String vID) {
    //         setState(() {
    //           VerificationCode = vID;
    //         });
    //       },
    //       timeout: Duration(seconds: 60));
    // }

    // String dialCodeDigits = "+91";
    // var otp = "";
    // TextEditingController _controller = TextEditingController();
    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent,
    //     ),
    //     body: Stack(
    //       children: [
    //         // Image.asset(
    //         //   'images/chennai.jpg',
    //         //   fit: BoxFit.cover,
    //         //   width: MediaQuery.of(context).size.width,
    //         //   height: MediaQuery.of(context).size.height,
    //         // ),
    //         SingleChildScrollView(
    //           child: SafeArea(
    //               child: Center(
    //             child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     'Welcome',
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontFamily: 'Cinzel',
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 30),
    //                   ),
    //                   SizedBox(
    //                     height: 100,
    //                   ),
    //                   SizedBox(
    //                       width: 150,
    //                       height: 50,
    //                       child: DecoratedBox(
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(10),
    //                           color: Color.fromARGB(88, 247, 225, 225),
    //                         ),
    //                         child: CountryCodePicker(
    //                           onChanged: (country) {
    //                             setState(() {
    //                               dialCodeDigits = country.dialCode!;
    //                             });
    //                           },
    //                           initialSelection: "IN",
    //                           showCountryOnly: false,
    //                           showOnlyCountryWhenClosed: false,
    //                           favorite: ["+91"],
    //                         ),
    //                       )),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(15.0),
    //                     child: TextField(
    //                       style: TextStyle(
    //                           color: Colors.white, fontWeight: FontWeight.bold),
    //                       decoration: InputDecoration(
    //                           border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(10)),
    //                           fillColor: Color.fromARGB(88, 247, 225, 225),
    //                           filled: true,
    //                           suffixIcon: TextButton(
    //                               onPressed: () {
    //                                 verifyPhonenumber(
    //                                     codeDigits: dialCodeDigits,
    //                                     phone: _controller.text);
    //                                 setState(() {
    //                                   otp = "1";
    //                                 });
    //                               },
    //                               child: Text(
    //                                 'Send OTP',
    //                                 style: TextStyle(
    //                                   color: Color.fromARGB(200, 236, 13, 54),
    //                                 ),
    //                               )),
    //                           hintText: "Phone Number",
    //                           hintStyle: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.normal),
    //                           prefix: Padding(
    //                             padding: const EdgeInsets.all(3.0),
    //                             child: Text(
    //                               dialCodeDigits,
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           )),
    //                       maxLength: 10,
    //                       keyboardType: TextInputType.number,
    //                       controller: _controller,
    //                     ),
    //                   ),
    //                   otp == "1"
    //                       ? Column(
    //                           children: [
    //                             SizedBox(
    //                               height: 50,
    //                             ),
    //                             Text(
    //                               'Enter OTP : ',
    //                               style: TextStyle(
    //                                   fontSize: 20,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white),
    //                             ),
    //                             Padding(
    //                                 padding: EdgeInsets.only(
    //                                     top: 20, left: 30, right: 30, bottom: 30),
    //                                 child: Pinput(
    //                                   closeKeyboardWhenCompleted: false,
    //                                   length: 6,
    //                                   focusNode: _pinotpfocusnode,
    //                                   controller: _pinotpcontroller,
    //                                   pinAnimationType: PinAnimationType.fade,
    //                                   onSubmitted: (pin) async {
    //                                     try {
    //                                       await FirebaseAuth.instance
    //                                           .signInWithCredential(
    //                                               PhoneAuthProvider.credential(
    //                                                   verificationId:
    //                                                       VerificationCode!,
    //                                                   smsCode: pin))
    //                                           .then((value) {
    //                                         if (value.user != null) {
    //                                           Navigator.push(
    //                                               context,
    //                                               MaterialPageRoute(
    //                                                   builder: (context) =>
    //                                                       Login_Page()));
    //                                         }
    //                                       });
    //                                     } catch (e) {
    //                                       FocusScope.of(context).unfocus();
    //                                       ScaffoldMessenger.of(context)
    //                                           .showSnackBar(SnackBar(
    //                                         content: Text("Invalid OTP"),
    //                                         duration: Duration(seconds: 3),
    //                                       ));
    //                                     }
    //                                   },
    //                                   defaultPinTheme: PinTheme(
    //                                     width: 50,
    //                                     height: 50,
    //                                     textStyle: TextStyle(
    //                                         fontSize: 20,
    //                                         color: Colors.white,
    //                                         fontWeight: FontWeight.w600),
    //                                     decoration: BoxDecoration(
    //                                       border: Border.all(
    //                                           color: Color.fromRGBO(
    //                                               234, 239, 243, 1),
    //                                           width: 2),
    //                                       borderRadius: BorderRadius.circular(20),
    //                                     ),
    //                                   ),
    //                                 )),
    //                           ],
    //                         )
    //                       : Container()
    //                 ]),
    //           )),
    //         )
    //       ],
    //     ),
    //   );
    // }
//   }
// }
