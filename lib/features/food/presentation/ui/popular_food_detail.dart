import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/features/food/widgets/app_column.dart';
import 'package:food_delivery/features/food/widgets/app_icon.dart';
import 'package:food_delivery/features/home/presentation/ui/main_food_page.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    print("page is id " + pageId.toString());
    print("product name is " + product.name.toString());
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 0.4.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!)
                    //fit: BoxFit.cover
                    ),
              ),
            ),
          ),
          // Icon app
          Positioned(
            left: 20.w,
            right: 20.w,
            top: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios_rounded)),
                AppIcon(icon: Icons.shopping_cart),
              ],
            ),
          ),
          // Introduce section
          Positioned(
            left: 0,
            right: 0,
            top: 0.4.sh - 20,
            // bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: 20.h),
                    BigText(
                      text: 'Introduce',
                      size: 40.sp,
                    ),
                    ReadMoreText(
                      //'Chân gà sốt Thái là một món ăn vặt vô cùng hấp dẫn, kết hợp giữa vị chua cay đặc trưng của ẩm thực Thái Lan với độ giòn dai của chân gà, tạo nên một hương vị khó cưỡng, Chân gà sốt Thái là một món ăn vặt vô cùng hấp dẫn, kết hợp giữa vị chua cay đặc trưng của ẩm thực Thái Lan với độ giòn dai của chân gà, tạo nên một hương vị khó cưỡng',
                      product.description!,
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 20.sp),
                      // trimMode: TrimMode.Line,
                      // trimLines: 4,
                      // trimCollapsedText: 'Thêm',
                      // trimExpandedText: 'Bớt',
                      // colorClickableText: Colors.pink,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
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
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                          )),
                      SizedBox(width: 10.w),
                      //BigText(popularProduct.quantity.toString(),style: TextStyle(fontSize: 34.sp)),
                      BigText(text: popularProduct.quantity.toString()),
                      SizedBox(width: 10.w),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                          )),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        popularProduct.addItem(product);
                      },
                      child: BigText(
                        text: "\$${product.price!} Thêm vào giỏ hàng",
                        color: Colors.white,
                        size: 35.sp,
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}