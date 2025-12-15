import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

import '../../../data/models/custom_error_model.dart';
import 'package:well_task_app/core/utils/config/show_confirm_dialog.dart';
import '../../providers/auth/sign up/sign_up_provider.dart';
import '../../providers/auth/sign_in/sign_in_provider.dart';
import 'reset_password_page.dart';
import 'widgets/custom_form.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key, required this.size});
  final Size size;

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLogin = true;
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Perform login or sign up action here
      if (isLogin) {
        ref
            .read(signInProvider.notifier)
            .signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
      } else {
        ref
            .read(signUpProvider.notifier)
            .signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              name: nameController.text.trim(),
              phone: phoneController.text.trim(),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isLogin ? signInProvider : signUpProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          final error =
              e is CustomErrorModel
                  ? e
                  : CustomErrorModel(code: 'Error', message: e.toString());
          showConfirmDialog(
            context: context,
            title: error.code,
            message: error.message,
            showNO: false,
          );
        },
      );
    });

    final authState =
        isLogin ? ref.watch(signInProvider) : ref.watch(signUpProvider);

    var children = [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset('assets/svg/icons/Arrow - Left.svg'),
      ),
      20.verticalSpace,
      Text(
        '${isLogin ? 'Login To' : 'Create'} Your Account',
        style: TextStyle(
          fontFamily: 'Optician',
          fontSize: 34,
          fontWeight: FontWeight.w600,
        ),
      ),
      15.verticalSpace,
      CustomForm(
        isLogin: isLogin,
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        obscureText: obscureText,
        emailController: emailController,
        passwordController: passwordController,
        nameController: nameController,
        phoneController: phoneController,
      ),
      20.verticalSpace,
      ElevatedButton(
        onPressed: authState.maybeWhen(
          loading: () => null,
          orElse: () => _submit,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: AppTheme.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(widget.size.width, 50),
        ),
        child: Text(
          authState.maybeWhen(
            loading: () => 'Submitting...',
            orElse: () => isLogin ? 'Login' : 'Signup',
          ),
          style: TextStyle(
            fontFamily: 'Optician',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      if (isLogin)
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(ResetPasswordPage.routeName);
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontFamily: 'Optician',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.purple,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      20.verticalSpace,
      Row(
        children: [
          const Expanded(child: Divider(color: Colors.black45, thickness: 1)),
          10.horizontalSpace,
          Text(
            'or',
            style: TextStyle(
              fontFamily: 'Optician',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black45,
            ),
          ),
          10.horizontalSpace,
          const Expanded(child: Divider(color: Colors.black45, thickness: 1)),
        ],
      ),
      20.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontFamily: 'Optician',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black45,
            ),
          ),
          5.horizontalSpace,
          GestureDetector(
            onTap: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(
              isLogin ? 'Sign Up' : 'Login',
              style: TextStyle(
                fontFamily: 'Optician',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
              ),
            ),
          ),
        ],
      ),
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}


