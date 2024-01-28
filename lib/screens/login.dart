import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../validation/validate.dart';
import 'main_screen.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  bool validPhone = true;
  bool validPass = true;
  bool isLoggedIn = false;
  String phone = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.network(
                        'https://openclipart.org/image/800px/315443')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerPhone,
                decoration: InputDecoration(
                    errorText: !(validPhone) ? "Enter valid Phone" : null,
                    border: const OutlineInputBorder(),
                    labelText: 'Phone',
                    hintText: 'Enter valid Phone number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerPass,
                obscureText: true,
                decoration: InputDecoration(
                    errorText: !(validPass) ? "Enter valid Pass" : null,
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  onTap();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      " Create Account",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userPhone = prefs.getString('phone');

    if (userPhone != "" && userPhone != null) {
      setState(() {
        isLoggedIn = true;
        phone = userPhone;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(),
          ),
        );
      });
    }
  }

  void onTap() async {
    validPhone = Validation().validateMobile(controllerPhone.text);
    validPass = Validation().validatePassword(controllerPass.text);

    if (validPhone && validPass) {
      loginPoastApi();
    } else {
      Fluttertoast.showToast(msg: "The phone or password is not valid");
    }
  }

  void loginPoastApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse("https://alshalbiapps.com/API/login.php"), body: {
      'Phone': controllerPhone.text,
      'Password': controllerPass.text,
    });

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
      var result = jsonBody['result'];
      var msg = jsonBody['msg'];
      if (result) {
        await prefs.setString("UserId", jsonBody["Id"]);
        await prefs.setString("Email", jsonBody["Email"]);
        await prefs.setString("UserName", jsonBody["UserName"]);
        await prefs.setString("phone", jsonBody["Phone"]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ));
      } else {
        Fluttertoast.showToast(msg: msg);
      }

      print(response.body);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Faild code login"),
          );
        },
      );
    }
  }
}
