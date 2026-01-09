import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/app_constants.dart';
import '../common/utils/utility.dart';
import '../network/model/country_model.dart';

class SignupDistributorController extends BaseController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfpasswordController = TextEditingController();

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
  var iscnfPasswordVisible = false.obs;
  var selectedCountry = Rxn<Countries>();
  var countriesList = <Countries>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  void loadCountries() async {
    final list = await Utils.getCountriesFromStorage();
    countriesList.assignAll(list);
  }

  void toggleTerms() => isTermsAccepted.value = !isTermsAccepted.value;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void togglecnfPasswordVisibility() =>
      iscnfPasswordVisible.value = !iscnfPasswordVisible.value;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (!GetUtils.isPhoneNumber(value.trim()) || value.trim().length != 10) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void submitForm(BuildContext context) {
    FocusScope.of(context).unfocus(); // hide keyboard

    if (!formKey.currentState!.validate()) {
      return; // stop if any field invalid
    }

    if (!isTermsAccepted.value) {
      Get.snackbar(
        'Error',
        'Please accept Terms and Conditions',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // ✅ Extra safety checks (optional but recommended)
    if (mobileController.text.trim().length != 10) {
      Get.snackbar(
        'Error',
        'Invalid mobile number',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (passwordController.text != cnfpasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // ✅ All validations passed → API call
    signupDistributorApiCall(referralCode: "");
  }

  @override
  void onClose() {
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

  Future<void> signupDistributorApiCall({required String referralCode}) async {
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

    var token = storageService.getString(AppConstants.tokenPr);

    await repo
        .signupDistributor(params, token)
        .then((value) async {
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
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          Utils.showToast(error.toString());
        });
  }

  Future<void> statesApiCall(countryid) async {
    isLoading.value = true;

    var token = await storageService.getString(AppConstants.tokenPr);
    var params = {"country_id": countryid};
    await repo
        .statesApiCall(params, token)
        .then((value) async {
          isLoading.value = false;
          if (value.success == 1 && value.data?.countries != null) {
            // ✅ Success case
            Utils.showToast(
              value.data!.message ?? "states fetched successfully",
            );
          } else {
            // ❌ API responded but failed
            Utils.showToast(
              value.data?.message ??
                  "states fetch failed. Please try again.",
            );
          }
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          Utils.showToast(error.toString());
        });
  }
}
