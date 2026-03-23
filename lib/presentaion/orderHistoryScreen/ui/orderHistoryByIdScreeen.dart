import 'package:abldriver/WebServices/app_url.dart';
import 'package:abldriver/presentaion/orderHistoryScreen/provider/orderHistoryProvider.dart';
import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/color_resource.dart';
import '../../../core/constants/app_images.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/primary_button.dart';
import 'package:intl/intl.dart';

import '../model/orderHistoryByIdModel.dart';


class OrderHistoryByIdScreen extends StatefulWidget {
  final String orderId;
  final String orderStatus;

  const OrderHistoryByIdScreen({super.key, required this.orderId,required this.orderStatus});

  @override
  State<OrderHistoryByIdScreen> createState() => _OrderHistoryByIdScreenState();
}

class _OrderHistoryByIdScreenState extends State<OrderHistoryByIdScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Change this to your ACTUAL fetch method name in the provider
      Provider.of<OrderHistoryProvider>(context, listen: false).fetchOrderHistoryById(widget.orderId);
    });
  }
  String capitalize(String text) {
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Future<void> launchCall(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch call');
    }
  }

// Open SMS app
  Future<void> launchSMS(String number) async {
    final Uri uri = Uri(scheme: 'sms', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch SMS');
    }
  }
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

  bool isProductExpanded = false;


  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";

    DateTime dt = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderHistoryProvider>(
      builder: (context, provider, child) {

        if (provider.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final order = provider.orderHistoryByIdModel?.order;
        if (order == null) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Order History'),
            body: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/upcommingBooking.gif",
                  height: 220,
                ),
              ),
            )
          );
        }
        return Scaffold(
          appBar: CustomAppBar(title: 'Order History'),
          backgroundColor: ColorResource.white,
          body: CustomPageRefresher(
              onRefresh: () async {
                provider.fetchOrderHistoryById(widget.orderId);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CardData(
                      orerId:order.bookingId ?? "",
                      pickup: order.pickup?.address ?? "",
                      pickupNumber: order.pickup?.mobileNo ?? "",
                      drop: order.delivery?.address1 ?? "",
                      devilerNumber: order.delivery?.mobileNo ?? "",
                      customer: order.delivery?.name ?? "",
                      distance: order.totalKm?.toString() ?? "",
                      price: order.totalAmount?.toString() ?? "",
                      date: order.createdAt ?? "",
                      deliveryCharge: order.deliveryCharge.toString(),
                      totalAmount: order.totalAmount.toString(),
                      orderStatus: widget.orderStatus,
                      paymentMood: order.paymentMode ?? "",
                      orderHistoryByIdModel: provider.orderHistoryByIdModel
                  ),
                ),
              ),
          )
        );
      },
    );
  }


  Widget CardData({
    required String orerId,
    required String pickup,
    required String pickupNumber,
    required String devilerNumber,
    required String drop,
    required String customer,
    required String distance,
    required String price,
    required String date,
    required String orderStatus,
    required String paymentMood,
    required String deliveryCharge,
    required String totalAmount,
    required  OrderHistoryByIdModel? orderHistoryByIdModel,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: ColorResource.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(39),
                    color: _getStatusColor(orderStatus),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 4),
                  child: CustomText(
                    orderStatus,
                    size: 13,
                    weight: FontWeight.w600,
                    color: ColorResource.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            CustomText(
              formatDate(date),
              size: 15,
              color: ColorResource.black,
              weight: FontWeight.w500,
            ),

            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 234,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                'Pick Up :',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              CustomText(
                                '',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                'Time :',
                                size: 11,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                'Date :',
                                size: 11,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                            ],
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
                                child: Text(
                                  pickup.isEmpty ? " " : pickup,
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
                              SizedBox(height: 5,),
                              CustomText(
                                '10:00 AM',
                                size: 11,
                                weight: FontWeight.w400,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                '09-12-24',
                                size: 11,
                                weight: FontWeight.w400,
                                color: ColorResource.black,
                              )
                            ],
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                'Drop :',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              CustomText(
                                '',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                'Time :',
                                size: 11,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                'Date :',
                                size: 11,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),


                            ],
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
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
                              SizedBox(height: 5,),
                              CustomText(
                                '10:00 AM',
                                size: 11,
                                weight: FontWeight.w400,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                '09-12-24',
                                size: 11,
                                weight: FontWeight.w400,
                                color: ColorResource.black,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () {
                          launchSMS(pickupNumber);
                          print(pickupNumber);
                        },
                        child: CustomImageView(
                          imagePath: AppImages.messageImage,
                          height: 26,
                          width: 26,
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          launchCall(pickupNumber);
                          print(pickupNumber);
                        },
                        child: CustomImageView(
                          imagePath: AppImages.callimage,
                          height: 26,
                          width: 26,
                        ),
                      ),SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          launchSMS(devilerNumber);
                          print(devilerNumber);
                        },
                        child: CustomImageView(
                          imagePath: AppImages.messageImage,
                          height: 26,
                          width: 26,
                        ),
                      ),SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          launchCall(devilerNumber);
                          print(devilerNumber);
                        },
                        child: CustomImageView(
                          imagePath: AppImages.callimage,
                          height: 26,
                          width: 26,
                        ),
                      ),
                    ],
                  ),
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
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Patment Mode:',
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),

                CustomText(
                  paymentMood,
                  size: 13,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                )
              ],
            ),

            if (!isProductExpanded)
              Column(
                children: [
                  SizedBox(height: 25,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isProductExpanded = true;
                      });
                    },
                    child: Center(
                      child: Text(
                        'Product Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isProductExpanded
                  ?

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Divider(
                    height: 1,
                    color: ColorResource.gray,
                  ),
                  SizedBox(height: 8,),
                  CustomText(
                    '${orderHistoryByIdModel!.order!.products!.length} Items In order',
                    size: 14,
                    weight: FontWeight.w500,
                    color: ColorResource.black,
                  ),
                  SizedBox(height: 10,),
                  ListView.builder(
                    itemCount: orderHistoryByIdModel!.order!.products!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final productData=orderHistoryByIdModel!.order!.products![index];
                      print("<<<<<<<<<<<<<<<<<<<<<<||||  ${"${AppUrl.baseUrl}/${productData.image}"}");
                    return OrderHistoryCard(
                      discountPrice: productData.finalPrice.toString(),
                      price: productData.mrp.toString(),
                      title:  productData.name.toString(),
                      quantity:  '${productData.sellingUnit}${productData.unitOfManagement}',
                     // quantity:  '500gm X 1 Unit',
                     image: "${AppUrl.baseUrl}/${productData.image}"
                     // image:    "https://cdn.pixabay.com/photo/2023/02/28/01/51/qr-code-7819653_640.jpg",

                    );
                  },),

                  SizedBox(height: 10,),
                  CustomText(
                    'Bill Summary',
                    size: 14,
                    weight: FontWeight.w500,
                    color: ColorResource.black,
                  ),

                  SizedBox(height: 10),

                  OrderHistoryCard1(title1: "Delivery Fee", title2: "₹${deliveryCharge}"),
                  SizedBox(height: 5,),

                  OrderHistoryCard1(title1: "Total Bill", title2: "₹${totalAmount}"),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isProductExpanded = false;
                        });
                      },
                      child: Text(
                        'Hide Details',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : SizedBox.shrink(),
            ),


            SizedBox(height: 10,),
            Center(
              child: Container(
                width: 165,
                child: PrimaryButton(title: "${capitalize(orderStatus)}", onTap: () {}),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget OrderHistoryCard({
    required String image,
    required String title,
    required String price,
    required String discountPrice,
    required String quantity,
}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorResource.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
            //    'data:image/jpeg;base64,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',
              height: 60,
              width: 60,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported_outlined,size: 70,);
              },
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),
                SizedBox(height: 5,),
                CustomText(
                 quantity,
                  size: 10,
                  weight: FontWeight.w300,
                  color: ColorResource.black,
                ),
              ],
            ),
            Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '₹${price} ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.20,
                    ),
                  ),
                  TextSpan(
                    text: '₹${discountPrice}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                      height: 1.20,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.20,
                    ),
                  ),
                  TextSpan(
                    text: '  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget OrderHistoryCard1({
    required String title1,
    required String title2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title1,
          size: 13,
          weight: FontWeight.w500,
          color: ColorResource.black,
        ),

        CustomText(
          title2,
          size: 13,
          weight: FontWeight.w600,
          color: ColorResource.black,
        )
      ],
    );
  }
}
