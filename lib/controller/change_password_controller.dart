import 'package:flutter/material.dart';

import '../common/utils/color_constants.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  // Observables for managing password visibility for each field
  var oldPasswordVisible = false.obs;
  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;

  // Controllers for input values
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Placeholder for your API call
  Future<void> changePasswordApiCall() async {
    if (!formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }

    // Show loading or progress indicator (using GetX snackbar/dialog for example)
    Get.back(); // Close the dialog immediately after submission (adjust as needed)

    // --- YOUR API CALL LOGIC GOES HERE ---
    String oldPwd = oldPasswordController.text;
    String newPwd = newPasswordController.text;
    String confirmPwd = confirmPasswordController.text;

    debugPrint('Attempting to change password...');
    debugPrint('Old: $oldPwd, New: $newPwd, Confirm: $confirmPwd');

    // Replace with actual API integration:
    await Future.delayed(const Duration(seconds: 2));

    // Example feedback
    Get.snackbar("Success", "Password changed successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green, colorText: AppColors.white);
    // ------------------------------------
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
