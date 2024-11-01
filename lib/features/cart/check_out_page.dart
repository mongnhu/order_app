import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/cart_controller.dart';

class CheckoutPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: cartController.getItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.getItems[index];
                  return ListTile(
                    title: Text(item.name!),
                    subtitle: Text('Price: \$${item.price} x ${item.quantity}'),
                    trailing: Text('Total: \$${item.price! * item.quantity!}'),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                children: [
                  Text('Total: \$${cartController.totalAmount}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      cartController.clear();
                      Get.snackbar('Success', 'Order placed successfully!');
                    },
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
