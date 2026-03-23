import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/material.dart';
class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:ColorResource.buttonBackground,
          borderRadius: BorderRadius.circular(60),
        ),
        // child: Text(
        //   title,
        //   style: const TextStyle(
        //     color: Colors.white,
        //     fontSize: 18,
        //     fontFamily: 'Poppins',
        //     fontWeight: FontWeight.w500,
        //   ),
        child: CustomText(
          title,
          color: Colors.white,
          size: 16,
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}


class grayButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;

  const grayButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:ColorResource.gray,
          borderRadius: BorderRadius.circular(60),
        ),
        // child: Text(
        //   title,
        //   style: const TextStyle(
        //     color: Colors.white,
        //     fontSize: 18,
        //     fontFamily: 'Poppins',
        //     fontWeight: FontWeight.w500,
        //   ),
        child: CustomText(
          title,
          color: Colors.white,
          size: 16,
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Register Button
///
class RegisterButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;

  const RegisterButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:ColorResource.registerButtonBackground,
          borderRadius: BorderRadius.circular(60),
        ),

        child: CustomText(
          title,
          color: ColorResource.buttonBackground,
          size: 16,
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}





class SwipeButton extends StatefulWidget {
  final VoidCallback onAccepted;

  const SwipeButton({super.key, required this.onAccepted});

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double dragPosition = 0;
  final double maxDrag = 290 - 54; // container width - knob size

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF605238), Color(0xFF086B48)],
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'Swipe To Accept',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),

          /// 🔘 Swipe Circle
          Positioned(
            left: dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  dragPosition += details.delta.dx;
                  if (dragPosition < 0) dragPosition = 0;
                  if (dragPosition > maxDrag) dragPosition = maxDrag;
                });
              },
              onHorizontalDragEnd: (_) {
                if (dragPosition >= maxDrag * 0.9) {
                  widget.onAccepted(); // ✅ ACCEPTED
                }
                setState(() {
                  dragPosition = 0; // reset
                });
              },
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: ColorResource.buttonBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
