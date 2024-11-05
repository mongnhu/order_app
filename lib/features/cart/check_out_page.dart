import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CheckoutPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CheckoutPage({super.key});

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Order Receipt', style: pw.TextStyle(fontSize: 24)),
              pw.Divider(),
              ...cartController.getItems.map(
                (item) => pw.Text(
                  '${item.name} - \$${item.price} x ${item.quantity} = \$${item.price! * item.quantity!}',
                ),
              ),
              pw.Divider(),
              pw.Text('Total: \$${cartController.totalAmount}',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Order_Receipt.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (cartController) {
                return ListView.builder(
                  itemCount: cartController.getItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.getItems[index];
                    return ListTile(
                      title: Text(item.name!),
                      subtitle:
                          Text('Price: \$${item.price} x ${item.quantity}'),
                      trailing:
                          Text('Total: \$${item.price! * item.quantity!}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<CartController>(
              builder: (cartController) {
                return Column(
                  children: [
                    Text('Total: \$${cartController.totalAmount}'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        cartController.clear();
                        Get.snackbar('Success', 'Order placed successfully!');
                        generatePdf();
                      },
                      child: const Text('Place Order & Generate Receipt'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
