// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CustomInputField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final bool readOnly;
//   final VoidCallback? onTap;
//
//   // 🔹 NEW
//   final int? minLength;
//   final int? maxLength;
//   final bool digitsOnly;
//
//   const CustomInputField({
//     super.key,
//     required this.hintText,
//     required this.controller,
//     this.keyboardType = TextInputType.text,
//     this.readOnly = false,
//     this.onTap,
//     this.minLength,
//     this.maxLength,
//     this.digitsOnly = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(1),
//       width: double.infinity,
//       height: 50,
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         shadows: const [
//           BoxShadow(
//             color: Color(0x3F000000),
//             blurRadius: 4,
//             offset: Offset(0, 0),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         readOnly: readOnly,
//         onTap: onTap,
//         maxLength: maxLength,
//         inputFormatters: [
//           if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
//           if (maxLength != null)
//             LengthLimitingTextInputFormatter(maxLength),
//         ],
//         style: const TextStyle(
//           fontSize: 14,
//           fontFamily: 'Poppins',
//         ),
//         decoration: InputDecoration(
//           counterText: "", // hides length counter
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//           border: InputBorder.none,
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.black.withValues(alpha: 0.50),
//             fontSize: 12,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w400,
//             letterSpacing: 0.24,
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 Call this when validating (button click)
//   bool isValid() {
//     if (minLength != null && controller.text.length < minLength!) {
//       return false;
//     }
//     if (maxLength != null && controller.text.length > maxLength!) {
//       return false;
//     }
//     return true;
//   }
// }


import 'package:abldriver/app/theme/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  final int? minLength;
  final int? maxLength;
  final bool digitsOnly;

  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;

  final int maxLines;

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.minLength,
    this.maxLength,
    this.digitsOnly = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: double.infinity,

      // ✅ IMPORTANT FIX
      height: maxLines == 1 ? 50 : null,

      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        maxLength: maxLength,

        // ✅ IMPORTANT FIX
        maxLines: maxLines,
        minLines: maxLines,

        inputFormatters: [
          if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
          if (maxLength != null)
            LengthLimitingTextInputFormatter(maxLength),
        ],
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: hintText,

          // ✅ better padding for multi-line
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),

          suffixIcon: suffixIcon != null
              ? InkWell(
            onTap: onSuffixTap,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(child: suffixIcon),
            ),
          )
              : null,

          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.24,
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (minLength != null && controller.text.length < minLength!) {
      return false;
    }
    if (maxLength != null && controller.text.length > maxLength!) {
      return false;
    }
    return true;
  }
}



class CustomInputField1 extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  final int? minLength;
  final int? maxLength;
  final bool digitsOnly;

  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;

  final int maxLines;

  const CustomInputField1({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.minLength,
    this.maxLength,
    this.digitsOnly = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: double.infinity,

      // ✅ IMPORTANT FIX
      height: maxLines == 1 ? 50 : null,

      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0xFF086B48),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        maxLength: maxLength,

        // ✅ IMPORTANT FIX
        maxLines: maxLines,
        minLines: maxLines,

        inputFormatters: [
          if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
          if (maxLength != null)
            LengthLimitingTextInputFormatter(maxLength),
        ],
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: hintText,

          // ✅ better padding for multi-line
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),

          suffixIcon: suffixIcon != null
              ? InkWell(
            onTap: onSuffixTap,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(child: suffixIcon),
            ),
          )
              : null,

          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.24,
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (minLength != null && controller.text.length < minLength!) {
      return false;
    }
    if (maxLength != null && controller.text.length > maxLength!) {
      return false;
    }
    return true;
  }
}




class DropDownInputBox extends StatefulWidget {
  final String hint;
  final IconData? prefixIcon;
  final List<String> dropdownItems;
  final TextEditingController controller;
  final Color? hintColor;
  final Color? textColor;
  final ValueChanged<String>? onChanged;

  const DropDownInputBox({
    super.key,
    required this.hint,
    this.prefixIcon,
    required this.dropdownItems,
    required this.controller,
    this.hintColor,
    this.textColor,
    this.onChanged,
  });

  @override
  State<DropDownInputBox> createState() => _DropDownInputBoxState();
}

class _DropDownInputBoxState extends State<DropDownInputBox> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Container(
            margin: EdgeInsets.all(1),
            height: 50, // same height as CustomInputField
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                if (widget.prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(widget.prefixIcon,
                        size: 20, color: Colors.grey),
                  ),
                Expanded(
                  child: Text(
                    widget.controller.text.isEmpty
                        ? widget.hint
                        : widget.controller.text,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.hintColor ??ColorResource.hafeBlack,
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),

        // Dropdown items
        if (isOpen)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8), // same radius
              border: Border.all(color: Colors.black12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Column(
              children: widget.dropdownItems.map((item) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.controller.text = item;
                      isOpen = false;
                      if (widget.onChanged != null) widget.onChanged!(item);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.black54, // simple way
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}



class CustomPhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final String prefix;
  final String hintText;
  final TextInputType keyboardType;
  final int? maxLength;

  const CustomPhoneInput({
    Key? key,
    required this.controller,
    this.prefix = '+91',
    this.hintText = 'Phone Number',
    this.keyboardType = TextInputType.number,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // Prefix
          Text(
            prefix,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          // Vertical Separator
          Container(
            width: 1,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: const Color(0xFFA7A7A7),
          ),
          // TextField
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              decoration: InputDecoration(
                counterText: '', // removes the maxLength counter
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
