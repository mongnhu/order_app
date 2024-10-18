import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/presentation/ui/food_page_body.dart';
import 'package:food_delivery/features/home/utils/dimensions.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10),
          child: Column(
            children: [
              BigText(
                text: 'Việt Nam',
                color: Theme.of(context).colorScheme.primary,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width10),
                child: Row(
                  children: [
                    SmallText(
                      text: 'Cần Thơ',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(child: FoodPageBody()),
    );
  }
}
