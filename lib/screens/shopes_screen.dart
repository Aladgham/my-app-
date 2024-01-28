import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/main_screen_provider.dart';

class ShopesScreen extends StatefulWidget {
  const ShopesScreen({super.key});

  @override
  State<ShopesScreen> createState() => _ShopesScreenState();
}

class _ShopesScreenState extends State<ShopesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MainScreenProvider>(
      context,
      listen: false,
    ).shopesList;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          "Shopes",
          style: TextStyle(color: Color.fromARGB(255, 9, 74, 128)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              height: height / 10,
              width: width,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 9, 74, 128)),
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
                        "Search Shopes",
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
}
