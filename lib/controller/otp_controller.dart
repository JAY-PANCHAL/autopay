import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class OtpController extends GetxController {
  // Use a single controller for the entire Pinput widget
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  // Reactive variable to store the entered OTP
  RxString currentOtp = ''.obs;

  @override
  void onClose() {
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // Handle the OTP submission logic
  void verifyOtp() {

    Get.toNamed(Routes.homeScreen);
    // Check if the OTP is exactly 4 digits long
    if (currentOtp.value.length == 4) {
      // Logic for OTP verification goes here (e.g., API call)
      Get.snackbar('Success', 'OTP ${currentOtp.value} Submitted!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      // Example navigation: Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar('Error', 'Please enter the complete 4-digit OTP.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}