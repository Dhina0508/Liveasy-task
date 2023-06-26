import 'package:flutter/material.dart';
import 'package:liveasy_task/main.dart';

class Login_Page extends StatefulWidget {
  Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final lang = ["English", "Tamil", "Hindi", "Telugu"];
  String? value;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.24,
          ),
          Center(
            child: Image.asset(
              "images/image.png",
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            "Please select your Language",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text("You can change the language"),
          Text("at any time"),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.55,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  hint: Text(
                    'English',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  value: value,
                  style: TextStyle(color: Colors.black),
                  iconSize: 16 * 2,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  items: lang.map(language).toList(),
                  onChanged: (value) => setState(() {
                        this.value = value;
                      })),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          SizedBox(
            height: height * 0.06,
            width: width * 0.55,
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
                  "NEXT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> language(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ));
}
