import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupDistributorController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  final poController = TextEditingController();
  final pinController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final mobileController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();

  var isTermsAccepted = false.obs;
  var isPasswordVisible = false.obs;

  void toggleTerms() => isTermsAccepted.value = !isTermsAccepted.value;
  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (!isTermsAccepted.value) {
        Get.snackbar('Error', 'Please accept Terms and Conditions',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      // TODO: Handle API call for sign up
      Get.snackbar('Success', 'Form submitted successfully!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    userIdController.dispose();
    passwordController.dispose();
    cityController.dispose();
    poController.dispose();
    pinController.dispose();
    districtController.dispose();
    stateController.dispose();
    mobileController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
