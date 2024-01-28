import 'dart:convert';
import 'package:e_commarce/models/categories_model.dart';
import 'package:e_commarce/models/stores_model.dart';
import 'package:flutter/cupertino.dart';
import '../models/image_bannar_model.dart';
import 'package:http/http.dart' as http;

class MainScreenProvider extends ChangeNotifier {
  List<ImageBannarModel> bannerImageList = [];
  List<CatModels> catList = [];
  List<StoresModel> shopesList = [];
  int indexSelected = 0;

  void getImageBanner() async {
    final response = await http
        .get(Uri.parse("https://alshalbiapps.com/API/getbannerimages.php"));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var img = jsonBody['Images'];
      for (Map i in img) {
        bannerImageList.add(ImageBannarModel(i['Id'], i['ImageURL']));
      }
      notifyListeners();
    }
  }

  void getCategories() async {
    final response = await http
        .get(Uri.parse("https://alshalbiapps.com/API/GetCategories.php"));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var cat = jsonBody['categories'];
      for (Map i in cat) {
        catList.add(CatModels(i['Id'], i['Name'], i['ImageUrl']));
      }
      notifyListeners();
    }
  }

  void getShops() async {
    shopesList = [];
    final response = await http
        .post(Uri.parse("https://alshalbiapps.com/API/getshopes.php"), body: {
      'Id_categories': catList[indexSelected].catId,
    });
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shopes = jsonBody['shopes'];
      for (Map i in shopes) {
        shopesList.add(StoresModel(i['Id'], i['Name'], i['Image']));
      }
      notifyListeners();
    }
  }
}
