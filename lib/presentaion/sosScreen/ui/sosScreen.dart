import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/sosScreen/provider/sosProvider.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/customInputBox.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  TextEditingController nameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController RemarkController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SosProvider>(
        builder: (context, sosProvider, child) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Sos',showBackButton: false,),
            backgroundColor: ColorResource.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SosCard(
                      onTap: (){},
                      imagePath: AppImages.callIcon,
                      title: 'Call Now',
                    ),
                    SizedBox(height: 10,),
                    SosCard(
                      onTap: (){},
                      imagePath: AppImages.whatsappIcon,
                      title: 'Whatsapp Now',
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResource.sosCard,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Fill this Enquiry Form',
                            size: 14,
                            color: ColorResource.black,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(height: 10,),
                          CustomInputField(
                            hintText: 'Your Name',
                            controller: nameController,
                          ),
                          SizedBox(height: 10,),
                          CustomInputField(
                            hintText: 'Mobile Number',
                            controller: phoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          SizedBox(height: 10,),
                          CustomInputField(
                            hintText: 'Remark',
                            controller: RemarkController,
                            maxLines: 3,
                          ),
                          SizedBox(height: 10,),
                          PrimaryButton(
                           // title: 'Submit',
                            title: sosProvider.loading ? 'Sending...' : 'Submit',
                            onTap: () async {
                              await sosProvider.sendSos(
                                name: nameController.text,
                                number: phoneController.text,
                                remark: RemarkController.text,
                              );

                              if (sosProvider.error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(sosProvider.error!)),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("SOS sent successfully"),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SosCard1(
                          imagePath: AppImages.police,
                          title: 'Police(112)',
                        ),
                        SosCard1(
                          imagePath: AppImages.fire,
                          title: 'Fire Brigade(101)',
                        ),
                        SosCard1(
                          imagePath: AppImages.ambulance,
                          title: 'Ambulance(102)',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget SosCard({
    required VoidCallback onTap,
    required String imagePath,
    required String title,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            CustomImageView(
                imagePath: imagePath,
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10,),
            CustomText(
              title,
              size: 14,
              weight: FontWeight.w400,
              color: ColorResource.black,
            )
          ],
        ),
      ),
    );
  }
  Widget SosCard1({
    required String imagePath,
    required String title,
}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Column(
        children: [
          CustomImageView(
              imagePath: imagePath,
            height: 60,
            width: 60,
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            width: 100,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              shadows: [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 4,
                  offset: Offset(4, 0),
                  spreadRadius: 0,
                )
              ],
            ),child: CustomText(
            title,
            size: 12,
            color: ColorResource.buttonBackground,
            weight: FontWeight.w500,
          ),
          )
        ],
      ),
    );
  }
}

