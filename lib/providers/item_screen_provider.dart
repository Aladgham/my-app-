import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemsScreenProvider extends ChangeNotifier {
  List<Item> list = [];

  getItems(var id) async {
    list = [];
    final response = await http.post(
        Uri.parse("https://alshalbiapps.com/API/GetItems.php"),
        body: {"Id_shopes": id});

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];
      for (Map i in items) {
        list.add(Item(
            i['Id'], i['Name'], i['Price'], i['Description'], i['ImageUrl']));
      }
      notifyListeners();
    }
  }
}
