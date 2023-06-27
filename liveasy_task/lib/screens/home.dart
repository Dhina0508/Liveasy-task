import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liveasy_task/main.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String user_type = "";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.25,
          ),
          Center(
            child: Text(
              "Please select your profile",
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: height * 0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Radio(
                        activeColor: Colors.black,
                        value: "Shipper",
                        groupValue: user_type,
                        onChanged: (value) {
                          setState(() {
                            user_type = value.toString();
                          });
                        }),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Image.asset("images/shiper.png"),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shipper",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text("Lorem ipsum dolor sit amet,"),
                      Text("consectetur adipiscing")
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.035,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: height * 0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Radio(
                        activeColor: Colors.black,
                        value: "Transporter",
                        groupValue: user_type,
                        onChanged: (value) {
                          setState(() {
                            user_type = value.toString();
                          });
                        }),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Image.asset("images/transporter.png"),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transporter",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text("Lorem ipsum dolor sit amet,"),
                      Text("consectetur adipiscing")
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            height: height * 0.063,
            width: width * 0.89,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all("#2E3B62".toColor()),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ))),
                onPressed: () {},
                child: Text(
                  "CONTINUE",
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
