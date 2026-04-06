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

  // Future<void> _pickIdProofImage(RegisterProvider provider) async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     provider.setIdProofImage(File(image.path));
  //   }
  // }

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
                    errorText: provider.nameError,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Phone Number',
                    controller: provider.phoneController,
                    keyboardType: TextInputType.number,
                    errorText: provider.phoneError,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Email ID',
                    controller: provider.emailController,
                    errorText: provider.emailError,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Address',
                    controller: provider.addressController,
                    errorText: provider.addressError,
                    maxLength: 12,
                  ),
                  const SizedBox(height: 10),

                  // ID Proof Upload
                  // CustomInputField(
                  //   hintText: 'ID Proof',
                  //   controller: provider.IDProofController,
                  //   readOnly: true,
                  //   suffixIcon: CustomImageView(
                  //       imagePath: AppImages.attachment, height: 20, width: 20),
                  //   onSuffixTap: () => _pickIdProofImage(provider),
                  // ),
                  const SizedBox(height: 10),

                  CustomInputField(
                    hintText: 'Aadhar Card Number',
                    controller: provider.adharController,
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    errorText: provider.adharError,
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
                    errorText: provider.vehicleNumberError,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    hintText: 'Pincode',
                    controller: provider.pincodeController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    errorText: provider.pincodeError,
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
                    errorText: provider.licenseError,
                  ),
                  const SizedBox(height: 10),

                  if (provider.imageError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        provider.imageError!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  // PrimaryButton(
                  //  // title: 'Submit For Approval',
                  //   title: provider.isLoading ? "Sending.." : 'Submit For Approval',
                  //
                  //     onTap: () async {
                  //       await provider.registerDriver();
                  //
                  //       if (provider.success) {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return Dialog(
                  //               backgroundColor: ColorResource.buttonBackground,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(15),
                  //               ),
                  //               insetPadding: const EdgeInsets.all(30),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: [
                  //                     CustomText(
                  //                       'Registration Submitted',
                  //                       size: 22,
                  //                       weight: FontWeight.w600,
                  //                       color: ColorResource.white,
                  //                     ),
                  //                     const SizedBox(height: 20),
                  //                     CustomText(
                  //                       "Thank you for registering! Your details are under review.",
                  //                       size: 12,
                  //                       color: ColorResource.white,
                  //                       weight: FontWeight.w500,
                  //                     ),
                  //                     const SizedBox(height: 20),
                  //                     ElevatedButton(
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                         // Now navigation works here
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(builder: (_) => LoginScreen()),
                  //                         );
                  //                       },
                  //                       child: const Text("Okay"),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       } else if (provider.errorMessage != null) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(content: Text(provider.errorMessage!)),
                  //         );
                  //       }
                  //     }
                  //
                  // ),


                  PrimaryButton(
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
                    },
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
