import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../controller/change_password_controller.dart';


// --- Controller for Dialog State ---

// --- Method to Show the Dialog ---
void showChangePasswordDialog(BuildContext context) {
  // Use Get.put to create and manage the controller instance
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  Get.dialog(
    Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      // Use a custom content widget to build the dialog body
      child: _ChangePasswordDialogContent(controller: controller),
    ),
    // Ensure the controller is disposed when the dialog is closed
    barrierDismissible: false,
  ).whenComplete(() => Get.delete<ChangePasswordController>());
}

// --- Dialog Content Widget ---
class _ChangePasswordDialogContent extends StatelessWidget {
  final ChangePasswordController controller;

  const _ChangePasswordDialogContent({required this.controller});
  void safeCloseDialog(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
     /* if (Get.isDialogOpen ?? false) */ Navigator.of(context).pop();;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      safeCloseDialog(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: AppColors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              // Title
              Text(
                "Change Password",
                style: Styles.headlineTextStyle(size: 20.sp, weight: FontWeight.w800),
              ),
              SizedBox(height: 25.h),

              // Old Password Field
              _buildPasswordField(
                label: "Old Password*",
                hint: "********",
                controller: controller.oldPasswordController,
                isVisible: controller.oldPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // New Password Field
              _buildPasswordField(
                label: "New Password",
                hint: "********",
                controller: controller.newPasswordController,
                isVisible: controller.newPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Confirm Password Field
              _buildPasswordField(
                label: "Conform Password*", // Corrected to Confirm Password*
                hint: "********",
                controller: controller.confirmPasswordController,
                isVisible: controller.confirmPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password.';
                  }
                  if (value != controller.newPasswordController.text) {
                    return 'Passwords do not match.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.h),

              // Change Password Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: controller.changePasswordApiCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for a password input field with show/hide functionality
  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required RxBool isVisible,
    required FormFieldValidator<String> validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (e.g., Old Password*)
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),

        // Text Field with Obx for visibility
        Obx(
              () => TextFormField(
            controller: controller,
            validator: validator,
            obscureText: !isVisible.value,
            style: TextStyle(fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5),
              ),
              // Show/Hide Password Toggle
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible.value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 20.sp,
                ),
                onPressed: () => isVisible.toggle(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}