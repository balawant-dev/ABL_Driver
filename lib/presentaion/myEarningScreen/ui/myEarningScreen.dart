
import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/material.dart';

class MyEarningScreen extends StatefulWidget {
  const MyEarningScreen({super.key});

  @override
  State<MyEarningScreen> createState() => _MyEarningScreenState();
}

class _MyEarningScreenState extends State<MyEarningScreen> {
  String selectedValue = 'This Week';

  final List<Map<String, int>> earningList = [
    {
      'totalEarning': 1250,
      'ordersDelivered': 15,
      'onlineTime': 8,
      'completionRate': 95,
      'avgEarningPerDay': 180,
      'tipsEarning': 120,
    },
    {
      'totalEarning': 980,
      'ordersDelivered': 11,
      'onlineTime': 6,
      'completionRate': 90,
      'avgEarningPerDay': 160,
      'tipsEarning': 90,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Earning'),
      backgroundColor: ColorResource.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// 🔹 Dropdown Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  itemBuilder: (context) => [
                    _buildItem('Today'),
                    _buildItem('This Week'),
                    _buildItem('Monthly'),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  offset: const Offset(0, 45),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39),
                      color: ColorResource.buttonBackground,
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      children: [
                        CustomText(
                          selectedValue,
                          size: 14,
                          color: ColorResource.white,
                          weight: FontWeight.w600,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// 🔹 Earning Card LIST
            ListView.builder(
              itemCount: earningList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = earningList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EarningCard(
                    totalEarning: data['totalEarning']!,
                    ordersDelivered: data['ordersDelivered']!,
                    onlineTime: data['onlineTime']!,
                    completionRate: data['completionRate']!,
                    avgEarningPerDay: data['avgEarningPerDay']!,
                    tipsEarning: data['tipsEarning']!,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget EarningCard({
    required int totalEarning,
    required int ordersDelivered,
    required int onlineTime,
    required int completionRate,
    required int avgEarningPerDay,
    required int tipsEarning,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorResource.cardColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _row('Total Earning', '₹$totalEarning'),
          _row('Orders Delivered', ordersDelivered.toString()),
          _row('Online Time (hrs)', onlineTime.toString()),
          _row('Completion Rate', '$completionRate%'),
          _row('Avg Earning/day', '₹$avgEarningPerDay'),
          _row('Tips Earning', '₹$tipsEarning'),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title,
            size: 13,
            weight: FontWeight.w500,
            color: ColorResource.black,
          ),
          CustomText(
            value,
            size: 13,
            weight: FontWeight.w600,
            color: ColorResource.black,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
