// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/session_report_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class SessionReportScreen extends StatefulWidget {
//   @override
//   _SessionReportScreenState createState() => _SessionReportScreenState();
// }

// class _SessionReportScreenState extends State<SessionReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   SessionReportController sessionReportController =
//       Get.put(SessionReportController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setSession();
//     });
//   }

//   void setSession() {
//     DateTime now = DateTime.now();

//     // Set 4:00 PM as the threshold time
//     DateTime eveningStartTime =
//         DateTime(now.year, now.month, now.day, 16, 0); // 4:00 PM

//     if (now.isBefore(eveningStartTime)) {
//       sessionReportController.formKey.currentState?.fields['session']?.didChange("Morning");
//     } else {
//       sessionReportController.formKey.currentState?.fields['session']?.didChange("Evening");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Session Report",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             return Visibility(
//               visible: sessionReportController.mMilkCollectionCow.value.length >
//                       0 ||
//                   sessionReportController.mMilkCollectionBuff.value.length > 0,
//               child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportSessionReportToExcel(
//                         sessionReportController.mMilkCollectionCow.value,
//                         sessionReportController.mMilkCollectionBuff.value, {
//                       'Buff Litter': sessionReportController.BuffTotLiter.value,
//                       'Buff Avg Fat': sessionReportController.BuffAvgFat.value,
//                       'Buff SNF Fat': sessionReportController.BuffSnfFat.value,
//                       'Buff Total Amt':
//                           sessionReportController.BuffTotAmount.value,
//                     }, {
//                       'Cow Litter': sessionReportController.cowTotLiter.value,
//                       'Cow Avg Fat': sessionReportController.cowAvgFat.value,
//                       'Cow SNF Fat': sessionReportController.cowSnfFat.value,
//                       'Cow Total Amt':
//                           sessionReportController.cowTotAmount.value,
//                     });
//                   },
//                   child: Icon(Icons.share)),
//             );
//           }),
//           Utils.addHGap(20)
//         ],
//       ),
//       body: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: sessionReportController.formKey,
//             child: Column(
//               children: [
//                 // Date Selection
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => sessionReportController
//                       .updateDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "Date Selection",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 // Session Dropdown
//                 FormBuilderDropdown(
//                   name: "session",
//                   style: TextStyle(
//                     fontSize: istablet ? 9.sp : 16.sp,
//                     color: Colors.black,
//                   ),
//                   initialValue: "Morning",
//                   decoration: InputDecoration(
//                     labelText: "Session",
//                     labelStyle: TextStyle(
//                       fontSize: istablet ? 12.sp : 16.sp,
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   items: ["Morning", "Evening"]
//                       .map((session) => DropdownMenuItem(
//                       value: session, child: Text(session)))
//                       .toList(),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Session is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 // Order By Dropdown
//                 FormBuilderDropdown(
//                   name: "orderBy",
//                   style: TextStyle(
//                     fontSize: istablet ? 9.sp : 16.sp,
//                     color: Colors.black,
//                   ),
//                   onChanged: (value) =>
//                       sessionReportController.updateOrderBy(value as String),
//                   initialValue: sessionReportController.selectedOrderBy.value,
//                   decoration: InputDecoration(
//                     labelText: "Order By",
//                     labelStyle: TextStyle(
//                       fontSize: istablet ? 12.sp : 16.sp,
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   items: ["Member", "Date"]
//                       .map((session) => DropdownMenuItem(
//                           value: session, child: Text(session)))
//                       .toList(),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Order By is Required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 25),

//                 // Display Two Lists
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       buildBuffListView(),
//                       buildCowListView(),
//                     ],
//                   ),
//                 ),
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
//           // Print Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 sessionReportController.submitForm();
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

//   Widget buildBuffListView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Center(
//           child: Text(
//             "${sessionReportController.buffSession.value}",
//             style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//           ),
//         ),
//         /*  sessionReportController.mMilkCollectionBuff.isEmpty
//             ? Container()
//             : ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: sessionReportController.mMilkCollectionBuff.length,
//                 itemBuilder: (context, index) {
//                   var file = sessionReportController.mMilkCollectionBuff[index];
//                   return buildMilkItem(file);
//                 },
//               ),
// */

//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Row of titles
//                 Row(
//                   children: [
//                     _buildHeaderCell("FCD"),
//                     //_buildHeaderCell("Ct"),
//                     _buildHeaderCell("Ltr"),
//                     _buildHeaderCell("Fat"),
//                     _buildHeaderCell("SNF"),
//                     _buildHeaderCell("Rate"),

//                     _buildHeaderCell("Amt"),
//                     //_buildHeaderCell("Sync"),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // Row of values (each entry is a column)
//                 Column(
//                   children: sessionReportController.mMilkCollectionBuff.value
//                       .map((entry) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildDataCell(entry.memCode ?? ""),
//                         //    _buildDataCell(entry.cattle == "C" ? "Cow" : entry.cattle == "B" ? "Buffalo" : ""),
//                         _buildDataCell(entry.liters ?? ""),
//                         _buildDataCell(entry.fat ?? ""),
//                         _buildDataCell(entry.snf ?? ""),
//                         _buildDataCell(
//                             double.parse(entry.rate ?? "0").toStringAsFixed(2)),

//                         _buildDataCell(entry.amount ?? ""),
//                         // syncStatusIcon(entry.isSync??0),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Center(
//           child: Text(
//             "Summary (Buffalo)",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Utils.addGap(10),
//         _buildTextRow("Buff Litter : ",
//             sessionReportController.BuffTotLiter.value.toStringAsFixed(2)),
//         _buildTextRow("Buff Avg Fat : ",
//             sessionReportController.BuffAvgFat.value.toStringAsFixed(2)),
//         _buildTextRow("Buff SNF Fat : ",
//             sessionReportController.BuffSnfFat.value.toStringAsFixed(2)),
//         _buildTextRow("Buff Total Amt : ",
//             sessionReportController.BuffTotAmount.value.toStringAsFixed(2)),
//       ],
//     );
//   }

//   Widget buildCowListView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Center(
//           child: Text(
//             "${sessionReportController.cowSession.value}",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         /*      sessionReportController.mMilkCollectionCow.isEmpty
//             ? Container()
//             : ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: sessionReportController.mMilkCollectionCow.length,
//                 itemBuilder: (context, index) {
//                   var file = sessionReportController.mMilkCollectionCow[index];
//                   return buildMilkItem(file);
//                 },
//               ),*/

//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Row of titles
//                 Row(
//                   children: [
//                     _buildHeaderCell("FCD"),
//                     // _buildHeaderCell("Ct"),
//                     _buildHeaderCell("Ltr"),
//                     _buildHeaderCell("Fat"),
//                     _buildHeaderCell("SNF"),
//                     _buildHeaderCell("Rate"),
//                     _buildHeaderCell("Amt"),
//                     //  _buildHeaderCell("Sync"),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // Row of values (each entry is a column)
//                 Column(
//                   children: sessionReportController.mMilkCollectionCow.value
//                       .map((entry) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildDataCell(entry.memCode ?? ""),
//                         //    _buildDataCell(entry.cattle == "C" ? "Cow" : entry.cattle == "B" ? "Buffalo" : ""),
//                         _buildDataCell(entry.liters ?? ""),
//                         _buildDataCell(entry.fat ?? ""),
//                         _buildDataCell(entry.snf ?? ""),
//                         _buildDataCell(
//                             double.parse(entry.rate ?? "0").toStringAsFixed(2)),
//                         _buildDataCell(entry.amount ?? ""),
//                         //   syncStatusIcon(entry.isSync??0),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Center(
//           child: Text(
//             "Summary (Cow)",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Utils.addGap(10),
//         _buildTextRow("Cow Litter : ",
//             sessionReportController.cowTotLiter.value.toStringAsFixed(2)),
//         _buildTextRow("Cow Avg Fat : ",
//             sessionReportController.cowAvgFat.value.toStringAsFixed(2)),
//         _buildTextRow("Cow SNF Fat : ",
//             sessionReportController.cowSnfFat.value.toStringAsFixed(2)),
//         _buildTextRow("Cow Total Amt : ",
//             sessionReportController.cowTotAmount.value.toStringAsFixed(2)),
//       ],
//     );
//   }

//   Widget buildMilkItem(file) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//       elevation: 3,
//       child: ListTile(
//         contentPadding: EdgeInsets.all(10.w),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Cattle Type: ${file.cattle ?? ''}",
//               style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.h),
//             Text("Liters: ${file.liters ?? '0'}"),
//             Text("Fat: ${file.fat ?? '0'}"),
//             Text("SNF: ${file.snf ?? '0'}"),
//             Text("Rate: ${file.rate ?? '0'}"),
//             Text("Amount: ${file.amount ?? '0'}"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 5.sp),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(fontSize: 14.sp, color: Colors.black),
//           children: [
//             TextSpan(
//               text: title + " ",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextSpan(text: value),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderCell(String title) {
//     return Container(
//       width: 70.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildHeaderCellAction(String title) {
//     return Container(
//       width: 60.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildDataCell(String value) {
//     return Container(
//       width: 70.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(value),
//     );
//   }

//   Widget syncStatusIcon(int isSynced) {
//     return Container(
//       width: 90.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Icon(
//         isSynced == 1 ? Icons.check_circle : Icons.close,
//         color: isSynced == 1 ? Colors.green : Colors.red,
//       ),
//     );
//   }
// }
