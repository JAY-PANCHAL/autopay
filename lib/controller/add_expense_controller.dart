import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  Rx<File?> selectedImage = Rx<File?>(null);

  // Dropdown sample data
  final vehicleList = ["Truck 1", "Truck 2", "Pickup 3"];
  final expenseTypes = ["Fuel", "Maintenance", "Service", "Food"];
  final paymentModes = ["Cash", "UPI", "Card", "Credit"];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void submitExpense() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final formData = formKey.currentState!.value;

      print("Expense Submitted: $formData");
      print("Selected Image: ${selectedImage.value?.path}");

      // Later you can send this to API or local DB
    } else {
      print("Validation Failed");
    }
  }
}
