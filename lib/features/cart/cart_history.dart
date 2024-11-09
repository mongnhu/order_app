import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/features/food/widgets/app_icon.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var getHistoryCartList =
        Get.find<CartController>().getHistoryCartList().reversed.toList();

    Map<String, int> cartItemPerOder = {};

    for (int i = 0; i < getHistoryCartList.length; i++) {
      if (cartItemPerOder.containsKey(getHistoryCartList[i].time)) {
        cartItemPerOder.update(getHistoryCartList[i].time!, (value) => ++value);
      } else {
        cartItemPerOder.putIfAbsent(getHistoryCartList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOderToList() {
      return cartItemPerOder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOder = cartItemsPerOderToList();
    var listCounter = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const BigText(text: 'Cart History'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                cartController.removeHistoryCart();
                Get.snackbar(
                  "Delete History Cart",
                  "HistoryCart deleted successfully!",
                );
              },
              child: AppIcon(icon: Icons.delete),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getCartPage());
              },
              child: const AppIcon(icon: Icons.shopping_cart_outlined),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
        child: ListView(
          children: [
            for (int i = 0; i < itemsPerOder.length; i++)
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //BigText(text: getHistoryCartList[i].time.toString(),size: 35.sp),
                    (() {
                      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse(getHistoryCartList[listCounter].time!);
                      var inputDate = DateTime.parse(parseDate.toString());
                      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                      var outputDate = outputFormat.format(inputDate);
                      //return Text(getHistoryCartList[listCounter].time!);
                      return BigText(text: outputDate);
                    }()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(itemsPerOder[i], (index) {
                            if (listCounter < getHistoryCartList.length) {
                              listCounter++;
                            }
                            if (index <= 2) {
                              return Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstants.BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          getHistoryCartList[listCounter - 1]
                                              .img!,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                        SizedBox(
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: 'Total'),
                              BigText(
                                text: "${itemsPerOder[i]} items",
                              ),
                              GestureDetector(
                                onTap: () {
                                  var orderTime = cartOrderTimeToList();
                                  //print("Order time " + orderTime[i].toString());
                                  Map<int, CartModel> moreOrder = {};
                                  for (int j = 0;
                                      j < getHistoryCartList.length;
                                      j++) {
                                    if (getHistoryCartList[j].time ==
                                        orderTime[i]) {
                                      moreOrder.putIfAbsent(
                                          getHistoryCartList[j].id!,
                                          () => CartModel.fromJson(jsonDecode(
                                              jsonEncode(
                                                  getHistoryCartList[j]))));
                                    }
                                  }
                                  Get.find<CartController>().setItems =
                                      moreOrder;
                                  Get.find<CartController>().addToCartList();
                                  Get.toNamed(RouteHelper.getCartPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          width: 1, color: Colors.blue)),
                                  child: const SmallText(
                                    text: 'one more',
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
