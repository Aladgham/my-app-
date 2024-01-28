import 'dart:convert';

import 'package:e_commarce/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  var phone;
  var email;
  var pass;
  OtpScreen(this.email, this.pass, this.phone);

  @override
  State<OtpScreen> createState() => _OtpScreenState(email, pass, phone);
}

class _OtpScreenState extends State<OtpScreen> {
  var phone;
  var email;
  var pass;
  _OtpScreenState(this.email, this.pass, this.phone);
  TextEditingController otpController = TextEditingController();
  var otpBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                const Text("Enter sms code"),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: otpController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(fillColor: Colors.amber),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          otpSendCode();
                        },
                        child: const Text("sendCode")),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          otpValidationCode();
                        },
                        child: const Text("Varification")),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void otpSendCode() async {
    final response = await http
        .post(Uri.parse("https://alshalbiapps.com/API/otp.php"), body: {
      'Phone': phone,
    });
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
      var otpCode = jsonBody['code'];
      if (otpCode != null) {
        print(otpCode);
        otpBody = otpCode;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AboutDialog(
              children: [Text("Faild")],
            );
          },
        );
      }
    }
  }

  void otpValidationCode() {
    if (otpBody == otpController.text) {
      _signUpPost();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Faild code"),
          );
        },
      );
    }
  }

  void _signUpPost() async {
    final response = await http
        .post(Uri.parse("https://alshalbiapps.com/API/SignUp.php"), body: {
      'Email': email,
      'UserName': "",
      'Phone': phone,
      'Password': pass,
    });

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
      print(response.body);
      Fluttertoast.showToast(msg: "the rigister is compleated");
    } else {
      Fluttertoast.showToast(msg: "please enter valid value");
    }
  }
}
