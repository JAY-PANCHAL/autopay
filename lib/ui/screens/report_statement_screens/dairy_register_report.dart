// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/dairy_register_report_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class DairyRegisterReportScreen extends StatefulWidget {
//   @override
//   _DailyRegisterReportScreenState createState() =>
//       _DailyRegisterReportScreenState();
// }

// class _DailyRegisterReportScreenState extends State<DairyRegisterReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   DairyRegisterReportController dairyRegisterReportController =
//       Get.put(DairyRegisterReportController());
//   final dfRate = NumberFormat("#.00");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Dairy Register Report",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             return Visibility(
//               visible: dairyRegisterReportController.moDairyRegister.isNotEmpty,
//               child: GestureDetector(
//                 onTap: () {
//                   ExcelService.exportDairyRegisterToDownloadsFolder(
//                     dairyRegisterReportController.moDairyRegister,
//                     DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                     "DairyRegister",
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
//             key: dairyRegisterReportController.formKey,
//             child: Column(
//               children: [
//                 // Start Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => dairyRegisterReportController
//                       .updateStartDate(value ?? DateTime.now()),
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
//                 // End Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => dairyRegisterReportController
//                       .updateEndDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "End Date",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "End Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 dairyRegisterReportController.moDairyRegister.isEmpty
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
//                 dairyRegisterReportController.submitForm();
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

//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: dairyRegisterReportController.moDairyRegister.value.length,
//       itemBuilder: (context, index) {
//         final file = dairyRegisterReportController.moDairyRegister.value[index];
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
//                   Text("Date: ${file.entryDate}",
//                       style: TextStyle(
//                           fontSize: 14.sp, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5.h),
//                   Text("Cattle Type: ${file.category ?? ""}"),
//                   Text("Session: ${file.session ?? ""}"),
//                   // Text("Society Pur: ${file.session ?? ""}"),
//                   Text(
//                       "Member Count: ${file.purchaseMilkMembers?.toString() ?? ""}"),
//                   Text("Liters: ${file.purchaseMilkWeight?.toString() ?? ""}"),
//                   Text("Fat: ${file.purchaseMilkFat?.toString() ?? ""}"),
//                   // Text("Rate: ${file.localRate?.toString() ?? ""}"),
//                   Text("Amount: ${file.purchaseMilkAmount?.toString() ?? ""}"),
//                   // Text("Local Sale: ${file.localAmount?.toString() ?? ""}"),
//                   Text(
//                       "Local Sale Liter: ${file.localWeight?.toString() ?? ""}"),
//                   Text(
//                       "Local Sale Amount: ${file.localAmount?.toString() ?? ""}"),
//                   Text(
//                       "Union Weight: ${file.saleGood1Weight?.toString() ?? ""}"),
//                   Text("Union Fat: ${file.saleGood1Fat?.toString() ?? ""}"),
//                   Text("Union SNF: ${file.saleGood1SNF?.toString() ?? ""}"),
//                   Text("Union Rate: ${file.saleGood1Rate?.toString() ?? ""}"),
//                   Text(
//                       "Union Amount: ${file.saleGood1Amount?.toString() ?? ""}"),
//                   // Text("Profit/Loss: ${file.localAmount?.toString() ?? ""}"),
//                   Text(
//                       "Profit Weight: ${dfRate.format(((file.saleGood1Weight ?? 0.0) - (file.purchaseMilkWeight ?? 0.0) - (file.localWeight ?? 0.0)).abs())}"),
//                   Text(
//                       "Profit Amount: ${dfRate.format(((file.saleGood1Amount ?? 0.0) - (file.purchaseMilkAmount ?? 0.0) - (file.localAmount ?? 0.0)).abs())}"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
