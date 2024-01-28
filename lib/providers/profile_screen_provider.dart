import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProfileScreenProvider extends ChangeNotifier {
  var userName;
  var phone;
  var email;
  var id_user;
  void updateProfile() async {
    final response = await http.post(
        Uri.parse("https://alshalbiapps.com/API/UpdateProfile.php"),
        body: {
          'UserName': userName,
          'Phone': phone,
          'Email': email,
          'Id_user': id_user,
        });
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      notifyListeners();
    }
  }
}
