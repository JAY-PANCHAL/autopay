// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class BankPaymentScreen extends StatefulWidget {
//   @override
//   _BankPaymentScreenState createState() => _BankPaymentScreenState();
// }

// class _BankPaymentScreenState extends State<BankPaymentScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   var bankCode = "".obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Bank Payment",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Start Date
//               FormBuilderDateTimePicker(
//                 name: "date",
//                 style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                 initialValue: DateTime.now(),
//                 inputType: InputType.date,
//                 format: DateFormat('dd/MM/yyyy'),
//                 decoration: InputDecoration(
//                   labelText: "Start Date",
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: FormBuilderValidators.required(
//                     errorText: "Start Date is required"),
//               ),
//               Utils.addGap(istablet ? 16 : 15),
//               // End Date
//               FormBuilderDateTimePicker(
//                 name: "date",
//                 style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                 initialValue: DateTime.now(),
//                 inputType: InputType.date,
//                 format: DateFormat('dd/MM/yyyy'),
//                 decoration: InputDecoration(
//                   labelText: "End Date",
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: FormBuilderValidators.required(
//                     errorText: "End Date is required"),
//               ),
//               Utils.addGap(istablet ? 16 : 15),
//               _buildTextField(
//                   "bankCode", "Bank Code", bankCode, "Enter Bank Code",
//                   isRequired: true, isNumeric: true),
//               Utils.addGap(istablet ? 16 : 25),
//               ElevatedButton(
//                 onPressed: () {
//                   Utils.showToast("No Report Available To Generate");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.appColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Generate Report",
//                       style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Row(
//         children: [
//           // Cancel Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//           // Start Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.saveAndValidate()) {
//                   final formData = _formKey.currentState!.value;
//                   print("Form Data: $formData");

//                   // Get.toNamed(Routes.milkCollectionEntryScreen);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//       String name, String label, RxString controllerVar, String hintText,
//       {bool isRequired = false, bool isNumeric = false}) {
//     return FormBuilderTextField(
//       name: name,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         hintText: hintText,
//       ),
//       onChanged: (value) => controllerVar.value = value ?? "",
//       keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//       validator: isRequired
//           ? FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: "$label is required"),
//               if (isNumeric)
//                 FormBuilderValidators.numeric(
//                     errorText: "$label must be a number"),
//             ])
//           : null,
//     );
//   }
// }
