class Cart {
  final String imageUrl;
  final String name;
  final double price;
  final int count;

  Cart(
      {required this.name,
      required this.count,
      required this.price,
      required this.imageUrl});

  static List<Cart> items = [
    Cart(
        count: 5,
        imageUrl:
            'https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/ee/P00596876.jpg',
        name: 'Logo cotton jersey hoodie',
        price: 2495),
    Cart(
        count: 3,
        imageUrl:
            'https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/72/P00596877.jpg',
        name: 'Logo cotton sweatshirt',
        price: 1245),
  ];
}
