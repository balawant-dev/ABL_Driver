// import 'dart:io';
// import 'package:abldriver/app/theme/color_resource.dart';
// import 'package:abldriver/core/constants/app_images.dart';
// import 'package:abldriver/presentaion/auth/login/ui/loginScreen.dart';
// import 'package:abldriver/widget/customImageView.dart';
// import 'package:abldriver/widget/custom_App_bar.dart';
// import 'package:abldriver/widget/custom_text.dart';
// import 'package:abldriver/widget/navigator_method.dart';
// import 'package:abldriver/widget/primary_button.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../widget/customInputBox.dart';
// import '../provider/registerProvider.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   File? profileImage ;
//   final ImagePicker _picker = ImagePicker();
//   TextEditingController nameController=TextEditingController();
//   TextEditingController phoneNumberController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   TextEditingController addressController=TextEditingController();
//   TextEditingController IDProofController=TextEditingController();
//   TextEditingController adharNumberController=TextEditingController();
//   TextEditingController vahicalTypeController=TextEditingController();
//   TextEditingController vahicalNumberController=TextEditingController();
//   TextEditingController DLNumberController=TextEditingController();
//
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(
//       source: source,
//       imageQuality: 70,
//     );
//
//     if (image != null) {
//       setState(() {
//         profileImage  = File(image.path);
//       });
//     }
//   }
//
//   File? _frontImage;
//   File? _backImage;
//   void _showImagePicker() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> pickImage(TextEditingController controller) async {
//     final XFile? image =
//     await _picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       controller.text = image.path; // 👈 show path
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Consumer<RegisterProvider>(
//         builder: (context, provider, child) {
//           return  Scaffold(
//             backgroundColor: ColorResource.white,
//             appBar: CustomAppBar(
//               title: 'Register',
//               showBackButton: false,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(15),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     /// Profile Image (FULL CIRCLE)
//                     Center(
//                       child: Column(
//                         children: [
//                           CustomText(
//                             'Enter your details to proceed further',
//                             size: 16,
//                             color: ColorResource.hafeBlack,
//                             weight: FontWeight.w400,
//                           ),
//                           const SizedBox(height: 20),
//                           GestureDetector(
//                             onTap: _showImagePicker,
//                             child: CircleAvatar(
//                               radius: 45,
//                               backgroundColor: Colors.grey.shade300,
//                               backgroundImage: provider.profileImage  != null
//                                   ? FileImage(provider.profileImage !)
//                                   : const AssetImage(AppImages.imageIcon)
//                               as ImageProvider,
//                             ),
//                           ),
//
//                           const SizedBox(height: 10),
//
//                           /// Upload Text
//                           GestureDetector(
//                             onTap: _showImagePicker,
//                             child: CustomText(
//                               'Upload Your Photo',
//                               size: 12,
//                               weight: FontWeight.w500,
//                               color: ColorResource.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Name',
//                       controller: provider.nameController,
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Phone Number',
//                       controller: provider.phoneController,
//                       keyboardType: TextInputType.number,
//                       maxLength: 10,
//
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Email ID',
//                       controller: provider.emailController,
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Address',
//                       controller: provider.addressController,
//                     ),
//                     SizedBox(height: 10,),
//
//                     CustomInputField(
//                       hintText: 'Upload Image',
//                       controller: provider.IDProofController,
//                       readOnly: true,
//                       // suffixIcon: const Icon(Icons.upload_file),
//                       suffixIcon: CustomImageView(imagePath: AppImages.attachment,height: 20,width: 20,),
//                       // onSuffixTap: () {
//                       //   pickImage(IDProofController);
//                       // },
//                       onSuffixTap: () async {
//                         final XFile? image =
//                         await ImagePicker().pickImage(source: ImageSource.gallery);
//
//                         if (image != null) {
//                           provider.setIdProofImage(File(image.path));
//                         }
//                       },
//
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Aadhar Card Number',
//                       controller: provider.adharController,
//                     ),
//                     SizedBox(height: 10,),
//
//                     DropDownInputBox(
//                       hint: 'Vehicle Type', // same as previous hint
//                       controller: provider.vahicalTypeController,
//                       dropdownItems: ['Car', 'Bike', 'Truck', 'Bus'], // list of vehicle types
//                       onChanged: (value) {
//                         print('Selected Vehicle Type: $value');
//                       },
//                     ),
//
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Vehical Number',
//                       controller: provider.vahicalNumberController,
//                     ),
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'Pincode',
//                       controller: provider.pincodeController,
//                     ),
//                     SizedBox(height: 10),
//                     CustomText(
//                       'Car RC',
//                       size: 12,
//                       weight: FontWeight.w500,
//                       color: ColorResource.black,
//                     ),
//                     SizedBox(height: 10),
//
//                     Row(
//                       children: [
//                         // Front Image
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () async {
//                               final XFile? image =
//                               await _picker.pickImage(source: ImageSource.gallery);
//                               if (image != null) {
//                                 setState(() {
//                                   _frontImage = File(image.path);
//                                 });
//                               }
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(1),
//                               height: 118,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 4,
//                                     offset: Offset(0, 0),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                                 image: provider.rcFontImage != null
//                                     ? DecorationImage(
//                                   image: FileImage(provider.rcFontImage!),
//                                   fit: BoxFit.cover, // ✅ fills entire container
//                                 )
//                                     : null,
//                               ),
//                               child: _frontImage == null
//                                   ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   CustomImageView(
//                                     imagePath: AppImages.imageUploadIcon,
//                                     height: 50,
//                                     width: 50,
//                                   ),
//                                   CustomText(
//                                     'Front Image',
//                                     size: 14,
//                                     color: ColorResource.hafeBlack,
//                                     weight: FontWeight.w400,
//                                   )
//                                 ],
//                               )
//                                   : null, // image already displayed as background
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         // Back Image
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () async {
//                               final XFile? image =
//                               await _picker.pickImage(source: ImageSource.gallery);
//                               if (image != null) {
//                                 setState(() {
//                                   _backImage = File(image.path);
//                                 });
//                               }
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(1),
//                               height: 118,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.white,
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 4,
//                                     offset: Offset(0, 0),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                                 image: provider.rcBackImage != null
//                                     ? DecorationImage(
//                                   image: FileImage(provider.rcBackImage!),
//                                   fit: BoxFit.cover,
//                                 )
//                                     : null,
//                               ),
//                               child: _backImage == null
//                                   ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   CustomImageView(
//                                     imagePath: AppImages.imageUploadIcon,
//                                     height: 50,
//                                     width: 50,
//                                   ),
//                                   CustomText(
//                                     'Back Image',
//                                     size: 14,
//                                     color: ColorResource.hafeBlack,
//                                     weight: FontWeight.w400,
//                                   )
//                                 ],
//                               )
//                                   : null,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(height: 10,),
//                     CustomInputField(
//                       hintText: 'DL Number',
//                       controller: provider.licenseController,
//                     ),
//                     SizedBox(height: 10,),
//
//
//
//                     PrimaryButton(
//                       title: 'Submit For Approval',
//                       onTap: () async {
//                         final provider = context.read<RegisterProvider>();
//
//                         await provider.registerDriver();
//
//                         if (provider.errorMessage == null) {
//                           // ✅ API Success → Show Dialog
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 backgroundColor: ColorResource.buttonBackground,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 insetPadding: const EdgeInsets.all(30),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       CustomText(
//                                         'Registration Submitted',
//                                         size: 22,
//                                         weight: FontWeight.w600,
//                                         color: ColorResource.white,
//                                       ),
//                                       const SizedBox(height: 20),
//                                       CustomText(
//                                         "Thank you for registering! Your details are under review. You'll be notified once approved and can then start accepting deliveries",
//                                         size: 12,
//                                         color: ColorResource.white,
//                                         weight: FontWeight.w500,
//                                       ),
//                                       const SizedBox(height: 20),
//                                       Row(
//                                         children: [
//                                           CustomImageView(
//                                             imagePath: AppImages.deliveryTruck,
//                                             height: 48,
//                                             width: 48,
//                                           ),
//                                           const SizedBox(width: 25),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: CustomText(
//                                               'Okay',
//                                               size: 18,
//                                               weight: FontWeight.w600,
//                                               color: ColorResource.green,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         } else {
//                           // ❌ API Failed → Show Error
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(provider.errorMessage!)),
//                           );
//                         }
//                       },
//                     ),
//
//
//                     SizedBox(height: 10,),
//                     GestureDetector(
//                       onTap: (){
//                         navPush(context: context, action: LoginScreen());
//                       },
//                       child: Center(
//                         child:  Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Already have an account ? ',
//                                 style: TextStyle(
//                                   color: Colors.black.withValues(alpha: 0.50),
//                                   fontSize: 16,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w400,
//                                   height: 1.50,
//                                   letterSpacing: 0.32,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: 'Login',
//                                 style: TextStyle(
//                                   color:ColorResource.buttonBackground,
//                                   fontSize: 16,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w400,
//                                   height: 1.50,
//                                   letterSpacing: 0.32,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
// }



import 'dart:io';
import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/auth/login/ui/loginScreen.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../widget/customInputBox.dart';
import '../provider/registerProvider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage(RegisterProvider provider) async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      provider.setProfileImage(File(image.path));
    }
  }

  Future<void> _pickRcFrontImage(RegisterProvider provider) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      provider.setRcFrontImage(File(image.path));
    }
  }

  Future<void> _pickRcBackImage(RegisterProvider provider) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      provider.setRcBackImage(File(image.path));
    }
  }

  Future<void> _pickIdProofImage(RegisterProvider provider) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      provider.setIdProofImage(File(image.path));
    }
  }

  void _showImagePicker(RegisterProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera, imageQuality: 70);
                  if (image != null) {
                    context.read<RegisterProvider>().setProfileImage(
                      File(image.path),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickProfileImage(context.read<RegisterProvider>());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CustomAppBar(
            title: 'Register',
            showBackButton: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile Image
                  Center(
                    child: Column(
                      children: [
                        CustomText(
                          'Enter your details to proceed further',
                          size: 16,
                          color: ColorResource.hafeBlack,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _showImagePicker(provider),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: provider.profileImage != null
                                ? FileImage(provider.profileImage!)
                                : const AssetImage(AppImages.imageIcon)
                            as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _showImagePicker(provider),
                          child: CustomText(
                            'Upload Your Photo',
                            size: 12,
                            weight: FontWeight.w500,
                            color: ColorResource.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Input Fields
                  CustomInputField(
                    hintText: 'Name',
                    controller: provider.nameController,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Phone Number',
                    controller: provider.phoneController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Email ID',
                    controller: provider.emailController,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Address',
                    controller: provider.addressController,
                  ),
                  const SizedBox(height: 10),

                  // ID Proof Upload
                  CustomInputField(
                    hintText: 'Upload Image',
                    controller: provider.IDProofController,
                    readOnly: true,
                    suffixIcon: CustomImageView(
                        imagePath: AppImages.attachment, height: 20, width: 20),
                    onSuffixTap: () => _pickIdProofImage(provider),
                  ),
                  const SizedBox(height: 10),

                  CustomInputField(
                    hintText: 'Aadhar Card Number',
                    controller: provider.adharController,
                  ),
                  const SizedBox(height: 10),

                  DropDownInputBox(
                    hint: 'Vehicle Type',
                    controller: provider.vahicalTypeController,
                    dropdownItems: ['Car', 'Bike', 'Truck', 'Bus'],
                    onChanged: (value) {
                      print('Selected Vehicle Type: $value');
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Vehical Number',
                    controller: provider.vahicalNumberController,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Pincode',
                    controller: provider.pincodeController,
                  ),
                  const SizedBox(height: 10),

                  CustomText(
                    'Car RC',
                    size: 12,
                    weight: FontWeight.w500,
                    color: ColorResource.black,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      // Front RC Image
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickRcFrontImage(provider),
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            height: 118,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                )
                              ],
                              image: provider.rcFontImage != null
                                  ? DecorationImage(
                                image: FileImage(provider.rcFontImage!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: provider.rcFontImage == null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: AppImages.imageUploadIcon,
                                  height: 50,
                                  width: 50,
                                ),
                                CustomText(
                                  'Front Image',
                                  size: 14,
                                  color: ColorResource.hafeBlack,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            )
                                : null,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Back RC Image
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickRcBackImage(provider),
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            height: 118,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                )
                              ],
                              image: provider.rcBackImage != null
                                  ? DecorationImage(
                                image: FileImage(provider.rcBackImage!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: provider.rcBackImage == null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: AppImages.imageUploadIcon,
                                  height: 50,
                                  width: 50,
                                ),
                                CustomText(
                                  'Back Image',
                                  size: 14,
                                  color: ColorResource.hafeBlack,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'DL Number',
                    controller: provider.licenseController,
                  ),
                  const SizedBox(height: 10),

                  PrimaryButton(
                   // title: 'Submit For Approval',
                    title: provider.isLoading ? "Sending.." : 'Submit For Approval',

                      onTap: () async {
                        await provider.registerDriver();

                        if (provider.success) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: ColorResource.buttonBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                insetPadding: const EdgeInsets.all(30),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        'Registration Submitted',
                                        size: 22,
                                        weight: FontWeight.w600,
                                        color: ColorResource.white,
                                      ),
                                      const SizedBox(height: 20),
                                      CustomText(
                                        "Thank you for registering! Your details are under review.",
                                        size: 12,
                                        color: ColorResource.white,
                                        weight: FontWeight.w500,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // Now navigation works here
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => LoginScreen()),
                                          );
                                        },
                                        child: const Text("Okay"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (provider.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.errorMessage!)),
                          );
                        }
                      }

                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      navPush(context: context, action: LoginScreen());
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account ? ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                                letterSpacing: 0.32,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: ColorResource.buttonBackground,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                                letterSpacing: 0.32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
