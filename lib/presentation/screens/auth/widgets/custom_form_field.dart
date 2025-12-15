import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormfields extends StatelessWidget {
  const CustomFormfields({
    super.key,
    this.obscureText = false,
    required this.hintText,
    required this.prefixIcon,
    required this.label,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
  });

  final bool obscureText;
  final String hintText;
  final IconData prefixIcon;
  final String label;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Optician',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black45,
          ),
        ),
        5.verticalSpace,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            prefixIcon: Icon(prefixIcon),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}


