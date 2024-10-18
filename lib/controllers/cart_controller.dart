import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  void addItem(ProductModel product, int quantity) {
    // print("length of the item is" + _items.length.toString());
    _items.putIfAbsent(product.id!, () {
      print("adding item to the cart" +
          product.id!.toString() +
          "quantity" +
          quantity.toString());
      _items.forEach((key, value) {
        print("quantity is" + value.quantity.toString());
      });
      return CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        isExist: true,
        time: DateTime.now().toString(),
      );
    });
  }
}
