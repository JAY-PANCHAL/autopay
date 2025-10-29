// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/fat_based_manual_rate_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// class FatBasedManualRateScreen extends StatefulWidget {
//   @override
//   State<FatBasedManualRateScreen> createState() =>
//       _FatBasedManualRateScreenState();
// }

// class _FatBasedManualRateScreenState extends State<FatBasedManualRateScreen> {
//   // final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   var istablet = Utils.checkTablet();
//   FatBasedManualRateController fatBasedManualRateController =
//       Get.put(FatBasedManualRateController());
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ModalProgressHUD(
//         color: Colors.black.withOpacity(0.6),
//         dismissible: false,
//         blur: 5,
//         progressIndicator: Utils.loader(context),
//         inAsyncCall: fatBasedManualRateController.isLoading.value,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appColor,
//             title: Text("Rate Chart", style: TextStyle(color: Colors.white)),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             padding: EdgeInsets.all(20.w),
//             child: FormBuilder(
//               key: fatBasedManualRateController.formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildRateChartSectionBuffalo(
//                     "Buffalo-Based Rate Chart",
//                     "Buff Effective Date",
//                     (value) => fatBasedManualRateController
//                         .updateBuffDate(value ?? DateTime.now()),
//                   ),
//                   SizedBox(height: 20.h),
//                   _buildRateChartSectionCow(
//                       "Cow-Based Rate Chart",
//                       "Cow Effective Date",
//                       (value) => fatBasedManualRateController
//                           .updateCowDate(value ?? DateTime.now())),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),

//           // **Bottom Buttons**
//           bottomNavigationBar: Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () => Get.back(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape:
//                         RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     fatBasedManualRateController.submitForm();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape:
//                         RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRateChartSectionBuffalo(
//       String title, String label, void Function(DateTime?)? onChanged) {
//     return Container(
//       padding: EdgeInsets.all(15.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Expanded(
//               child: Text(title,
//                   style:
//                       TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//             ),
//             Expanded(
//               child: FormBuilderDateTimePicker(
//                 name: "date",
//                 style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                 initialValue: DateTime.now(),
//                 onChanged: onChanged,
//                 inputType: InputType.date,
//                 format: DateFormat('dd/MM/yyyy'),
//                 decoration: InputDecoration(
//                   labelText: label,
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: FormBuilderValidators.required(
//                     errorText: "Date is required"),
//               ),
//             ),
//           ]),
//           SizedBox(height: 15.h),
//           _buildGradeRow(
//               "Grade 1",
//               fatBasedManualRateController.buffFromFat1,
//               fatBasedManualRateController.buffToFat1,
//               fatBasedManualRateController.buffKgFatRate1,
//               (value) => fatBasedManualRateController.updateBuffFromFat1(value),
//               (value) => fatBasedManualRateController.updateBuffToFat1(value),
//               (value) =>
//                   fatBasedManualRateController.updateBuffKgFatRate1(value)),
//           SizedBox(height: 10.h),
//           _buildGradeRow(
//               "Grade 2",
//               fatBasedManualRateController.buffFromFat2,
//               fatBasedManualRateController.buffToFat2,
//               fatBasedManualRateController.buffKgFatRate2,
//               (value) => fatBasedManualRateController.updateBuffFromFat2(value),
//               (value) => fatBasedManualRateController.updateBuffToFat2(value),
//               (value) =>
//                   fatBasedManualRateController.updateBuffKgFatRate1(value)),
//           SizedBox(height: 10.h),
//           _buildGradeRow(
//               "Grade 3",
//               fatBasedManualRateController.buffFromFat3,
//               fatBasedManualRateController.buffToFat3,
//               fatBasedManualRateController.buffKgFatRate3,
//               (value) => fatBasedManualRateController.updateBuffFromFat3(value),
//               (value) => fatBasedManualRateController.updateBuffToFat3(value),
//               (value) =>
//                   fatBasedManualRateController.updateBuffKgFatRate3(value)),
//         ],
//       ),
//     );
//   }

//   /// **Reusable Function to Create Rate Chart Sections**
//   Widget _buildRateChartSectionCow(
//       String title, String label, void Function(DateTime?)? onChanged) {
//     return Container(
//       padding: EdgeInsets.all(15.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Expanded(
//               child: Text(title,
//                   style:
//                       TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//             ),
//             Expanded(
//               child: FormBuilderDateTimePicker(
//                 name: "date",
//                 style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                 initialValue: DateTime.now(),
//                 onChanged: onChanged,
//                 inputType: InputType.date,
//                 format: DateFormat('dd/MM/yyyy'),
//                 decoration: InputDecoration(
//                   labelText: label,
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: FormBuilderValidators.required(
//                     errorText: "Date is required"),
//               ),
//             ),
//           ]),
//           SizedBox(height: 15.h),
//           _buildGradeRow(
//               "Grade 1",
//               fatBasedManualRateController.cowFromFat1,
//               fatBasedManualRateController.cowToFat1,
//               fatBasedManualRateController.cowKgFatRate1,
//               (value) => fatBasedManualRateController.updateCowFromFat1(value),
//               (value) => fatBasedManualRateController.updateCowToFat1(value),
//               (value) =>
//                   fatBasedManualRateController.updateCowKgFatRate1(value)),
//           SizedBox(height: 10.h),
//           _buildGradeRow(
//               "Grade 2",
//               fatBasedManualRateController.cowFromFat2,
//               fatBasedManualRateController.cowToFat2,
//               fatBasedManualRateController.cowKgFatRate2,
//               (value) => fatBasedManualRateController.updateCowFromFat2(value),
//               (value) => fatBasedManualRateController.updateCowToFat2(value),
//               (value) =>
//                   fatBasedManualRateController.updateCowKgFatRate2(value)),
//           SizedBox(height: 10.h),
//           _buildGradeRow(
//               "Grade 3",
//               fatBasedManualRateController.cowFromFat3,
//               fatBasedManualRateController.cowToFat3,
//               fatBasedManualRateController.cowKgFatRate3,
//               (value) => fatBasedManualRateController.updateCowFromFat3(value),
//               (value) => fatBasedManualRateController.updateCowToFat3(value),
//               (value) =>
//                   fatBasedManualRateController.updateCowKgFatRate3(value)),
//         ],
//       ),
//     );
//   }

//   /// **Row for Each Grade with 3 Input Fields**
//   Widget _buildGradeRow(
//       String grade,
//       RxString fromInitialValue,
//       RxString toInitialValue,
//       RxString kgFatRateInitialValue,
//       Function(String) fromOnChanged,
//       Function(String) toOnChanged,
//       Function(String) kgFatRateOnChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(grade,
//             style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
//         SizedBox(height: 5.h),
//         Row(
//           children: [
//             Expanded(
//                 child: _buildTextField("${grade.toLowerCase()}_from_fat",
//                     "From Fat", fromInitialValue, fromOnChanged)),
//             SizedBox(width: 10.w),
//             Expanded(
//                 child: _buildTextField("${grade.toLowerCase()}_to_fat",
//                     "To Fat", toInitialValue, toOnChanged)),
//             SizedBox(width: 10.w),
//             Expanded(
//                 child: _buildTextField("${grade.toLowerCase()}_kg_fat_rate",
//                     "KG Fat Rate", kgFatRateInitialValue, kgFatRateOnChanged)),
//           ],
//         ),
//       ],
//     );
//   }

//   /// **Reusable Text Field**
//   Widget _buildTextField(
//     String name,
//     String label,
//     RxString value,
//     Function(String) onChanged,
//   ) {
//     return FormBuilderTextField(
//       name: name,
//       initialValue: value.value,
//       onChanged: (newValue) => onChanged(newValue ?? ""),
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       keyboardType: TextInputType.number,
//       validator:
//           FormBuilderValidators.required(errorText: "$label is required"),
//     );
//   }
// }
