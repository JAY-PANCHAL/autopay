import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/app_constants.dart';
import '../common/utils/utility.dart';

class SignupDistributorController extends BaseController {
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


  Future<void> signupDistributorApiCall({
    required String referralCode,
  }) async {
    final params = {
      "user_type": "distributor",
      "firstname": firstNameController.text.trim(),
      "lastname": lastNameController.text.trim(),
      "user_id_custom": userIdController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "confirm_password": passwordController.text.trim(),
      "mobile": mobileController.text.trim(),
      "phone": whatsappController.text.trim(),
      "city": cityController.text.trim(),
      "zip_code": pinController.text.trim(),
      "district": districtController.text.trim(),
      "po": poController.text.trim(),
      "state_id": stateController.text.trim(), // if int → parseInt
      "country_id": "", // if required later
      "image_1920": "", // multipart later if needed
      "name": "${firstNameController.text} ${lastNameController.text}",
      "referral_code": referralCode,
    };

    isLoading.value = true;


    var token= storageService.getString(AppConstants.tokenPr);


      await repo.signupDistributor(params,token).then((value) async {
        isLoading.value = false;
        if (value.success == 1 && value.data != null) {
          // ✅ Success case
          Utils.showToast(value.data!.message ?? "Signup successful");



        } else {
          // ❌ API responded but failed
          Utils.showToast(
            value.data?.message ?? "Signup failed. Please try again.",
          );
        }
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Utils.showToast(error.toString());
      });

  }
}
