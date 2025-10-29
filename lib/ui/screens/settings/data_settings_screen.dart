// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/controller/data_settings_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class DataSettingScreen extends StatefulWidget {
//   @override
//   State<DataSettingScreen> createState() => _DataSettingScreenState();
// }

// class _DataSettingScreenState extends State<DataSettingScreen> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   DataSettingsController dataSettingsController =
//       Get.put(DataSettingsController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dataSettingsController.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Text("Data Setting", style: TextStyle(color: Colors.white)),
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
//                 _buildSwitch("allow_zero_fat", "Allow Zero Fat",
//                     dataSettingsController.allowZeroFat),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("allow_zero_snf", "Allow Zero SNF",
//                     dataSettingsController.allowZeroSNF),
//                 SizedBox(height: 15.h),
//                 _buildTextField("FAT Decimal Points", "FAT Decimal Points",
//                     dataSettingsController.fatDecimalPoints.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField("snf_decimal_points", "SNF Decimal Points ",
//                     dataSettingsController.snfDecimalPoints.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "rejection_cow_min_fat",
//                     "Rejection Cow Minimum FAT",
//                     dataSettingsController.rejectionCowMinimumFat.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "rejection_buffalo_min_fat",
//                     "Rejection Buffalo Minimum FAT",
//                     dataSettingsController.rejectionBuffMinimumFat.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "allowed_cow_max_fat",
//                     "Allowed Cow Maximum FAT",
//                     dataSettingsController.allowedCowMaximumFat.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "allowed_buffalo_max_fat",
//                     "Allowed Buffalo Maximum FAT",
//                     dataSettingsController.allowedBuffMaximumFat.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "rejection_cow_min_snf",
//                     "Rejection Cow Minimum SNF",
//                     dataSettingsController.rejectionCowMinimumSNF.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "rejection_buffalo_min_snf",
//                     "Rejection Buffalo Minimum SNF",
//                     dataSettingsController.rejectionBuffMinimumSNF.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "allowed_cow_max_snf",
//                     "Allowed Cow Maximum SNF",
//                     dataSettingsController.allowedCowMaximumFat.value),
//                 SizedBox(height: 15.h),
//                 _buildTextField(
//                     "allowed_buffalo_max_snf",
//                     "Allowed Buffalo Maximum SNF",
//                     dataSettingsController.allowedBuffMaximumSNF.value),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("send_alert_sms", "Send Alert SMS",
//                     dataSettingsController.sendAlertSMS),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("send_alert_mail", "Send Alert Mail",
//                     dataSettingsController.sendAlertMail),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("allow_liter_manual", "Allow Liter Manual",
//                     dataSettingsController.allowLiterManual),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("allow_fat_snf_manual", "Allow FAT SNF Manual",
//                     dataSettingsController.allowFatSNFManual),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//       //
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
//       //     ), // **Submit Button**
//       //     Expanded(
//       //       child: ElevatedButton(
//       //         onPressed: () {
//       //           if (_formKey.currentState!.saveAndValidate()) {
//       //             final formData = _formKey.currentState!.value;
//       //             print("Form Data: $formData");

//       //             // Handle form submission logic here
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

//   /// **Builds a switch with a rounded border**
//   Widget _buildSwitch(String name, String label, RxBool value) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 16.sp)),
//           Switch(
//             value: value.value,
//             onChanged: (newValue) => value.value = newValue,
//           ),
//         ],
//       ),
//     );
//   }

//   /// **Builds a text field with a rounded border**
//   Widget _buildTextField(
//     String name,
//     String label,
//     String value,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 6),
//         FormBuilderTextField(
//           name: name,
//           enabled: false,
//           decoration: InputDecoration(
//             labelText: value,
//             labelStyle: TextStyle(color: Colors.black),
//             disabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
