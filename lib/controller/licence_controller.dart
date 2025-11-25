import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class LicenseController extends GetxController {
  // selected dates
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  final dateFormat = DateFormat('dd-MM-yyyy');

  // UI text controller for displaying formatted date
  final fromDateText = TextEditingController();
  final endDateText = TextEditingController();

  // Function to pick date
  Future<void> selectDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isFrom) {
        fromDate.value = picked;
        fromDateText.text = dateFormat.format(picked);
      } else {
        endDate.value = picked;
        endDateText.text = dateFormat.format(picked);
      }
    }
  }

  // Search Logic
  void searchLicenses() {
    if (fromDate.value == null || endDate.value == null) {
      Get.snackbar("Error", "Please select both dates");
      return;
    }

    if (endDate.value!.isBefore(fromDate.value!)) {
      Get.snackbar("Error", "End date cannot be earlier than start date");
      return;
    }

    // Your API call / DB filter logic
    Get.snackbar(
      "Searching",
      "Filtering licenses from ${fromDateText.text} to ${endDateText.text}",
    );
  }

  // navigate to add license page
  void goToAddLicenses() {
    Get.toNamed("/addLicenses");
  }
}
