import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../provider/orderHistoryProvider.dart';
import 'orderHistoryByIdScreeen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return ColorResource.green;
      case 'cancelled':
      case 'canceled':
        return Colors.red;
      default:
        return ColorResource.gray; // fallback
    }
  }
  List<dynamic> filteredOrders = [];
  String searchText = "";
  int selectedDays = 0; // 0 = all, 7 = last 7 days, 30 = last 30 days

  String formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "";

    try {
      DateTime dt = DateTime.parse(rawDate).toLocal();
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return rawDate;
    }
  }


  void applyFilters(List<dynamic> orders) {
    List<dynamic> temp = orders;

    if (searchText.isNotEmpty) {
      temp = temp.where((o) =>
          (o.bookingId ?? "")
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }

    if (selectedDays > 0) {
      DateTime now = DateTime.now();
      temp = temp.where((o) {
        DateTime orderDate = DateTime.tryParse(o.createdAt ?? "") ?? now;
        return now.difference(orderDate).inDays <= selectedDays;
      }).toList();
    }

    filteredOrders = temp;
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Change this to your ACTUAL fetch method name in the provider
      Provider.of<OrderHistoryProvider>(context, listen: false).fetchOrderHistoryData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderHistoryProvider>(
      builder: (context, provider, child) {

        final orders = provider.getOrderHistoryData?.orderList ?? [];

        applyFilters(orders);

        return Scaffold(
          appBar: CustomAppBar(title: 'Order History',showBackButton: false,),
          backgroundColor: ColorResource.white,
          body: provider.loading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorResource.buttonBackground),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: ColorResource.buttonBackground,
                                size: 20,
                              ),
                              hintText: "Search for Order",
                              hintStyle: TextStyle(color: ColorResource.buttonBackground),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            if (value == "7") selectedDays = 7;
                            if (value == "30") selectedDays = 30;
                            if (value == "custom") selectedDays = 0;
                          });
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: "7", child: Text("Last 7 days")),
                          PopupMenuItem(value: "30", child: Text("Last 30 days")),
                          PopupMenuItem(value: "custom", child: Text("All")),
                        ],
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorResource.buttonBackground),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.tune, color: ColorResource.buttonBackground),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: filteredOrders.isEmpty
                        ? Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/upcommingBooking.gif",
                          height: 220,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: OrderHistoryCard(
                            orerId: order.bookingId ?? "",
                            orderDate: formatDate(order.createdAt ?? ""),
                            orderValue: order.totalAmount.toString(),
                            paymentMode: order.paymentMode ?? "",
                            totalItems: order.productCount.toString(),
                            orderStatus: order.status ?? "",
                            onTap: () {
                              navPush(
                                context: context,
                                action: OrderHistoryByIdScreen(
                                  orderId: order.sId ?? "",
                                  orderStatus: order.status ?? "",
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget OrderHistoryCard({
    required String orerId,
    required String orderDate,
    required String orderValue,
    required String paymentMode,
    required String totalItems,
    required String orderStatus,
    required Function() onTap,
}){

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorResource.cardColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  orerId,
                  size: 16,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(39),
                    color: _getStatusColor(orderStatus),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  child: CustomText(
                    orderStatus,
                    size: 13,
                    weight: FontWeight.w600,
                    color: ColorResource.white,
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            CustomText(
              orderDate,
              size: 14,
              weight: FontWeight.w500,
              color: ColorResource.black,
            ),
            SizedBox(height: 5,),
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
                  '₹${orderValue}',
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "Patment Mode:",
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),
                CustomText(
                  paymentMode,
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Total Items',
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),
                CustomText(
                  totalItems,
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                GestureDetector(
                  onTap: onTap,
                  child: CustomImageView(
                      imagePath: AppImages.orderButton,
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


