// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';
// import '../../../db/db_helper.dart';
// import '../../../network/model/member_profile.dart';
// import '../../../network/model/milkCollectionModel.dart';

// class BonusReportScreen extends StatefulWidget {
//   @override
//   _BonusReportScreenState createState() => _BonusReportScreenState();
// }

// class _BonusReportScreenState extends State<BonusReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   var bonus = "".obs;

//   final TextEditingController fromMemberCodeController =
//       TextEditingController();
//   final TextEditingController toMemberCodeController = TextEditingController();
//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;
//   var listMembers = <MMembersProfile>[].obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;
//   var milkCollectionList = <MilkCollection>[].obs;

//   @override
//   void initState() {
//     getData();

//     super.initState();
//   }

//   getData() async {
//     listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Bonus Report",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//               return Visibility(
//                 visible: milkCollectionList.isNotEmpty,
//                 child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportBonusReportToDownloadsFolder(
//                       milkCollectionList,
//                       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                       "Bonus",
//                     );
//                   },
//                   child: Icon(Icons.share),
//                 ),
//               );
//             }),
//             Utils.addHGap(20),
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
//                   /*  SizedBox(height: 15.h),
//                     // Session Dropdown
//                     FormBuilderDropdown(
//                       name: "session",
//                       style: TextStyle(
//                         fontSize: istablet ? 9.sp : 16.sp,
//                         color: Colors.black,
//                       ),
//                       initialValue: "Morning",
//                       decoration: InputDecoration(
//                         labelText: "Session",
//                         labelStyle: TextStyle(
//                           fontSize: istablet ? 12.sp : 16.sp,
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                       items: ["Morning", "Evening"]
//                           .map((session) =>
//                               DropdownMenuItem(value: session, child: Text(session)))
//                           .toList(),
//                       validator: FormBuilderValidators.required(
//                           errorText: "Session is required"),
//                     ),*/
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildTextField(
//                       "bonus", "Bonus (in %)", bonus, "Enter Bonus (in %)",
//                       isRequired: true, isNumeric: true),
//                   Utils.addGap(istablet ? 16 : 25),

//                   milkCollectionList.length > 0
//                       ? ListView.builder(
//                           itemCount: milkCollectionList.length,
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
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
//                                   _buildTextRow("Member: ",
//                                       "${item.memCode ?? " "} ${item.memName ?? " "} "),
//                                   _buildTextRow("Days: ", item.collDate ?? ""),
//                                   _buildTextRow("Liters: ", item.liters ?? ""),
//                                   _buildTextRow("Amount: ", "₹${item.amount}"),
//                                   _buildTextRow("Bonus: ", "₹${item.bonus}"),
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
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     final formData = _formKey.currentState!.value;
//                     print("Form Data: $formData");
//                     String strBonusPercentage = formData['bonus'];

//                     String query =
//                         "SELECT Code, AutoID, MemCode, COUNT(DISTINCT(CollDate)) AS CollDate, "
//                         "CollTime, CollSession, PRINTF('%.2f', SUM(KgFat) / SUM(Liters)) AS FAT, "
//                         "PRINTF('%.2f', SUM(Amount)) AS Amount, "
//                         "PRINTF('%.2f', (SUM(Amount) / 100) * $strBonusPercentage) AS Bonus, "
//                         "PRINTF('%.2f', SUM(Liters)) AS Liters, Cattle, LitersEntryType, "
//                         "PRINTF('%.2f', SUM(KgSnf) / SUM(Liters)) AS SNF, AVG(CLR) AS CLR, "
//                         "FAT_SNF_EntryType, PRINTF('%.2f', AVG(Rate)) AS Rate, Amount_Type, "
//                         "ReceiptPrinted, SentStatus, SentOn, UploadStatus, UploadOn, IsSync, "
//                         "SampleNo, VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, "
//                         "Locked, KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount "
//                         "FROM MilkCollection WHERE CollDate BETWEEN '$startDateFormat' AND '$endDateFormat' "
//                         "AND LOCKED <> '1' GROUP BY MemCode ORDER BY MemCode ASC";

//                     milkCollectionList.value =
//                         await DBHelper().getMilkCollection(query);

//                     print(milkCollectionList.value);

//                     // Get.toNamed(Routes.milkCollectionEntryScreen);
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
