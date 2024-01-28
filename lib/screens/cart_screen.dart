import 'package:flutter/material.dart';

import '../models/cart.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double cartTotalAmount = 0;
  @override
  void initState() {
    super.initState();
    for (Cart item in Cart.items) {
      cartTotalAmount += item.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping cart')),
      bottomNavigationBar: SizedBox(
        height: 130,
        child: Card(
          shadowColor: Colors.purple,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total amount:',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${cartTotalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckOutScreen()));
                        },
                        child: const Text('CHECKOUT')))
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: Cart.items.length,
          itemBuilder: (context, index) => ListTile(
                leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(Cart.items[index].imageUrl)))),
                title: Text(
                  Cart.items[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('x${Cart.items[index].count}'),
                    Text('\$${Cart.items[index].price}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
    );
  }
}
