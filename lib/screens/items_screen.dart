import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/main_screen_provider.dart';
import 'categories_screen.dart';
class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  var selectedColor = Colors.blueGrey[200];
  var listImage = [] ;
  var catType = "";
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 3,
              color: Colors.white,
              child: Consumer<MainScreenProvider>(builder: (context, value, child) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: width-30,
                        child: Image.network(value.bannerImageList[index].img,fit: BoxFit.fill,),
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
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ))
                  ],
                ),
              ),
            ),
            Consumer<MainScreenProvider>(builder: (context, value, child) {
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
                            tapButtonCat(index);
                            catType = value.catList[index].catTitle;
                            Provider.of<MainScreenProvider>(context,listen: false).getShops();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color:
                                  index == selectedIndex ? Colors.black : Colors.amber,
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value.catList[index].catTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: index == selectedIndex
                                        ? Colors.amber
                                        : Colors.black,
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
                          color: Colors.red,
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
            
            Consumer<MainScreenProvider>(builder: (context, value, child) {
              return Container(
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      child: Image.network(
                        value.shopesList[index].img,
                      ),
                    ),
                    title:  Text(value.shopesList[index].title),
                    subtitle:  Text(value.shopesList[index].subTitle),
                    trailing: const Icon(
                      Icons.arrow_back,
                      textDirection: TextDirection.rtl,
                    ),
                  );
                },
                itemCount: value.shopesList.length,
              ),
            );
            },)
          ],
        ),
      ),
    );
  }
  
  void tapButtonCat(int index) {}
  
  
}

