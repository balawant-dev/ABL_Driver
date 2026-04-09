

import 'dart:io';
import 'package:abldriver/WebServices/app_url.dart';
import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/profile/provider/profileProvider.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/customPageRefresher.dart';
import '../../accountDetailsScreen/ui/AccountDetailsScreen.dart';
import '../../cmsScreen/ui/privacyPolicy.dart';
import '../../cmsScreen/ui/termsAndCondition.dart';
import '../../splash/splashScreen.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImagePicker() {
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
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, provider, child){
          return  Scaffold(
            appBar: CustomAppBar(title: 'Profile'),
            backgroundColor: Colors.white,
            body:CustomPageRefresher(
                onRefresh: () async{
                  await provider.getProfileData!;
                },child: SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 10),

                /// Profile Image + Edit
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showImagePicker,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey.shade300,
                          child: ClipOval(
                            child: _selectedImage != null
                                ? Image.file(
                              _selectedImage!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            )
                                : (provider.getProfileData?.data?.profileImage != null &&
                                provider.getProfileData!.data!.profileImage!.isNotEmpty)
                                ? Image.network(
                              "${AppUrl.baseUrl}/${provider.getProfileData!.data!.profileImage!}",
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppImages.imageIcon,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                                : Image.asset(
                              AppImages.imageIcon,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),


                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          navPush(
                            context: context,
                            action: const EditProfileScreen(),
                          );
                        },
                        child: CustomText(
                          'Edit',
                          size: 12,
                          weight: FontWeight.w500,
                          color: ColorResource.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// Menu List (10px gap)
                // _menuItem("User Profile",),
                _menuItem(
                  "User Profile",
                      () {
                    navPush(context: context, action: EditProfileScreen());
                  },
                ),

                // const SizedBox(height: 10),
                // _menuItem("Report Issue",
                //         (){
                //
                //     }
                // ),
                const SizedBox(height: 10),
                // _menuItem("Bank Details"),
                _menuItem(
                  "Bank Details",
                      () {
                    navPush(context: context, action: AccountDetailsScreen());

                  },
                ),
                const SizedBox(height: 10),
                _menuItem("Privacy & Policy",
                        (){
                      navPush(context: context, action: PrivaCyPolicy());
                    }
                ),
                const SizedBox(height: 10),
                _menuItem("Terms & Condition",
                        (){
                      navPush(context: context, action: TermsAndCondition());
                    }
                ),

                const SizedBox(height: 30),

                /// Logout Button
                GestureDetector(
                  onTap: (){
                    _showLogoutDialog(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
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
                        const SizedBox(width: 18),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
            )


          );
        }
    );


  }

  /// Reusable Menu Item
  Widget _menuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔶 Icon
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: ColorResource.buttonBackground.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout,
                    color: ColorResource.buttonBackground,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 16),

                // 🔶 Title
                CustomText(
                  'Logout',
                  size: 18,
                  color: ColorResource.black,
                  weight: FontWeight.w600,
                ),

                const SizedBox(height: 8),

                // 🔶 Message
                CustomText(
                  'Are you sure you want to logout?',
                  size: 14,
                  color: Colors.grey.shade700,
                  weight: FontWeight.w400,
                  // textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // 🔶 Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: ColorResource.buttonBackground,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: ColorResource.buttonBackground,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResource.buttonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          final pref = await SharedPreferences.getInstance();
                          await pref.clear();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SplashScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        child: const Text(
                          'Yes, Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}









