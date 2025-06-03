import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/auth/widgets/custom_form_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.isLogin,
    required this.obscureText,
    required this.onPressed,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool isLogin;
  final bool obscureText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFormfields(
          hintText: 'Enter your email',
          prefixIcon: Icons.email_rounded,
          label: 'e-mail',
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
            ).hasMatch(value.trim())) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        10.verticalSpace,
        if (!isLogin) ...[
          CustomFormfields(
            hintText: 'Enter your name',
            prefixIcon: Icons.person_rounded,
            label: 'name',
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ),
          10.verticalSpace,
          CustomFormfields(
            hintText: 'Enter your phone number',
            prefixIcon: Icons.phone_rounded,
            label: 'phone number',
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          ),
          10.verticalSpace,
        ],
        CustomFormfields(
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_rounded,
          label: 'password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscureText,
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
          ),
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.trim().length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }
}
