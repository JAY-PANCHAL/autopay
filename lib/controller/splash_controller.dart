import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:permission_handler/permission_handler.dart';

import '../common/service_locator.dart';
import '../common/utils/dimensions.dart';
import '../common/utils/storage_service.dart';
import '../common/utils/utility.dart';
import '../network/api/smart_track_repository.dart';
import '../routes/app_pages.dart';
import 'base_controller.dart';


class SplashController extends BaseController {
  final repo = getIt.get<SmartTrackRepository>();
  final StorageService storageService = StorageService();
  var version = "".obs;

  @override
  Future<void> onInit() async {
    splashTimer();
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
}
