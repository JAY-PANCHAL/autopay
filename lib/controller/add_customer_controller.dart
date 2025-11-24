import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddCustomerController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  // password visibility
  final obscurePassword = true.obs;

  // Dropdown values are stored in RxnString (nullable)
  final speedUnit = RxnString();
  final distanceUnit = RxnString();
  final altitudeUnit = RxnString();
  final volumeUnit = RxnString();
  final timeZone = RxnString();

  // Options for dropdowns
  final List<String> speedUnitOptions = ['Km/h', 'm/s', 'mph'];
  final List<String> distanceUnitOptions = ['Km', 'm', 'Miles'];
  final List<String> altitudeUnitOptions = ['Meters', 'Feet'];
  final List<String> volumeUnitOptions = ['Liters', 'Gallons'];
  final List<String> timeZoneOptions = ['GMT+5:30', 'GMT+1', 'GMT-4'];

  /// Runs when user taps Add Customers
  void submit() {
    final valid = formKey.currentState?.saveAndValidate() ?? false;
    if (!valid) {
      Get.snackbar('Invalid', 'Please correct the fields highlighted in red',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final formData = formKey.currentState!.value;
    // TODO: replace with API call or repository logic
    print('Form submitted: $formData');

    Get.snackbar('Success', 'Customer added successfully',
        snackPosition: SnackPosition.BOTTOM);
  }
}
