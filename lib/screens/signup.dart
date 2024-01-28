import 'package:e_commarce/screens/otp_scree.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../validation/validate.dart';
import '../widgets/otp_widget.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  bool validPhoneNumber = true;
  bool validEmail = true;
  bool validPass = true;
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
                    child: Image.asset("assets/images/aaas.png")),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                    errorText: !(validEmail) ? "Enter valid Email" : null,
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
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
                    errorText: !(validPass) ? "Enter valid Password" : null,
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    errorText:
                        !(validPhoneNumber) ? "Enter valid Phone Number" : null,
                    border: const OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: '07*******'),
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
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  void onTap() {
    validEmail = Validation().isEmail(controllerEmail.text);
    validPass = Validation().validatePassword(controllerPass.text);
    validPhoneNumber = Validation().validateMobile(controllerPhone.text);

    if (validEmail && validPass && validPhoneNumber) {
      //Navigator.push(
          //context, MaterialPageRoute(builder: (_) => const LoginPage()));
      //Fluttertoast.showToast(msg: "the register is complete");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) =>  OtpScreen(controllerEmail.text,controllerPass.text,controllerPhone.text)));
      
    } else {
      Fluttertoast.showToast(
          msg: "The email or password or phone is not valid");
      setState(() {});
    }
  }
}
