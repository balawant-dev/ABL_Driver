import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/homeScreen/ui/homeScreen.dart';
import 'package:abldriver/presentaion/mainBottomBar/ui/mainBottomBar.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
class DeliveryCompletedScreen extends StatefulWidget {
  final String sId;
  const DeliveryCompletedScreen({super.key, required this.sId});

  @override
  State<DeliveryCompletedScreen> createState() => _DeliveryCompletedScreenState();
}

class _DeliveryCompletedScreenState extends State<DeliveryCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${widget.sId}'),
      backgroundColor: ColorResource.white,
      body: Padding(
          padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CustomText(
              ' Delivery  Completed',
              size: 25,
              color: ColorResource.buttonBackground,
              weight: FontWeight.w600,
            ),
            SizedBox(height: 25,),
            CustomImageView(
                imagePath: AppImages.boxImage,
              height: 138,
              width: 138,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 35,),
            PrimaryButton(title: 'Back to home', onTap: (){
              navPush(context: context, action: MainBottomBar());
            }),
          ],
        ),
      ),
    );
  }
}
