import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:flutter/material.dart';

import '../app/theme/color_resource.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorResource.white,

      leadingWidth: 72,
      leading: showBackButton
          ? Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CustomImageView(
            imagePath: AppImages.backButton,
            height: 40,
            width: 40,
          ),
        ),
      )
          : const SizedBox(),


      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
