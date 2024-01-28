import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/item_screen_provider.dart';
import 'cart_screen.dart';

class ShopItems extends StatefulWidget {
  final String shopName;
  final String shopId;

  const ShopItems({required this.shopName, Key? key, required this.shopId})
      : super(key: key);

  @override
  State<ShopItems> createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemsScreenProvider>(context, listen: false)
        .getItems(widget.shopId);
  }

  _addToCart(var idItem) async {
    final prefs = await SharedPreferences.getInstance();
    var Id_users = await prefs.getString("UserId");

    await http
        .post(Uri.parse('https://alshalbiapps.com/API/AddToCart.php'), body: {
      "Id_items": idItem,
      "Id_users": Id_users!,
    });
  }

  _showBottomSheet(var id, var name, var price, var imageUrl) {
    int count = 0;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(imageUrl, height: 250),
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${price} \$ ',
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () {
                          if (count == 0) return;
                          setState(() {
                            --count;
                          });
                        },
                        icon: const Icon(Icons.remove, color: Colors.red)),
                    Text('$count'),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            ++count;
                            if (count == 1) {
                              _addToCart(id);
                            }
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.blue)),
                  ]),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shopName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Consumer<ItemsScreenProvider>(
        builder: (context, value, child) {
          return GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: value.list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _showBottomSheet(
                    value.list[index].Id,
                    value.list[index].Name,
                    value.list[index].Price,
                    value.list[index].ImageUrl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(value.list[index].ImageUrl, height: 110),
                      Text(
                        value.list[index].Name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        '\$${value.list[index].Price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
