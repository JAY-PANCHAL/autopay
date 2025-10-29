// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/payment_report_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class PaymentReportScreen extends StatefulWidget {
//   @override
//   _PaymentReportScreenState createState() => _PaymentReportScreenState();
// }

// class _PaymentReportScreenState extends State<PaymentReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   PaymentReportController paymentReportController =
//       Get.put(PaymentReportController());
//   final dfRate = NumberFormat("#.00");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Payment Report",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: paymentReportController.formKey,
//             child: Column(
//               children: [
//                 // Start Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => paymentReportController
//                       .updateDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "Start Date",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 _buildTextField("paymentenddate", "End Date",
//                     paymentReportController.displayEndDate, false),
//                 Utils.addGap(istablet ? 16 : 15),
//                 paymentReportController.mMilkCollection.isEmpty
//                     ? Container()
//                     : Expanded(child: buildListView())
//               ],
//             ),
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
//                 paymentReportController.submitForm();
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
//       String name, String label, RxString value, bool isEnabled) {
//     return FormBuilderTextField(
//       name: name,
//       enabled: isEnabled,
//       textInputAction: TextInputAction.next,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       initialValue: value.value,
//       // ✅ Access .value inside Obx
//       // onChanged: (newValue) => onChanged(newValue ?? ""),
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         disabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//       ),
//       validator:
//           FormBuilderValidators.required(errorText: "$label is required"),
//     );
//   }

//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: paymentReportController.mMilkCollection.value.length,
//       itemBuilder: (context, index) {
//         final file = paymentReportController.mMilkCollection.value[index];
//         return InkWell(
//           onTap: () {},
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//             elevation: 3,
//             child: ListTile(
//                 contentPadding: EdgeInsets.all(10.w),
//                 title: file.viewType == 1
//                     ? Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Member Code: ${file.memCode}",
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold)),
//                           SizedBox(height: 5.h),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text("Cattle: ${file.cattle ?? ""}"),
//                                   const Spacer(),
//                                   Text("Liters: ${file.liters ?? ""}"),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text("Fat%: ${file.fat ?? ""}"),
//                                   const Spacer(),
//                                   Text("SNF%: ${file.snf ?? ""}"),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text("Rate: ${file.rate ?? ""}"),
//                                   const Spacer(),
//                                   Text("Amount: ${file.amount ?? ""}"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text("Deduction Entry",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                           SizedBox(height: 5.h),
//                           Text("Sub Total Amount: ${file.amount ?? ""}"),
//                           Text(
//                               "Deduction Amount: ${file.deductionAmount ?? ""}"),
//                           Text(
//                               "Net Amount: ${dfRate.format(((double.tryParse(file.amount ?? "0.0") ?? 0.0) - (double.tryParse(file.deductionAmount ?? "0.0") ?? 0.0)).abs())}"),
//                         ],
//                       )),
//           ),
//         );
//       },
//     );
//   }
// }
