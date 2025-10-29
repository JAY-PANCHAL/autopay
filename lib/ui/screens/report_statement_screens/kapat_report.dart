// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/kapat_report_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class KapatReportScreen extends StatefulWidget {
//   @override
//   _KapatReportScreenState createState() => _KapatReportScreenState();
// }

// class _KapatReportScreenState extends State<KapatReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   KapatReportController kapatReportController =
//       Get.put(KapatReportController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Kapat Report",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             return Visibility(
//               visible: kapatReportController.mDeductionEntry.isNotEmpty,
//               child: GestureDetector(
//                 onTap: () {
//                   ExcelService.exportKapatReportToDownloadsFolder(
//                     kapatReportController.mDeductionEntry,
//                     DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                     "KapatReport",
//                   );
//                 },
//                 child: Icon(Icons.share),
//               ),
//             );
//           }),
//           Utils.addHGap(20),
//         ],

//       ),
//       body: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: kapatReportController.formKey,
//             child: Column(
//               children: [
//                 // Start Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) =>
//                       kapatReportController.updateDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "Start Date",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Start Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 _buildTextField("enddate", "End Date",
//                     kapatReportController.displayEndDate, false),
//                 // Utils.addGap(istablet ? 16 : 15),
//                 // FormBuilderTextField(
//                 //   readOnly: true,
//                 //   name: "textField",
//                 //   style: TextStyle(
//                 //     fontSize: istablet ? 9.sp : 16.sp,
//                 //   ),
//                 //   // initialValue: kapatReportController.selectedEndDate.value,
//                 //   decoration: InputDecoration(
//                 //     labelText: "End Date",
//                 //     hintText: kapatReportController.displayEndDate.value,
//                 //     border: OutlineInputBorder(),
//                 //     suffixIcon: Icon(Icons.calendar_today),
//                 //   ),
//                 // ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 kapatReportController.mDeductionEntry.isEmpty
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
//                 kapatReportController.submitForm();
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
//       itemCount: kapatReportController.mDeductionEntry.value.length,
//       itemBuilder: (context, index) {
//         final file = kapatReportController.mDeductionEntry.value[index];
//         return InkWell(
//           onTap: () {},
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//             elevation: 3,
//             child: ListTile(
//               contentPadding: EdgeInsets.all(10.w),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("SR No: ${index + 1}",
//                       style: TextStyle(
//                           fontSize: 14.sp, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5.h),
//                   Text("Member Code: ${file.memberCode ?? ""}"),
//                   Text("voucher Date: ${file.voucherDate ?? ""}"),
//                   Text("Deduction Type: ${file.deductionType ?? ""}"),
//                   Text("Qty: ${file.qty?.toString() ?? ""}"),
//                   Text("Rate: ${file.rate?.toString() ?? ""}"),
//                   Text("Amount: ${file.amount?.toString() ?? ""}"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
