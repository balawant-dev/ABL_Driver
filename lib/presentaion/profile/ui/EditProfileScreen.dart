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
                  maxLength: 8,
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
                  maxLength: 15,
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
