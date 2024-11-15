import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.find<CartController>();

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
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
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
                      onPressed: () async {
                        // cartController.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PaypalCheckout(
                            sandboxMode: true,
                            clientId:
                                "AX-2YgBRngUk93u42FWti8NVU8fhqj8mcyzUO4Q1xkwc7YShQ_Qqpvxy2JMWreJurAAFbLZ1uTgUEXJe",
                            secretKey:
                                "ENH8f8U3GAit1Q7JgAuRt9h8fP7mXCmR9Voj-5fyHrq6Zmq3trFrQNyL-JpzdrCZhskM-43Mn5c-GJN5",
                            returnURL: "success.snippetcoder.com",
                            cancelURL: "cancel.snippetcoder.com",
                            transactions: [
                              {
                                "amount": {
                                  "total": '${cartController.totalAmount}',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '${cartController.totalAmount}',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": cartController.getItems.map((item) {
                                    return {
                                      "name": item.name,
                                      "quantity": item.quantity,
                                      "price": '${item.price}',
                                      "currency": "USD"
                                    };
                                  }).toList(),

                                  // shipping address is not required though
                                  //   "shipping_address": {
                                  //     "recipient_name": "Raman Singh",
                                  //     "line1": "Delhi",
                                  //     "line2": "",
                                  //     "city": "Delhi",
                                  //     "country_code": "IN",
                                  //     "postal_code": "11001",
                                  //     "phone": "+00000000",
                                  //     "state": "Texas"
                                  //  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                              cartController.clear();
                            },
                            onError: (error) {
                              print("onError: $error");
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              print('cancelled:');
                            },
                          ),
                        ));
                      },
                      child: const Text('Check Out'),
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
