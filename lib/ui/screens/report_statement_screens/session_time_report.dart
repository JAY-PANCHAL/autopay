// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/session_time_model.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';
// import '../../../network/model/member_profile.dart';
// import '../../../network/model/milkCollectionModel.dart';

// class SessionTimeReportScreen extends StatefulWidget {
//   @override
//   _SessionTimeReportScreenState createState() =>
//       _SessionTimeReportScreenState();
// }

// class _SessionTimeReportScreenState extends State<SessionTimeReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;
//   var listMembers = <MMembersProfile>[].obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;
//   var mSessionList = <MSessionTime>[].obs;
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Session Time Report",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//               return Visibility(
//                 visible: mSessionList.value.length > 0,
//                 child: GestureDetector(
//                     onTap: () {
//                       ExcelService.exportSessionTimeToDownloadsFolder(
//                           mSessionList .value,
//                           DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                           "MemberSlip");
//                     },
//                     child: Icon(Icons.share)),
//               );
//             }),
//             Utils.addHGap(20)
//           ],

//         ),
//         body: Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: _formKey,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   // Start Date
//                   _buildDateField(
//                     "start_date",
//                     "Start Date",
//                     startDate,
//                     startDateFormat,
//                   ),
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildDateField(
//                       "end_date", "End Date", endDate, endDateFormat),

//                   Utils.addGap(istablet ? 16 : 15),
//                   // Session Dropdown
//                   FormBuilderDropdown(
//                     name: "session",
//                     style: TextStyle(
//                       fontSize: istablet ? 9.sp : 16.sp,
//                       color: Colors.black,
//                     ),
//                     initialValue: "Morning",
//                     decoration: InputDecoration(
//                       labelText: "Session",
//                       labelStyle: TextStyle(
//                         fontSize: istablet ? 12.sp : 16.sp,
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     items: ["Morning", "Evening", "Both"]
//                         .map((session) => DropdownMenuItem(
//                             value: session, child: Text(session)))
//                         .toList(),
//                     validator: FormBuilderValidators.required(
//                         errorText: "Session is required"),
//                   ),
//                   Utils.addGap(istablet ? 16 : 25),
//                   mSessionList.length > 0
//                       ? ListView.builder(
//                           itemCount: mSessionList.length,
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final item = mSessionList[index];
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
//                                   _buildTextRow("Date : ", item.date ?? ""),
//                                   _buildTextRow(
//                                       "Start Time : ", item.startTime ?? ""),
//                                   _buildTextRow(
//                                       "End Time : ", "${item.endTime}"),
//                                   _buildTextRow("Total Coll. Time : ",
//                                       "${item.totalCollTime}"),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       : Container(),
//                   /* ElevatedButton(
//                       onPressed: () {
//                         Utils.showToast("No Report Available To Generate");
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.appColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16.h),
//                         child: Text("Generate Report",
//                             style: TextStyle(fontSize: 18.sp)),
//                       ),
//                     ),*/
//                 ],
//               ),
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
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     final formData = _formKey.currentState!.value;
//                     print("Form Data: $formData");
//                     String strQuery = "";
//                     String session = formData['session'];
//                     if (session.toLowerCase().contains("both")) {
//                       strQuery =
//                           "SELECT min(CollTime) as startTime, max(CollTime) as endTime, CollDate, "
//                           "time(((strftime('%s', max(CollTime)) - strftime('%s', min(CollTime)))),'unixepoch') as collTime "
//                           "FROM MilkCollection WHERE CollDate BETWEEN '$startDateFormat' AND '$endDateFormat' "
//                           "AND Locked <> '1' GROUP BY CollDate ORDER BY MemCode";
//                     } else {
//                       strQuery =
//                           "SELECT min(CollTime) as startTime, max(CollTime) as endTime, CollDate, "
//                           "time(((strftime('%s', max(CollTime)) - strftime('%s', min(CollTime)))),'unixepoch') as collTime "
//                           "FROM MilkCollection WHERE CollDate BETWEEN '$startDateFormat' AND '$endDateFormat' "
//                           "AND Locked <> '1' AND CollSession = '$session' GROUP BY CollDate ORDER BY MemCode";
//                     }

//                     mSessionList.value =
//                         await DBHelper().getMSessionTime(strQuery);
//                     print(mSessionList.value);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.appColor,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
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
// }
