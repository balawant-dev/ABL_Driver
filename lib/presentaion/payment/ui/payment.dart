import 'dart:io';

import 'package:flutter/material.dart';

class PaymentSelectionScreen extends StatefulWidget {
  final dynamic order;

  const PaymentSelectionScreen({
    super.key,
    required this.order,
  });

  @override
  State<PaymentSelectionScreen> createState() =>
      _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState
    extends State<PaymentSelectionScreen> {

  String selectedPayment = "";

  bool paymentSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [


            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPayment = "cash";
                  paymentSuccess = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedPayment == "cash"
                        ? Colors.green
                        : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.money),
                    SizedBox(width: 10),
                    Text(
                      "Cash Payment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),


            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPayment = "online";
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedPayment == "online"
                        ? Colors.green
                        : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.qr_code),
                    SizedBox(width: 10),
                    Text(
                      "Online Payment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// ================= QR IMAGE =================
            if (selectedPayment == "online") ...[
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.asset(
                  "assets/images/qr.png",
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    paymentSuccess = true;
                  });
                },
                child: const Text("Payment Successful"),
              ),
            ],

            const Spacer(),


            if (paymentSuccess)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Deliver Order",
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}