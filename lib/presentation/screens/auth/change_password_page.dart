import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/providers/auth/change_password/change_password_provider.dart';
import 'package:well_task_app/presentation/providers/user/user_provider.dart';
import 'package:well_task_app/presentation/screens/auth/widgets/custom_form_field.dart';

import '../../../data/models/custom_error_model.dart';
import '../../../utils/config/show_confirm_dialog.dart';
import '../../../utils/constants/app_theme.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  static const String routeSettings = '/ChangePasswordPage';
  static const String routeName = 'ChangePasswordPage';
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool obscureCurPswd = true;
  bool obscureNewPswd = true;
  bool obscureConfirmPswd = true;

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(changePasswordProvider, (previous, next) {
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
            message: 'Password changed successfully. Please log in again.',
            showNO: false,
          );
        },
      );
    });

    ref.listen(userProvider, (previous, next) {
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
      );
    });

    final changePasswordState = ref.watch(changePasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Change Password')),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpace,
                  CustomFormfields(
                    obscureText: obscureCurPswd,
                    hintText: 'Enter your Current Password',
                    prefixIcon: Icons.lock,
                    label: 'Current Password',
                    controller: _currentPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureCurPswd
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureCurPswd = !obscureCurPswd;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  CustomFormfields(
                    obscureText: obscureNewPswd,
                    hintText: 'Enter your New Password',
                    prefixIcon: Icons.lock,
                    label: 'New Password',
                    controller: _newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureNewPswd
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureNewPswd = !obscureNewPswd;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  CustomFormfields(
                    obscureText: obscureConfirmPswd,
                    hintText: 'Confirm New Password',
                    prefixIcon: Icons.lock,
                    label: 'Confirm New Password',
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPswd
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPswd = !obscureConfirmPswd;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value.trim() != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  40.verticalSpace,
                  ElevatedButton(
                    onPressed: changePasswordState.maybeWhen(
                      loading: () => null,
                      orElse: () {
                        return () {
                          if (_formKey.currentState!.validate()) {
                            final email = ref
                                .read(userProvider)
                                .whenData((user) => user.email.trim());
                            ref
                                .read(changePasswordProvider.notifier)
                                .changePassword(
                                  email: email.value!,
                                  currentPassword:
                                      _currentPasswordController.text.trim(),
                                  newPassword:
                                      _newPasswordController.text.trim(),
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
                      changePasswordState.maybeWhen(
                        loading: () => 'Submitting...',
                        orElse: () => 'Change Password',
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
