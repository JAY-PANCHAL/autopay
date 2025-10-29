// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/controller/rate_amount_setting_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class RateAmountSettingScreen extends StatefulWidget {
//   @override
//   State<RateAmountSettingScreen> createState() =>
//       _RateAmountSettingScreenState();
// }

// class _RateAmountSettingScreenState extends State<RateAmountSettingScreen> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   RateAmountSettingController rateAmountSettingController =
//       Get.put(RateAmountSettingController());

//   // Variables to enable/disable dropdowns
//   final RxBool isPaymentTypeEnabled = true.obs;

//   final RxBool isPaymentCalculationEnabled = true.obs;

//   // Switch values
//   final RxBool printKgFatRate = false.obs;

//   final RxBool printSnfFatRate = false.obs;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     rateAmountSettingController.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title:
//             Text("Rate/Amount Setting", style: TextStyle(color: Colors.white)),
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
//                 // **Payment Type Dropdown**
//                 _buildDropdown(
//                     "payment_type",
//                     "Payment Type",
//                     rateAmountSettingController.paymentTypeList.value,
//                     isPaymentTypeEnabled),
//                 SizedBox(height: 15.h),
//                 // **Payment Calculation On Dropdown**
//                 _buildDropdown(
//                     "payment_calculation_on",
//                     "Payment Calculation On",
//                     rateAmountSettingController.paymentCalculationOnList.value,
//                     isPaymentCalculationEnabled),
//                 SizedBox(height: 15.h),
//                 // **Commission & Grade Factor Fields**
//                 _buildTextField(
//                     "buffalo_commission_rate",
//                     "Buffalo Commission Rate",
//                     "${rateAmountSettingController.buffCommissionRate.value}"),
//                 SizedBox(height: 15.h),
//                 _buildTextField("cow_commission_rate", "Cow Commission Rate",
//                     "${rateAmountSettingController.cowCommissionRate.value}"),
//                 SizedBox(height: 15.h),
//                 _buildTextField("cow_grade_1_factor", "Cow Grade 1 Factor",
//                     " ${rateAmountSettingController.cowGrade1Factor.value}"),
//                 SizedBox(height: 15.h),
//                 _buildTextField("cow_grade_2_factor", "Cow Grade 2 Factor",
//                     " ${rateAmountSettingController.cowGrade2Factor.value}"),
//                 SizedBox(height: 15.h),
//                 _buildTextField("cow_grade_3_factor", "Cow Grade 3 Factor",
//                     " ${rateAmountSettingController.cowGrade3Factor.value}"),
//                 SizedBox(height: 15.h),
//                 // **Switches for Print KG & SNF Fat Rate**
//                 _buildSwitch(
//                     "print_kg_fat_rate", "Print KG Fat Rate", printKgFatRate),
//                 SizedBox(height: 15.h),
//                 _buildSwitch("print_snf_fat_rate", "Print SNF Fat Rate",
//                     printSnfFatRate),
//                 SizedBox(height: 15.h),

//                 // **Fat Liter Factor Field**
//                 _buildTextField("fat_liter_factor", "Fat Liter Factor",
//                     " ${rateAmountSettingController.fatLiterFactor.value}"),
//                 SizedBox(height: 15.h),
//                 // Incentive Field
//                 _buildTextFieldWithIcon(
//                     "incentive",
//                     "Incentive : ${rateAmountSettingController.incentive.value}",
//                     Icons.currency_rupee),
//                 SizedBox(height: 15.h),

//                 // Incentive Min Fat Field
//                 _buildTextFieldWithIcon(
//                     "incentive_min_fat",
//                     "Incentive Min Fat : ${rateAmountSettingController.incentiveMinFat.value}",
//                     Icons.currency_rupee),
//                 SizedBox(height: 20.h),

//                 SizedBox(height: 20.h),
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

//   /// **Dropdown Builder with Enable/Disable Feature**
//   Widget _buildDropdown(
//       String name, String label, List<String> items, RxBool isEnabled) {
//     return Obx(() => FormBuilderDropdown(
//           name: name,
//           decoration: InputDecoration(
//             labelText: label,
//             border: OutlineInputBorder(),
//           ),
//           enabled: isEnabled.value,
//           items: items
//               .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//               .toList(),
//         ));
//   }

//   /// **Switch Builder with Rounded Border**
//   Widget _buildSwitch(String name, String label, RxBool value) {
//     return Obx(() => Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(label, style: TextStyle(fontSize: 16.sp)),
//               Switch(
//                 value: value.value,
//                 onChanged: (newValue) => value.value = newValue,
//               ),
//             ],
//           ),
//         ));
//   }

//   /// **Text Field Builder**
//   // Widget _buildTextField(String name, String label) {
//   //   return FormBuilderTextField(
//   //     name: name,
//   //     enabled: false,
//   //     decoration: InputDecoration(
//   //       labelText: label,
//   //       border: OutlineInputBorder(),
//   //     ),
//   //   );
//   // }
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

//   /// **Text Field with Rupee Icon**
//   Widget _buildTextFieldWithIcon(String name, String label, IconData icon) {
//     return FormBuilderTextField(
//       name: name,
//       enabled: false,
//       decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(icon),
//           labelStyle: TextStyle(color: Colors.black),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           )),
//     );
//   }
// }
