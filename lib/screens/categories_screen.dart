import 'package:e_commarce/providers/profile_screen_provider.dart';
import 'package:e_commarce/providers/main_screen_provider.dart';
import 'package:e_commarce/screens/shopes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var myCat = [];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 9, 74, 128),
            )),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Color.fromARGB(255, 9, 74, 128),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            height: height / 10,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 9, 74, 128),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search categories",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 9, 74, 128),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: height / 1.5,
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Consumer<MainScreenProvider>(
              builder: (context, value, child) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: value.catList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            value.indexSelected = index;
                          });
                          Provider.of<MainScreenProvider>(
                            context,
                            listen: false,
                          ).shopesList;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShopesScreen(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[500],
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              SizedBox(
                                  height: height,
                                  width: width,
                                  child: Image.network(value.catList[index].img,
                                      fit: BoxFit.cover)),
                              Center(
                                child: Text(
                                  value.catList[index].catTitle,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
