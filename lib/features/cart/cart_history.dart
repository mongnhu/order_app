import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/features/food/widgets/app_icon.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getHistoryCartList = Get.find<CartController>().getHistoryCartList();

    Map<String, int> cartItemPerOder = {};

    for (int i = 0; i < getHistoryCartList.length; i++) {
      if (cartItemPerOder.containsKey(getHistoryCartList[i].time)) {
        cartItemPerOder.update(getHistoryCartList[i].time!, (value) => ++value);
      } else {
        cartItemPerOder.putIfAbsent(getHistoryCartList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemPerOder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOder = cartOrderTimeToList();
    var listCounter = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const BigText(text: 'Cart History'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            child: const AppIcon(icon: Icons.shopping_cart_outlined),
          ),
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
                    BigText(
                      text: getHistoryCartList[i].time.toString(),
                      size: 35.sp,
                    ),
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
                              Container(
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
