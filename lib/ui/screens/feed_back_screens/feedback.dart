/*
import 'package:aasaan_flutter/common/utils/color_constants.dart';
import 'package:aasaan_flutter/common/utils/utility.dart';
import 'package:aasaan_flutter/controller/feedBack_controller.dart';
import 'package:aasaan_flutter/controller/union_truck_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends Statel0essWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final FeedbackController controller = Get.put(FeedbackController());
  var istablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Utils.normalText("FeedBack",
            size: istablet ? 3.sp : 15.sp, color: Colors.white),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // 👈 Prevents keyboard overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.addGap(istablet ? 10 : 16),
              // **Form Inputs**
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Utils.addGap(istablet ? 14 : 10),
                    _buildDropDownField([
                      "SocietyPlant",
                      "AkashGanga",
                    ], name: "feedback for", labelText: "FeedBack For"),
                    Utils.addGap(istablet ? 14 : 12),
                    _buildDropDownField(
                        ["Query", "FeedBack", "Complain", "Information"],
                        name: "type", labelText: "Type"),
                    Utils.addGap(istablet ? 14 : 12),
                    _buildDropDownField(["High", "Medium", "Low"],
                        name: "severity", labelText: "Severity"),
                    Utils.addGap(istablet ? 14 : 12),
                    _buildTextField("details", "Details", true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          // **Cancel Button**
          Expanded(
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
              ),
            ),
          ),

          // **Submit Button**
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  final formData = _formKey.currentState!.value;
                  print("Form Data: $formData");

                  // Handle form submission logic here
                  controller.submitForm();
                } else {
                  print("Form validation failed!");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Builds the Animal Selection UI**
  Widget _buildAnimalOption(String animal) {
    final UnionTruckController controller = Get.find();
    return GestureDetector(
      onTap: () => controller.updateAnimal(animal),
      child: Obx(() => Container(
            width: istablet ? 180 : 120,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: controller.selectedAnimal.value == animal
                  ? AppColors.appColor
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                animal,
                style: TextStyle(
                  fontSize: 18,
                  color: controller.selectedAnimal.value == animal
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          )),
    );
  }

  /// **Builds a text field with validation**
  Widget _buildTextField(String name, String label, bool isRequired) {
    return FormBuilderTextField(
      style: TextStyle(fontSize: istablet ? 12.sp : 16.sp, color: Colors.black),
      name: name,
      validator: isRequired
          ? FormBuilderValidators.required(errorText: "This field is required")
          : null,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }

  /// **Builds a Date Field**
  Widget _buildDateField() {
    return FormBuilderDateTimePicker(
      name: "date",
      style: TextStyle(fontSize: istablet ? 12.sp : 16.sp),
      initialValue: DateTime.now(),
      inputType: InputType.date,
      format: DateFormat('dd/MM/yyyy'),
      decoration: InputDecoration(
        labelText: "Date Selection",
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      validator: FormBuilderValidators.required(errorText: "Date is required"),
    );
  }

  /// **Builds a DropDown Field**
  Widget _buildDropDownField(List<String> items,
      {required String name, required String labelText}) {
    return FormBuilderDropdown(
      name: name,
      style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
      initialValue: items[0],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: istablet ? 12.sp : 16.sp,
        ),
        border: OutlineInputBorder(),
      ),
      items: items
          .map((session) =>
              DropdownMenuItem(value: session, child: Text(session)))
          .toList(),
      validator:
          FormBuilderValidators.required(errorText: "Session is required"),
    );
  }
}
//
*/
