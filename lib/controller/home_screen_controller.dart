import 'dart:ui';

import 'package:autopay/common/utils/image_paths.dart';
import 'package:autopay/controller/base_controller.dart';
import 'package:get/get.dart';

import '../common/utils/utility.dart';

class HomeScreenController extends BaseController {
  var isLoading = false.obs;
  var totalVehicles = 200.obs;
  var runningVehicles = 0.obs;
  var idleVehicles = 0.obs;

  var vehicleList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVehicleList();
  }

  Future<void> fetchVehicleList() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

      vehicleList.value = [
        {
          "number": "BR01JF1231",
          "status": "STOPPED since 00d 00h 09m",
          "lastUpdated": "Oct 29,2025 01:19:07 PM",
          "address":
          "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
          "color": const Color(0xFFD97706),
          "iconPath": AppIcons.car,
        },
        {
          "number": "BR01JF1232",
          "status": "STOPPED since 00d 00h 09m",
          "lastUpdated": "Oct 29,2025 01:19:07 PM",
          "address":
          "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
          "color": const Color(0xFF2563EB),
          "iconPath": AppIcons.car,
        },
      ];
    } catch (e) {
      Utils.showToast("Error loading vehicles: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
