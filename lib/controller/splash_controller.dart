import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:permission_handler/permission_handler.dart';

import '../common/service_locator.dart';
import '../common/utils/app_constants.dart';
import '../common/utils/dimensions.dart';
import '../common/utils/storage_service.dart';
import '../common/utils/utility.dart';
import '../network/api/smart_track_repository.dart';
import '../routes/app_pages.dart';
import 'base_controller.dart';


class SplashController extends BaseController {
  final repo = getIt.get<AutomapRepository>();
  final StorageService storageService = StorageService();
  var version = "".obs;

  @override
  Future<void> onInit() async {
    tokenApi();
    super.onInit();
  }


  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      print("✅ Storage permission granted.");
      return true;
    } else {
      print("❌ Storage permission denied.");
      return false;
    }
  }

  void splashTimer() async {
    var _duration = Duration(
      seconds: Dimensions.screenLoadTime,
    );
    // requestStoragePermission();

    Timer(_duration, () async {
      var isloggedin = await Utils.isLoggedIn();
      // Get.offNamedUntil(Routes.login, (route) => false);
      if (isloggedin) {
        Get.offNamedUntil(Routes.homeScreen, (route) => false);
      } else {
        Get.offNamedUntil(Routes.getstarted, (route) => false);
      }
    });
  }


  Future tokenApi() async {
    var params = {
      AppConstants.dbK: AppConstants.dbname,
      AppConstants.login: AppConstants.loginValue,
      AppConstants.passwordK: AppConstants.passWordValue,

    };
    print(params);
    isLoading.value = true;
    await repo.token(params).then((value) async {
      isLoading.value = false;
      if (value.data?.token!="") {
        storageService.setString(AppConstants.tokenPr, value.data?.token);
        storageService.setInt(AppConstants.userTypePr, value.data?.userType);
        storageService.setInt(AppConstants.userIDPr, value.data?.uid);
        var isloggedin = await Utils.isLoggedIn();
        // Get.offNamedUntil(Routes.login, (route) => false);
        if (isloggedin) {
          Get.offNamedUntil(Routes.homeScreen, (route) => false);
        } else {
          Get.offNamedUntil(Routes.getstarted, (route) => false);
        }
      } else {
      Utils.showToast("Something went wrong!");
      }

      }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.showToast(error.toString());
    });
  }
}
