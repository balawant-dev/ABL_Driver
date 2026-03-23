import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/walletProvider.dart';
import 'package:intl/intl.dart';

class TransactionHistoryClass extends StatefulWidget {
  const TransactionHistoryClass({super.key});

  @override
  State<TransactionHistoryClass> createState() => _TransactionHistoryClassState();
}

class _TransactionHistoryClassState extends State<TransactionHistoryClass> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletProvider>(context, listen: false).fetchwalletData();
    });
  }
  String formatDateTime(String? date) {
    if (date == null || date.isEmpty) return "";

    DateTime dt = DateTime.parse(date).toLocal();

    String time = DateFormat('hh:mm a').format(dt);
    String day = DateFormat('yyyy-MM-dd').format(dt);

    return "$time | $day";
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
        builder: (context, provider, child){
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ Safe null handling
          final orders =
              provider.walletGetModel?.transactionHistory ?? [];
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

          // if (orders.isEmpty) {
          //   return const Center(child: Text("No settlement history"));
          // }
          return  ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final item = orders[index];

              return  transtionHistory(
                  date: item.createdAt ?? "",
                  amount: item.amount ?? 0,
                  status: item.action ?? "",
                  orderId: item.orderId ?? "",
                  transtionId: item.sId ?? ""
              );
            },
          );
        }
    );
  }
  Widget transtionHistory({
    required String date,
    required int amount,
    required String status,
    required String orderId,
    required String transtionId,
}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff46A27F).withOpacity(0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              status,
              size: 13,
              color: ColorResource.black,
              weight: FontWeight.w600,
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //textCard(title: orderId,),
                textCard(title: "Transaction ID: ${transtionId}",),
                CustomText(
                  '₹${amount}',
                  size: 16,
                  weight: FontWeight.w600,
                  color: ColorResource.buttonBackground,
                )
              ],
            ),
            SizedBox(height: 5,),
            textCard(title: "Order ID: ${orderId}",),
            SizedBox(height: 10,),
            textCard(title: formatDateTime(date)),
          ],
        )
      ),
    );
  }
  Widget textCard({required String title,}
      ){
    return CustomText(
      title,
      size: 11,
      color: ColorResource.black,
      weight: FontWeight.w400,
    );
  }
}
