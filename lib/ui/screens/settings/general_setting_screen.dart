// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/controller/general_setting_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class GeneralSettingScreen extends StatefulWidget {
//   @override
//   State<GeneralSettingScreen> createState() => _GeneralSettingScreenState();
// }

// class _GeneralSettingScreenState extends State<GeneralSettingScreen> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

//   final RxBool tareSwitch = false.obs;
//   // Switch state
//   final RxString selectedDisplayTime = "1".obs;

//   final RxString selectedMilkCollectionType = "Society Milk Collection".obs;
//   GeneralSettingController generalSettingController =
//       Get.put(GeneralSettingController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     generalSettingController.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Text("General Setting", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           padding: EdgeInsets.all(20.w),
//           child: FormBuilder(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildTextField("weighing_scale_from",
//                     "Weighing Scale String Slice From : ${generalSettingController.wgtSlcFrom.toString()} "),
//                 SizedBox(height: 15.h),
//                 _buildTextField("weighing_scale_till",
//                     "Weighing Scale String Slice Till : ${generalSettingController.wgtSlcTill.toString()} "),
//                 SizedBox(height: 15.h),
//                 _buildTextField("milk_analyzer_from",
//                     "Milk Analyzer String Slice From : ${generalSettingController.milkAnlSlcFrom.toString()} "),
//                 SizedBox(height: 15.h),
//                 _buildTextField("milk_analyzer_till",
//                     "Milk Analyzer String Slice Till : ${generalSettingController.milkAnlSlcTill.toString()} "),
//                 SizedBox(height: 15.h),

//                 // **Receipt Display Time Dropdown**
//                 Text("Receipt Display Time",
//                     style: TextStyle(
//                         fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 5.h),
//                 Obx(() => FormBuilderDropdown(
//                       name: "receipt_display_time",
//                       initialValue: selectedDisplayTime.value,
//                       onChanged: (value) =>
//                           selectedDisplayTime.value = value as String,
//                       items: List.generate(
//                               10, (index) => (index + 1).toString())
//                           .map((time) =>
//                               DropdownMenuItem(value: time, child: Text(time)))
//                           .toList(),
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                     )),
//                 SizedBox(height: 15.h),

//                 _buildTextField("report_payment_cycle",
//                     "Report Payment Cycle : ${generalSettingController.reportPaymentCycle.toString()} "),
//                 SizedBox(height: 15.h),

//                 // **Tare Switch**
//                 _buildSwitchField("Configuring Setting Tare", tareSwitch),
//                 SizedBox(height: 15.h),

//                 // **Milk Collection Type Dropdown**
//                 Text("Milk Collection Type",
//                     style: TextStyle(
//                         fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 5.h),
//                 FormBuilderDropdown(
//                   name: "milk_collection_type",
//                   initialValue: selectedMilkCollectionType.value,
//                   onChanged: (value) =>
//                       selectedMilkCollectionType.value = value as String,
//                   items: ["Society Milk Collection"]
//                       .map((type) =>
//                           DropdownMenuItem(value: type, child: Text(type)))
//                       .toList(),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),

//                 // **App Version**
//                 _buildAppVersionField("App Version", "1.0.0"),
//                 SizedBox(height: 20.h),

//                 // **Bottom Buttons**
//               ],
//             ),
//           ),
//         ),
//       ),
//       // bottomNavigationBar: Row(
//       //   children: [
//       //     // **Cancel Button**
//       //     Expanded(
//       //       child: ElevatedButton(
//       //         onPressed: () => Get.back(),
//       //         style: ElevatedButton.styleFrom(
//       //           backgroundColor: Colors.red,
//       //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       //         ),
//       //         child: Padding(
//       //           padding: EdgeInsets.symmetric(vertical: 16.h),
//       //           child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//       //         ),
//       //       ),
//       //     ),
//       //     // **Submit Button**
//       //     Expanded(
//       //       child: ElevatedButton(
//       //         onPressed: () {
//       //           if (_formKey.currentState!.saveAndValidate()) {
//       //             final formData = _formKey.currentState!.value;
//       //             print("Form Data: $formData");
//       //           } else {
//       //             print("Form validation failed!");
//       //           }
//       //         },
//       //         style: ElevatedButton.styleFrom(
//       //           backgroundColor: Colors.green,
//       //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       //         ),
//       //         child: Padding(
//       //           padding: EdgeInsets.symmetric(vertical: 16.h),
//       //           child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }

//   /// **Reusable Text Field Builder**
//   Widget _buildTextField(String name, String label) {
//     return FormBuilderTextField(
//       name: name,
//       enabled: false,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         labelStyle: TextStyle(color: Colors.black),
//         disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black),
//         ),
//       ),
//     );
//   }

//   /// **Switch Field with Border**
//   Widget _buildSwitchField(String label, RxBool switchValue) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 16.sp)),
//           Switch(
//             value: switchValue.value,
//             onChanged: (value) => switchValue.value = value,
//           ),
//         ],
//       ),
//     );
//   }

//   /// **App Version Styled Like a Text Field**
//   Widget _buildAppVersionField(String label, String version) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//           Text(version,
//               style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
//         ],
//       ),
//     );
//   }
// }
