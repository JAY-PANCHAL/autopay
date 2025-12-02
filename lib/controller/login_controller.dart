import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../common/utils/app_constants.dart';
import '../common/utils/utility.dart';
import '../routes/app_pages.dart';
import 'base_controller.dart';

class LoginController extends BaseController {
  String deviceType = "";
  var isObscure = false.obs;
  var accepted = false.obs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var otpValue = "".obs;
  final mobileController = TextEditingController();
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
  @override
  Future<void> onInit() async {
    // NotificationHelper().requestStoragePermission();
    // TODO: implement onInit
    super.onInit();
  }

  validate(BuildContext context) async {
    Get.focusScope?.unfocus();
    Get.toNamed(Routes.otpVerification);

    if (userNameController.text.isEmpty) {
      Utils.showToast(AppConstants.errorUsername);
    } else if (passwordController.text.isEmpty) {
      Utils.showToast(AppConstants.errorPassword);
    } else {

    //  loginApiCall();
    }
  }

  Future<String?> getDeviceVersion() async {
    String version =
        await PackageInfo.fromPlatform().then((value) => value.version);
    return version;
  }

/*
  Future loginApiCall() async {
    var params = {
      AppConstants.userNameK: userNameController.text,
      AppConstants.passwordK: passwordController.text,
    };
    print(params);
    isLoading.value = true;
    await repo.login(params).then((value) async {
      isLoading.value = false;
     */
/* if ((value.data?.length ?? 0) > 0) {
        storageService.setString(AppConstants.tokenPr, value.data?[0].token);
        storageService.setBool(AppConstants.isLoginPref, true);
        storageService.setInt(AppConstants.userCodePr, value.data?[0].userCode);
        storageService.setInt(
            AppConstants.sessionCodePr, value.data?[0].sessioncode);
        Get.offAllNamed(Routes.homeScreen);
      } else {
        Utils.showToast(value.data?[0].message ?? "");
      }*//*

    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.showToast(error.toString());
    });
  }
*/
}
