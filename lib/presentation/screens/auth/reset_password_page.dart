import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/custom_error_model.dart';
import 'package:well_task_app/core/utils/config/show_confirm_dialog.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../providers/auth/forgot_password/forgot_password_provider.dart';
import 'widgets/custom_form_field.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  static const String routeSettings = '/ResetPasswordPage';
  static const String routeName = 'ResetPasswordPage';
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(forgotPasswordProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          final error = e as CustomErrorModel;
          showConfirmDialog(
            context: context,
            title: error.code,
            message: error.message,
            showNO: false,
          );
        },
        data: (_) {
          showConfirmDialog(
            context: context,
            title: 'Success',
            message: 'Password reset link sent to your email.',
            onYes: () {
              Navigator.of(context).pop();
            },
            showNO: false,
          );
        },
      );
    });

    final resetPasswordState = ref.watch(forgotPasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Reset Password')),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpace,
                  CustomFormfields(
                    hintText: 'Enter your email',
                    prefixIcon: Icons.lock,
                    label: 'e-mail',
                    controller: _emailController,
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
                  40.verticalSpace,
                  ElevatedButton(
                    onPressed: resetPasswordState.maybeWhen(
                      loading: () => null,
                      orElse: () {
                        return () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(forgotPasswordProvider.notifier)
                                .forgotPassword(
                                  email: _emailController.text.trim(),
                                );
                          }
                        };
                      },
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: AppTheme.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200.w, 50),
                    ),
                    child: Text(
                      resetPasswordState.maybeWhen(
                        loading: () => 'Submitting...',
                        orElse: () => 'Reset Password',
                      ),
                      style: TextStyle(
                        fontFamily: 'Optician',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


