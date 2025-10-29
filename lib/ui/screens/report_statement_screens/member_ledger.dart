// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/milkCollectionModel.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class MemberLedgerScreen extends StatefulWidget {
//   @override
//   _MemberLedgerScreenState createState() => _MemberLedgerScreenState();
// }

// class _MemberLedgerScreenState extends State<MemberLedgerScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();

//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;
//   var milkCollectionList = <MilkCollection>[].obs;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Member Ledger",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//       return Visibility(
//       visible: milkCollectionList.value.isNotEmpty,
//       child: GestureDetector(
//       onTap: () {
//       ExcelService.exportMilkCollectionToDownloadsFolderForLedger(
//       milkCollectionList.value,
//       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//       "MemberLedger");
//       },
//       child: Icon(Icons.share)),
//       );
//       }),
//             Utils.addHGap(20)
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 16.w),
//           child: FormBuilder(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _buildDateField(
//                   "start_date",
//                   "Start Date",
//                   startDate,
//                   startDateFormat,
//                 ),
//                 SizedBox(height: 15.h),
//                 _buildDateField("end_date", "End Date", endDate, endDateFormat),
//                 SizedBox(height: 15.h),
//                 Utils.addGap(istablet ? 16 : 25),
//                 milkCollectionList.length > 0
//                     ? Flexible(
//                         child: ListView.builder(
//                           itemCount: milkCollectionList.length,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final item = milkCollectionList[index];
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     blurRadius: 5,
//                                     spreadRadius: 2,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               padding: EdgeInsets.all(12.sp),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: 4.sp, vertical: 5.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildTextRow("Date:", item.collDate ?? ""),
//                                   _buildTextRow("Cattle:", item.cattle ?? ""),
//                                   _buildTextRow(
//                                       "Session:", item.collSession ?? ""),
//                                   _buildTextRow("Liters:", item.liters ?? ""),
//                                   _buildTextRow("FAT:", item.fat ?? ""),
//                                   _buildTextRow("SNF:", item.snf ?? ""),
//                                   _buildTextRow("Amount:", "₹${item.amount}"),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : Container(),

//                 /*  ElevatedButton(
//                         onPressed: () {
//                           Utils.showToast("No Report Available To Generate");
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.appColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 16.h),
//                           child: Text("Generate Report",
//                               style: TextStyle(fontSize: 18.sp)),
//                         ),
//                       ),*/
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Row(
//           children: [
//             // Cancel Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//             // Start Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     final formData = _formKey.currentState!.value;
//                     print("Form Data: $formData");

//                     // Get.toNamed(Routes.milkCollectionEntryScreen);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
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

//   Widget _buildDateField(String name, String label, Rx<DateTime?> dateValue,
//       RxString formattedDateValue) {
//     return Obx(() => GestureDetector(
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: Get.context!,
//               initialDate: dateValue.value ?? DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );

//             if (pickedDate != null) {
//               // If this is the end date field and start date is set, validate
//               if (name == "end_date" && startDate.value != null) {
//                 if (pickedDate.isBefore(startDate.value!)) {
//                   Get.snackbar("Invalid Date",
//                       "End date cannot be earlier than the start date.",
//                       backgroundColor: Colors.red, colorText: Colors.white);
//                   return;
//                 }
//               }

//               dateValue.value = pickedDate;
//               formattedDateValue.value =
//                   DateFormat("yyyy-MM-dd").format(pickedDate);
//               displayData();
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   formattedDateValue.value.isNotEmpty
//                       ? formattedDateValue.value
//                       : label,
//                   style: TextStyle(
//                       fontSize: 16.sp,
//                       color: formattedDateValue.value.isNotEmpty
//                           ? Colors.black
//                           : Colors.black54),
//                 ),
//                 Icon(Icons.calendar_today, color: Colors.grey),
//               ],
//             ),
//           ),
//         ));
//   }

//   displayData() async {
//     String query = """
//     SELECT Code, AutoID, MemCode, CollDate, COUNT(DISTINCT CollDate) AS CollTime, COUNT(CollSession) AS CollSession, 
//            PRINTF('%.2f', SUM(KgFat) / SUM(Liters)) AS FAT, 
//            PRINTF('%.2f', SUM(Amount)) AS Amount, 
//            PRINTF('%.2f', SUM(Liters)) AS Liters, 
//            Cattle, LitersEntryType, 
//            PRINTF('%.2f', SUM(KgSnf) / SUM(Liters)) AS SNF, 
//            AVG(CLR) AS CLR, 
//            FAT_SNF_EntryType, PRINTF('%.2f', AVG(Rate)) AS Rate, 
//            Amount_Type, ReceiptPrinted, SentStatus, SentOn, UploadStatus, UploadOn, 
//            IsSync, SampleNo, VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, 
//            Locked, KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
//     FROM MilkCollection 
//     WHERE CollDate BETWEEN '$startDateFormat' AND '$endDateFormat' 
//     AND LOCKED <> '1' 
//     GROUP BY MemCode, CollDate 
//     ORDER BY MemCode, CollDate ASC
// """;

//     milkCollectionList.value = await DBHelper().getMilkCollection(query);

//     print(milkCollectionList.value);
//   }
// }
