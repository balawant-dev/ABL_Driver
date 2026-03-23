import 'dart:async';

import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/presentaion/homeScreen/provider/homeProvider.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/primary_button.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {


  static const int totalSeconds = 30;
  int remainingSeconds = totalSeconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Change this to your ACTUAL fetch method name in the provider
      Provider.of<HomeProvider>(context, listen: false).fetchNewOrderData();

    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        t.cancel();
      }
    });
  }

  Color get progressColor {
    double percent = remainingSeconds / totalSeconds;
    if (percent > 0.6) return Colors.green;
    if (percent > 0.3) return Colors.orange;
    return Colors.red;
  }
  Future<bool> showAcceptDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Accept Order"),
          content: const Text(
            "Are you sure you want to accept this order?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF086B48),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Accept"),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final orders = provider.getNewOrderData?.orderList ?? [];
        if (orders.isEmpty) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/upcommingBooking.gif",
                height: 220,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final order = orders[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CardData(
                orerId: order.bookingId ?? "",
                pickup: order.pickup?.name ?? "",
                drop: order.delivery?.address1 ?? "",
                customer: order.delivery?.name ?? "",
                distance: "${order.totalKm ?? 0} Km",
                price: "${order.totalAmount ?? 0}",
                onAccepted: () async {
                  final homeProvider =
                  Provider.of<HomeProvider>(context, listen: false);
                  // bool confirm = await showAcceptDialog(context);
                  //
                  // if (!confirm) return;
                  await homeProvider.acceptOrderStatus(
                    orderId: order.sId ?? "",
                    status: "accepted",
                   // status: "delivered",
                  );
                },


              ),
            );
          },
        );
      },
    );

  }


  Widget CardData({
    required String orerId,
    required String pickup,
    required String drop,
    required String customer,
    required String distance,
    required String price,
    required VoidCallback onAccepted,
}){
    double progress = remainingSeconds / totalSeconds;
    return  Container(
      //height: 20,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: ColorResource.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  //'Order #6598235',
                  orerId,
                  size: 17,
                  color: ColorResource.black,
                  weight: FontWeight.w600,
                ),
                CustomText(
                  //'20 Km',
                  distance,
                  size: 15,
                  color: ColorResource.black,
                  weight: FontWeight.w500,
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                CustomText(
                  'Pick Up :',
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                ),
                SizedBox(width: 15,),
                CustomText(
                 // 'H- 116, Sec-59, Noida',
                  pickup,
                  size: 13,
                  weight: FontWeight.w400,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 8,),
            Divider(
              height: 1,
              color: ColorResource.gray,
            ),
            SizedBox(height: 8,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  'Drop:',
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                ),
                SizedBox(width: 15,),
                SizedBox(
                  height: 40, // height for 2 lines (adjust if needed)
                  width: 200,
                  child: Text(
                    pickup.isEmpty ? " " : drop,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: ColorResource.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8,),
            Divider(
              height: 1,
              color: ColorResource.gray,
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Customer Name',
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),

                CustomText(
                  //'Kapil Gupta',
                  customer,
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Order Value:',
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),

                CustomText(
                  '₹${price}',
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(progressColor),
                    ),
                  ),
                  Text(
                    "${remainingSeconds}s",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            CustomText(
              'Order will be cancel after ${remainingSeconds}s.',
              size: 13,
              weight: FontWeight.w400,
              color: ColorResource.black,
            ),
            SizedBox(height: 15,),
            SwipeButton(
              onAccepted: onAccepted,
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
