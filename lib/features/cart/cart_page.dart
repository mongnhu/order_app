import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/features/food/widgets/app_icon.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(15.h),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const AppIcon(
                icon: Icons.arrow_back_ios_new,
                iconColor: Colors.blueAccent,
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(15.h),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: const AppIcon(
                  icon: Icons.home,
                  iconColor: Colors.blueAccent,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.h),
              child: const AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.blueAccent,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.getItems.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        var cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                  margin:
                                      EdgeInsets.only(top: 10.h, bottom: 10.h),
                                  height: 130.h,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(
                                                      cartList[index].product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar(
                                                  "History product",
                                                  "Product review is not availble for history products",
                                                  backgroundColor: const Color
                                                      .fromARGB(255, 255, 255,
                                                      255), // Đặt màu nền ở đây
                                                  colorText: Colors
                                                      .black, // Đặt màu chữ nếu cần
                                                );
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(25.r),
                                            ),
                                          )),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                          child: Container(
                                        color: Colors.white,
                                        height: 130.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: cartController
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            const SmallText(text: "Đồ ăn vặt"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text:
                                                      "\$${cartController.getItems[index].price}",
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.sp),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            //popularProduct.setQuantity(false);
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 25.sp,
                                                          )),
                                                      SizedBox(width: 10.w),
                                                      BigText(
                                                          text: cartList[index]
                                                              .quantity
                                                              .toString()), //popularProduct.inCartItems.toString()),
                                                      SizedBox(width: 10.w),
                                                      GestureDetector(
                                                          onTap: () {
                                                            //popularProduct.setQuantity(true);
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                            print(
                                                                "being tapped");
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 25.sp,
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ));
                            });
                      }),
                    )
                  : NoDataPage(text: "Your cart is empty");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              height: 0.12.sh,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.black12,
              ),
              child: cartController.getItems.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10.w),
                              //BigText(popularProduct.quantity.toString(),style: TextStyle(fontSize: 34.sp)),
                              BigText(text: "\$${cartController.totalAmount}"),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('tapped');
                            cartController.addToCartHistory();
                            Get.toNamed(RouteHelper.checkoutPage);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                              size: 35.sp,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        ));
  }
}
