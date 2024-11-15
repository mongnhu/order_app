import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  // only for storafe and sharedPreferences
  List<CartModel> storageItems = [];

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart!",
          backgroundColor:
              const Color.fromARGB(255, 255, 255, 255), // Đặt màu nền ở đây
          colorText: Colors.black, // Đặt màu chữ nếu cần
        );
      }
    }

    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.values.toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print('Số lượng hàng trong giỏ: ${storageItems.length.toString()}');

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToCartHistory() {
    cartRepo.addToCartListHistory();
    // clear();
  }

  void clear() {
    _items = {};
    cartRepo.removeCart();
    update();
  }

  List<CartModel> getHistoryCartList() {
    return cartRepo.getHistoryCartList();
  }

  void removeHistoryCart() {
    cartRepo.removeHistoryCart();
    update();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  Map<String, Map<String, dynamic>> getSoldItemsSummary() {
    Map<String, Map<String, dynamic>> soldItemsSummary = {};

    for (var cartItem in getHistoryCartList()) {
      if (soldItemsSummary.containsKey(cartItem.name)) {
        soldItemsSummary.update(cartItem.name!, (value) {
          value['quantity'] += cartItem.quantity!;
          return value;
        });
      } else {
        soldItemsSummary[cartItem.name!] = {
          'quantity': cartItem.quantity!,
          'image': cartItem.img, // Lấy URL hình ảnh từ CartModel
        };
      }
    }

    return soldItemsSummary;
  }
}
