import 'package:e_commarce/providers/main_screen_provider.dart';
import 'package:e_commarce/screens/categories_screen.dart';
import 'package:e_commarce/screens/login.dart';
import 'package:e_commarce/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shop_items_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedColor = Colors.blueGrey[200];
  var listImage = [];
  var catType = "";
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<MainScreenProvider>(context, listen: false).getImageBanner();
    Provider.of<MainScreenProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.black54,
                )),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: height / 5,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 9, 74, 128),
                    Color.fromARGB(255, 24, 118, 196),
                  ],
                ),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ));
                  },
                  child: const ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/anjad.png"),
                    ),
                    title: Text(
                      "Anjad Khalaf",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Flutter developer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: height - height / 4 - 10,
                width: width,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text("Home Page"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart_sharp),
                      title: const Text("Order History"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Logout"),
                      onTap: () {
                        Navigator.pop(context);
                        _logOut();
                      },
                      trailing: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 3,
              color: Colors.white,
              child: Consumer<MainScreenProvider>(
                builder: (context, value, child) {
                  return Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 9, 74, 128),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: width - 30,
                          child: Image.network(
                            value.bannerImageList[index].img,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      itemCount: value.bannerImageList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: width,
              height: height / 10 / 1.2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoriesScreen(),
                              ));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 9, 74, 128),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Consumer<MainScreenProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Container(
                      width: width,
                      height: height / 10 / 1.5,
                      color: Colors.white,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                value.indexSelected = index;
                                selectedIndex = index;
                                catType = value.catList[index].catTitle;
                              });
                              Provider.of<MainScreenProvider>(context,
                                      listen: false)
                                  .getShops();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index == selectedIndex
                                    ? Colors.white
                                    : const Color.fromARGB(255, 9, 74, 128),
                                borderRadius: BorderRadius.circular(80),
                                border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(255, 9, 74, 128),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    value.catList[index].catTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: index == selectedIndex
                                          ? const Color.fromARGB(
                                              255, 9, 74, 128)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: value.catList.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      width: width,
                      height: height / 10 / 1.2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  catType,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Collections",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back,
                                textDirection: TextDirection.rtl,
                                color: Color.fromARGB(255, 9, 74, 128),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Consumer<MainScreenProvider>(
              builder: (context, value, child) {
                return Container(
                  height: height,
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopItems(
                                        shopName: value.shopesList[index].title,
                                        shopId: value.shopesList[index].id,
                                      )));
                        },
                        leading: Image.network(
                          value.shopesList[index].img,
                        ),
                        title: Text(value.shopesList[index].title),
                        subtitle: Text(value.shopesList[index].subTitle),
                        trailing: const Icon(
                          Icons.arrow_back,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                    itemCount: value.shopesList.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('UserId', "");
    prefs.setString('UserName', "");
    prefs.setString('Email', "");
    prefs.setString('phone', "");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }
}
