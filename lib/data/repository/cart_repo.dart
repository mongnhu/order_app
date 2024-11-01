import 'dart:convert';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_LIST_HISTORY);
    var time = DateTime.now().toString();
    cart = [];

    // Convert objects to string because sharedPreferences only accepts String
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> cart = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print('inside cart list $cart');
    }

    List<CartModel> cartList = [];
    for (var element in cart) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getHistoryCartList() {
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_HISTORY)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_LIST_HISTORY)!;
    }

    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartListHistory() {
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_HISTORY)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_LIST_HISTORY)!;
    }

    for (int i = 0; i < cart.length; i++) {
      print("History CartList ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_LIST_HISTORY, cartHistory);
    print(
        'The length of the history cart ${getHistoryCartList().length.toString()}');
    for (int j = 0; j < getHistoryCartList().length; j++) {
      print(
          'The time for the order is ${getHistoryCartList()[j].time.toString()}');
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
