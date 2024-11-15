import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/features/home/utils/app_constants.dart';
import 'package:get/get.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var statistics = cartController.getSoldItemsSummary();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: statistics.entries.map((entry) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  // Hình ảnh món ăn
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          AppConstants.BASE_URL +
                              AppConstants.UPLOAD_URL +
                              entry.value['image'],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Tên và số lượng món ăn
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key, // Tên món ăn
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Sold: ${entry.value['quantity']} ', // Số lượng đã bán
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
