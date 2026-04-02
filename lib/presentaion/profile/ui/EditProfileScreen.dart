// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../../../widget/customInputBox.dart';
// import '../../../../widget/custom_text.dart';
// import '../../../../widget/custom_App_bar.dart';
// import '../../../../widget/customImageView.dart';
// import '../../../../widget/primary_button.dart';
// import '../../../WebServices/app_url.dart';
// import '../provider/profileProvider.dart';
// import '../../../../core/constants/app_images.dart';
// import '../../../../app/theme/color_resource.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedProfileImage;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
//     });
//   }
//
//   // ===== Pickers for images =====
//   Future<void> _pickProfileImage(ProfileProvider provider) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       setState(() {
//         _selectedProfileImage = file;
//       });
//       provider.setProfileImage(file);
//     }
//   }
//
//   Future<void> _pickRcFrontImage(ProfileProvider provider) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) provider.setRcFrontImage(File(pickedFile.path));
//   }
//
//   Future<void> _pickRcBackImage(ProfileProvider provider) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) provider.setRcBackImage(File(pickedFile.path));
//   }
//
//   Future<void> _pickIdProofImage(ProfileProvider provider) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) provider.setIdProofImage(File(pickedFile.path));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: ColorResource.white,
//           appBar: CustomAppBar(title: 'Edit Profile'),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ===== Profile Image =====
//                 Center(
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () => _pickProfileImage(provider),
//                         child: CircleAvatar(
//                           radius: 45,
//                           backgroundColor: Colors.grey.shade300,
//                           backgroundImage: _selectedProfileImage != null
//                               ? FileImage(_selectedProfileImage!)
//                               : (provider.getProfileData?.data?.profileImage?.isNotEmpty ?? false)
//                               ? NetworkImage(
//                               "${AppUrl.baseUrl}/${provider.getProfileData!.data!.profileImage!}")
//                               : const AssetImage(AppImages.imageIcon) as ImageProvider,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: () => _pickProfileImage(provider),
//                         child: CustomText(
//                           'Edit',
//                           size: 12,
//                           weight: FontWeight.w500,
//                           color: ColorResource.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ===== Name =====
//                 CustomInputField(
//                   hintText: 'Name',
//                   controller: provider.nameController,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Phone Number =====
//                 CustomInputField(
//                   hintText: 'Phone Number',
//                   controller: provider.phoneNumberController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 10,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Email =====
//                 CustomInputField(
//                   hintText: 'Email',
//                   controller: provider.emailController,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Address =====
//                 CustomInputField(
//                   hintText: 'Address',
//                   controller: provider.addressController,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== ID Proof Upload =====
//                 CustomInputField(
//                   hintText: 'Upload ID Proof',
//                   controller: provider.IDProofController,
//                   readOnly: true,
//                   suffixIcon: CustomImageView(
//                     imagePath: AppImages.attachment,
//                     height: 20,
//                     width: 20,
//                   ),
//                   onSuffixTap: () => _pickIdProofImage(provider),
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Aadhar Number =====
//                 CustomInputField(
//                   hintText: 'Aadhar Number',
//                   controller: provider.adharNumberController,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Vehicle Type =====
//                 CustomInputField(
//                   hintText: 'Vehicle Type',
//                   controller: provider.vahicalTypeController,
//                 ),
//                 const SizedBox(height: 10),
//
//                 // ===== Vehicle Number =====
//                 CustomInputField(
//                   hintText: 'Vehicle Number',
//                   controller: provider.vahicalNumberController,
//                 ),
//                 const SizedBox(height: 20),
//
//                 CustomText(
//                   'Car RC Images',
//                   size: 14,
//                   weight: FontWeight.w600,
//                   color: ColorResource.black,
//                 ),
//                 const SizedBox(height: 10),
//
//                 Row(
//                   children: [
//                     // ===== RC Front =====
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => _pickRcFrontImage(provider),
//                         child: Container(
//                           height: 120,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.grey.shade200,
//                             image: provider.rcFontImage != null
//                                 ? DecorationImage(
//                               image: FileImage(provider.rcFontImage!),
//                               fit: BoxFit.cover,
//                             )
//                                 : null,
//                           ),
//                           child: provider.rcFontImage == null
//                               ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomImageView(
//                                 imagePath: AppImages.imageUploadIcon,
//                                 height: 50,
//                                 width: 50,
//                               ),
//                               CustomText(
//                                 'Front Image',
//                                 size: 14,
//                                 color: ColorResource.hafeBlack,
//                               ),
//                             ],
//                           )
//                               : null,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//
//                     // ===== RC Back =====
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => _pickRcBackImage(provider),
//                         child: Container(
//                           height: 120,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.grey.shade200,
//                             image: provider.rcBackImage != null
//                                 ? DecorationImage(
//                               image: FileImage(provider.rcBackImage!),
//                               fit: BoxFit.cover,
//                             )
//                                 : null,
//                           ),
//                           child: provider.rcBackImage == null
//                               ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomImageView(
//                                 imagePath: AppImages.imageUploadIcon,
//                                 height: 50,
//                                 width: 50,
//                               ),
//                               CustomText(
//                                 'Back Image',
//                                 size: 14,
//                                 color: ColorResource.hafeBlack,
//                               ),
//                             ],
//                           )
//                               : null,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ===== DL Number =====
//                 CustomInputField(
//                   hintText: 'DL Number',
//                   controller: provider.DLNumberController,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ===== Save Button =====
//                 PrimaryButton(
//                   title: provider.isLoading ? 'Saving...' : 'Save',
//                   onTap: () async {
//                     await provider.registerDriver();
//                     if (provider.success) {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: CustomText(
//                             'Profile Updated',
//                             size: 18,
//                             weight: FontWeight.w600,
//                             color: ColorResource.black,
//                           ),
//                           content: CustomText(
//                             'Your profile has been updated successfully!',
//                             size: 14,
//                             color: ColorResource.black,
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('OK'),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else if (provider.errorMessage != null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(provider.errorMessage!)),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../widget/customInputBox.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/custom_App_bar.dart';
import '../../../../widget/customImageView.dart';
import '../../../../widget/primary_button.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../app/theme/color_resource.dart';
import '../../../WebServices/app_url.dart';
import '../provider/profileProvider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfileData();
    });
  }

  Future<void> _pickImage(Function(File) setter) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setter(File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final data = provider.getProfileData?.data;

        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CustomAppBar(title: 'Edit Profile'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ================= PROFILE IMAGE =================
                Center(
                  child: GestureDetector(
                    onTap: () => _pickImage(provider.setProfileImage),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: provider.profileImage != null
                          ? FileImage(provider.profileImage!)
                          : (data?.profileImage != null &&
                          data!.profileImage!.isNotEmpty)
                          ? NetworkImage(
                          "${AppUrl.baseUrl}/${data.profileImage}")
                          : const AssetImage(AppImages.imageIcon)
                      as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// ================= TEXT FIELDS =================
                CustomInputField(
                  hintText: 'Name',
                  controller: provider.nameController,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Phone Number',
                  controller: provider.phoneNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Email',
                  controller: provider.emailController,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Address',
                  controller: provider.addressController,
                ),
                const SizedBox(height: 10),

                /// ================= ID PROOF =================
                CustomInputField(
                  hintText: 'ID Proof',
                  controller: provider.IDProofController
                    ..text = data?.idProofImage?.split('/').last ?? '',
                  readOnly: true,
                  suffixIcon: CustomImageView(
                    imagePath: AppImages.attachment,
                    height: 20,
                    width: 20,
                  ),
                  onSuffixTap: () => _pickImage(provider.setIdProofImage),
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Aadhar Number',
                  controller: provider.adharNumberController,
                  maxLength: 12,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Vehicle Type',
                  controller: provider.vahicalTypeController,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  hintText: 'Vehicle Number',
                  controller: provider.vahicalNumberController,
                ),
                const SizedBox(height: 20),

                /// ================= RC IMAGES =================
                CustomText(
                  'Car RC Images',
                  size: 14,
                  weight: FontWeight.w600,
                  color: ColorResource.black,
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickImage(provider.setRcFrontImage),
                        child: _rcBox(
                          file: provider.rcFontImage,
                          networkPath: data?.vehicleRcFrontImage,
                          label: 'Front Image',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickImage(provider.setRcBackImage),
                        child: _rcBox(
                          file: provider.rcBackImage,
                          networkPath: data?.vehicleRcBackImage,
                          label: 'Back Image',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                CustomInputField(
                  hintText: 'DL Number',
                  controller: provider.DLNumberController,
                ),
                const SizedBox(height: 25),

                /// ================= SAVE BUTTON =================
                PrimaryButton(
                  title: provider.isLoading ? 'Saving...' : 'Save',
                  onTap: () async {
                    await provider.registerDriver();

                    if (provider.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile Updated Successfully'),
                        ),
                      );
                    } else if (provider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text(provider.errorMessage!)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ================= RC BOX WIDGET =================
  Widget _rcBox({
    required File? file,
    required String? networkPath,
    required String label,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade200,
        image: file != null
            ? DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        )
            : (networkPath != null && networkPath.isNotEmpty)
            ? DecorationImage(
          image: NetworkImage(
            "${AppUrl.baseUrl}/$networkPath",
          ),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: file == null && (networkPath == null || networkPath.isEmpty)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: AppImages.imageUploadIcon,
            height: 50,
            width: 50,
          ),
          CustomText(
            label,
            size: 14,
            color: ColorResource.hafeBlack,
          ),
        ],
      )
          : null,
    );
  }
}
