

import 'dart:async';
import 'dart:io';

import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/homeScreen/ui/onGoingOrderById.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widget/primary_button.dart';
import '../provider/homeProvider.dart';

class OnGoingOrder extends StatefulWidget {
  const OnGoingOrder({super.key});

  @override
  State<OnGoingOrder> createState() => _OnGoingOrderState();
}

class _OnGoingOrderState extends State<OnGoingOrder> {
  bool isExpanded = false;

// Open phone dialer
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


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Change this to your ACTUAL fetch method name in the provider
      Provider.of<HomeProvider>(context, listen: false).fetchOnGoingOrderData();

    });
  }
  Future<File?> showDeliveryDialog(BuildContext context) async {
    File? selectedImage;

    return await showDialog<File>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  CustomText(
                    'Add Photo',
                    size: 14,
                    weight: FontWeight.w600,
                    color: ColorResource.black,
                  ),

                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 60,
                      );

                      if (image != null) {
                        setState(() {
                          selectedImage = File(image.path);
                        });
                      }
                    },
                    child: selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        selectedImage!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const CustomImageView(
                        imagePath: AppImages.imageIconUpload,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                ],
              ),
              actions: [

                SizedBox(
                width: 250,
                height: 45,
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF086B48),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            ),
            elevation: 4,
            shadowColor: const Color(0x26000000),
            ),
            onPressed: () {
            if (selectedImage == null) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            content: Text("Please upload image"),
            ),
            );
            return;
            }

            Navigator.pop(context, selectedImage);
            },
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
            Icon(
            Icons.upload,
            color: Colors.white,
            size: 20,
            ),
            SizedBox(width: 10),
            Text(
            'Click here to upload',
            style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            ),
            ),
            ],
            ),
            ),
            ),

            ],
            );
          },
        );
      },
    );
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
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final order = orders[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardData(
                      orerId: order.bookingId ?? "",
                      pickup: order.pickup?.address ??"",
                    pickupName: order.pickup?.name ??"",
                    pickupNumber: order.pickup?.mobileNo ??"",
                      drop: order.delivery?.address1 ?? "",
                    devilerNumber: order.delivery?.mobileNo ?? "",
                      customer: order.delivery?.name ?? "",
                    //  distance: order.distance,
                      price: order.totalAmount.toString() ,
                      date: order.createdAt ?? "",
                      PaymentMood: order.paymentMode ?? "",
                      note: order.delivery?.deliveryInsturction ?? "",
                    //product
                    productName: order.products?.first.name ?? "",
                    productPrice: order.products?.first.price.toString() ?? "",
                    productQuantity: order.products?.first.quantity.toString() ?? "",
                    productFinalPrice: order.products?.first.finalPrice.toString() ?? "",



                      // onTap: () async {
                      //   final homeProvider =
                      //   Provider.of<HomeProvider>(context, listen: false);
                      //
                      //   File? image = await showDeliveryDialog(context);
                      //   if (image == null) return;
                      //
                      //   bool success = await homeProvider.acceptOrderStatus1(
                      //     orderId: order.sId ?? "",
                      //     status: "delivered",
                      //     deliveryProofImage: image,
                      //   );
                      //
                      //   if (!context.mounted) return; // ✅ MOST IMPORTANT
                      //
                      //   if (success) {
                      //     Future.microtask(() {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (_) => DeliveryCompletedScreen(sId: order.sId ?? "",),
                      //         ),
                      //       );
                      //     });
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(content: Text("Failed to update status")),
                      //     );
                      //   }
                      // }
                      onTap: () async {
                        final homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);

                        // 🔒 Prevent multiple taps
                        if (homeProvider.isLoading) return;

                        // 1️⃣ Open camera dialog
                        final File? image = await showDeliveryDialog(context);
                        if (image == null) return;

                        // 2️⃣ Call API
                  await homeProvider.acceptOrderStatus1(
                          orderId: order.sId ?? "",
                          status: "delivered",
                          deliveryProofImage: image,context: context
                        );

                      }




                  ),
                );
              },
            ),
          );
        }
    );
  }
  String onlyDate(String fullDate) {
    final parsedDate = DateTime.parse(fullDate);
    return "${parsedDate.day.toString().padLeft(2, '0')}-"
        "${parsedDate.month.toString().padLeft(2, '0')}-"
        "${parsedDate.year}";
  }

 // final repo = ContactRepository();

  Widget CardData({
    required String orerId,
    required String pickup,
    required String drop,
    required String customer,
   // required String distance,
    required String price,
    required String date,
    required String PaymentMood,
    required String pickupName,
    required String note,
    required String pickupNumber,
    required String devilerNumber,

    //product
    required String productName,
    required String productPrice,
    required String productQuantity,
    required String productFinalPrice,
    required VoidCallback onTap,

  }){
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                // CustomText(
                //   date,
                //   size: 15,
                //   color: ColorResource.black,
                //   weight: FontWeight.w500,
                // )
                CustomText(
                  onlyDate(date),
                  size: 15,
                  color: ColorResource.black,
                  weight: FontWeight.w500,
                )

              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 234,
                  child: Column(
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                'Name :',
                                size: 11,
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
                              // CustomText(
                              //   // 'H- 116, Sec-59, Noida',
                              //   pickup,
                              //   size: 13,
                              //   weight: FontWeight.w400,
                              //   color: ColorResource.black,
                              // ),
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
                                pickupName,
                                size: 11,
                                weight: FontWeight.w400,
                                color: ColorResource.black,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                'Drop:',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),
                              SizedBox(height: 5,),
                              CustomText(
                                '',
                                size: 13,
                                weight: FontWeight.w600,
                                color: ColorResource.black,
                              ),

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
                          Container(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Text(
                                //   drop,
                                //   textAlign: TextAlign.justify,
                                //   style: TextStyle(
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.w400,
                                //     color: ColorResource.black,
                                //   ),
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                //   strutStyle: StrutStyle(
                                //     fontSize: 13,
                                //     height: 1.5, // controls line height
                                //     forceStrutHeight: true,
                                //   ),
                                // ),
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
                      SizedBox(height: 45,),
                      GestureDetector(
                        onTap: () {
                          launchSMS(pickupNumber); // sms to deliver number
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
                          launchCall(pickupNumber); // call pickup number
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
                          launchSMS(devilerNumber); // sms to deliver number
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
                          launchCall(devilerNumber); // call deliver number
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
                  'Payment Mode:',
                  size: 13,
                  weight: FontWeight.w500,
                  color: ColorResource.black,
                ),

                CustomText(
                  PaymentMood,
                  size: 13,
                  weight: FontWeight.w600,
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
            CustomText(
              'Delivery Notes:',
              size: 13,
              weight: FontWeight.w500,
              color: ColorResource.black,
            ),
            SizedBox(height: 10,),
            note.isNotEmpty
                ? Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorResource.cardColor1,
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CustomText(
                  note,
                  size: 11,
                  weight: FontWeight.w500,
                  color: ColorResource.white,
                  align: TextAlign.justify,
                ),
              ),
            )
                : SizedBox.shrink(),

            SizedBox(height: 10,),
            // Center(
            //   child: Text(
            //     'Product Details',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontFamily: 'Poppins',
            //       fontWeight: FontWeight.w600,
            //       decoration: TextDecoration.underline,
            //       height: 1.50,
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Center(
                child: Text(
                  isExpanded ? "Hide" : "Product Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            if (isExpanded)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          'Product Name:',
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          'Product Price:',
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          'Product Quantity:',
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          'Product Final Price:',
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),

                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          productName,
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          productPrice,
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          productQuantity,
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),
                        CustomText(
                          productFinalPrice,
                          size: 13,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),SizedBox(height: 5,),

                      ],
                    )
                  ],
                ),
              ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                width: 165,
                child: PrimaryButton(title: "Update Status", onTap: onTap),
              ),
            ),

          ],
        ),
      ),
    );
  }


}
