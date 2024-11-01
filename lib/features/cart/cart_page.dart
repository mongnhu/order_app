import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/features/food/widgets/app_icon.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/features/home/utils/dimensions.dart';
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
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                    SizedBox(width: Dimensions.width20 * 5),
                    GestureDetector(
                      onTap: () {
                        //Get.to(() => MainFoodPage());
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      var cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (_, index) {
                            return SizedBox(
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
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
                                                    popularIndex, "cartpage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartpage"));
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: Dimensions.width10,
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: Dimensions.height20 * 5,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    "\$${cartController.getItems[index].price}",
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
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
                                                          cartController
                                                              .addItem(
                                                                  cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          size: 20,
                                                        )),
                                                    SizedBox(width: 10.w),
                                                    //BigText(popularProduct.quantity.toString(),style: TextStyle(fontSize: 34.sp)),
                                                    BigText(
                                                        text: cartList[index]
                                                            .quantity
                                                            .toString()), //popularProduct.inCartItems.toString()),
                                                    SizedBox(width: 10.w),
                                                    GestureDetector(
                                                        onTap: () {
                                                          //popularProduct.setQuantity(true);
                                                          cartController
                                                              .addItem(
                                                                  cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                          print("being tapped");
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 20,
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
                  ),
                ))
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
              child: Row(
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
                      //popularProduct.addItem(product);
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
              ),
            );
          },
        ));
  }
}
