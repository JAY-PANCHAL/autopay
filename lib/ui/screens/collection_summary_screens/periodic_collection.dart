// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/utils/utility.dart';
// import '../../../db/db_helper.dart';
// import '../milk_collection_screens/milk_collection_entry_screen.dart';

// class PeriodicCollectionScreen extends StatefulWidget {
//   @override
//   State<PeriodicCollectionScreen> createState() =>
//       _PeriodicCollectionScreenState();
// }

// class _PeriodicCollectionScreenState extends State<PeriodicCollectionScreen> {
//   GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

//   RxString selectedSession = "Morning".obs;

//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;

//   String strAmountValue = "0",
//       strMilkCollectionValue = "",
//       strCowsMilkLiterValue = "",
//       strBuffaloMilkLiterValue = "",
//       strCowsMilkAmountValue = "",
//       strBuffaloMilkAmountValue = "",
//       strNoOfMembersValue = "",
//       strNoOfNonMembersValue = "",
//       strTotalFatValue = "",
//       strTotalSnfValue = "",
//       strAvgFatBufValue = "",
//       strAvgSnfBufValue = "",
//       strAvgFatCowValue = "",
//       strAvgSnfCowValue = "",
//       session = "M";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Text("Date & Session Selection",
//             style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.w),
//         child: FormBuilder(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildDateField(
//                   "start_date", "Start Date", startDate, startDateFormat,),
//               SizedBox(height: 15.h),
//               _buildDateField("end_date", "End Date", endDate, endDateFormat),
//               SizedBox(height: 15.h),

//               // **Session Dropdown**
//               Text("Session",
//                   style:
//                       TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//               SizedBox(height: 5.h),
//               Obx(() => FormBuilderDropdown(
//                     name: "session",
//                     initialValue: selectedSession.value,
//                     onChanged: (value) {
//                       selectedSession.value = value ?? "";
//                       if (selectedSession.value.contains("Morning")) {
//                         session = "M";
//                       } else if (selectedSession.value.contains("Evening")) {
//                         session = "E";
//                       } else if (selectedSession.value.contains("Both")) {
//                         session = "B";
//                       }
//                     },
//                     items: ["Morning", "Evening", "Both"]
//                         .map((session) => DropdownMenuItem(
//                             value: session, child: Text(session)))
//                         .toList(),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                     ),
//                   )),
//               SizedBox(height: 20.h),
//               _buildTextField("total_amount", "Total Amount"),
//               SizedBox(height: 15.h),
//               _buildTextField("total_milk_collection", "Total Milk Collection"),
//               SizedBox(height: 15.h),
//               _buildTextField("cow_liter", "Cow Liter"),
//               SizedBox(height: 15.h),
//               _buildTextField("buffalo_liter", "Buffalo Liter"),
//               SizedBox(height: 15.h),
//               _buildTextField("cow_amount", "Cow Amount"),
//               SizedBox(height: 15.h),
//               _buildTextField("buffalo_amount", "Buffalo Amount"),
//               SizedBox(height: 15.h),
//               _buildTextField("num_members", "No. of Members"),
//               SizedBox(height: 15.h),
//               _buildTextField("num_non_members", "No. of Non-Members"),
//               SizedBox(height: 15.h),
//               _buildTextField("avg_fat_buffalo", "Avg. Fat Buffalo"),
//               SizedBox(height: 15.h),
//               _buildTextField("avg_snf_buffalo", "Avg. SNF Buffalo"),
//               SizedBox(height: 15.h),
//               _buildTextField("avg_fat_cow", "Avg. Fat Cow"),
//               SizedBox(height: 15.h),
//               _buildTextField("avg_snf_cow", "Avg. SNF Cow"),
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),

//       // **Bottom Buttons**
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(10.w),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () => Get.back(),
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
//             SizedBox(width: 10.w),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.saveAndValidate()) {
//                     final formData = formKey.currentState!.value;
//                     print("Form Data: $formData");
//                   } else {
//                     print("Form validation failed!");
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
//       ),
//     );
//   }

//   displayData() async {
// if(startDateFormat.value!="" && endDateFormat.value!="") {
//   if (session == "B") {
//     strAvgSnfCowValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection "
//                 "WHERE CollDate BETWEEN '${startDateFormat
//                 .value}' AND '${endDateFormat.value}' "
//                 "AND Cattle='C' AND Locked <> '1'"
//         )
//     ));
//   } else {
//     strAvgSnfCowValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection "
//                 "WHERE CollDate BETWEEN '${startDateFormat
//                 .value}' AND '${endDateFormat.value}' "
//                 "AND CollSession = '${session}' "
//                 "AND Cattle='C' AND Locked <> '1'"
//         )
//     ));
//   }

//   if (session == "B") {
//     strAvgFatCowValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection "
//                 "WHERE CollDate BETWEEN '${startDateFormat
//                 .value}' AND '${endDateFormat.value}' "
//                 "AND Cattle='C' AND Locked <> '1'"
//         )
//     ));
//   } else {
//     strAvgFatCowValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection "
//                 "WHERE CollDate BETWEEN '${startDateFormat
//                 .value}' AND '${endDateFormat.value}' "
//                 "AND CollSession = '${session}' "
//                 "AND Cattle='C' AND Locked <> '1'"
//         )
//     ));
//   }

//   if (session.toUpperCase() == "B") {
//     strAvgSnfBufValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='B' AND Locked <> '1'")));
//   } else {
//     strAvgSnfBufValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" +
//                 session + "' AND Cattle='B' AND Locked <> '1'")));
//   }


//   if (session.toUpperCase() == "B") {
//     strAvgFatBufValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='B' AND Locked <> '1'")));
//   } else {
//     strAvgFatBufValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" +
//                 session + "' AND Cattle='B' AND Locked <> '1'")));
//   }


//   if (session == "B") {
//     strTotalSnfValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(SNF) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'")));
//   } else {
//     strTotalSnfValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(SNF) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" +
//                 session + "' AND Locked <> '1'")));
//   }

//   if (session == "B") {
//     strTotalFatValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(FAT) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'")));
//   } else {
//     strTotalFatValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(FAT) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" +
//                 session + "' AND Locked <> '1'")));
//   }


//   if (session.toUpperCase() == "B") {
//     strNoOfNonMembersValue = Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT COUNT(DISTINCT MemCode) AS NonMemberCount " +
//                 "FROM MilkCollection A WHERE EXISTS " +
//                 "(SELECT 1 FROM MembersProfile B " +
//                 "WHERE B.MemCode = A.MemCode AND B.IsMember = 0) " +
//                 "AND CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'"));
//   } else {
//     strNoOfNonMembersValue = Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT COUNT(DISTINCT MemCode) AS NonMemberCount " +
//                 "FROM MilkCollection A WHERE EXISTS " +
//                 "(SELECT 1 FROM MembersProfile B " +
//                 "WHERE B.MemCode = A.MemCode AND B.IsMember = 0) " +
//                 "AND CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Locked <> '1'"));
//   }


//   if (session.toUpperCase() == "B") {
//     strNoOfMembersValue = Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT COUNT(DISTINCT MemCode) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'"));
//   } else {
//     strNoOfMembersValue = Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT COUNT(DISTINCT MemCode) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Locked <> '1'"));
//   }


//   if (session.toUpperCase() == "B") {
//     strMilkCollectionValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'")));
//   } else {
//     strMilkCollectionValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Locked <> '1'")));
//   }


//   if (session.toUpperCase() == "B") {
//     strAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Locked <> '1'")));
//   } else {
//     strAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Locked <> '1'")));
//   }


//   if (session.toUpperCase() == "B") {
//     strCowsMilkLiterValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='C' AND Locked <> '1'")));
//   } else {
//     strCowsMilkLiterValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Cattle='C' AND Locked <> '1'")));
//   }

//   if (session.toUpperCase() == "B") {
//     strBuffaloMilkLiterValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='B' AND Locked <> '1'")));
//   } else {
//     strBuffaloMilkLiterValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Cattle='B' AND Locked <> '1'")));
//   }

//   if (session.toUpperCase() == "B") {
//     strCowsMilkAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='C' AND Locked <> '1'")));

//     strBuffaloMilkAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND Cattle='B' AND Locked <> '1'")));
//   } else {
//     strCowsMilkAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Cattle='C' AND Locked <> '1'")));

//     strBuffaloMilkAmountValue = Formatter.m2d(Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(
//             "SELECT SUM(Amount) FROM MilkCollection " +
//                 "WHERE CollDate BETWEEN '" + startDateFormat.value + "' AND '" +
//                 endDateFormat.value + "' AND CollSession = '" + session + "' " +
//                 "AND Cattle='B' AND Locked <> '1'")));
//   }

//   formKey.currentState?.patchValue({
//     "total_amount": strAmountValue,
//     "total_milk_collection": strMilkCollectionValue,
//     "cow_liter": strCowsMilkLiterValue,
//     "buffalo_liter": strBuffaloMilkLiterValue,
//     "cow_amount": strCowsMilkAmountValue,
//     "buffalo_amount": strBuffaloMilkAmountValue,
//     "num_members": strNoOfMembersValue,
//     "num_non_members": strNoOfNonMembersValue,
//     "avg_fat_buffalo": strAvgFatBufValue,
//     "avg_snf_buffalo": strAvgSnfBufValue,
//     "avg_fat_cow": strAvgFatCowValue,
//     "avg_snf_cow": strAvgSnfCowValue,
//   });
// }
//   }
//   /// **Reusable Text Field**
//   Widget _buildTextField(String name, String label) {
//     return FormBuilderTextField(
//       name: name,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       keyboardType: TextInputType.number,
//       readOnly: true,
//     );
//   }

//   /// **Date Picker Field**

//   Widget _buildDateField(String name, String label, Rx<DateTime?> dateValue,
//       RxString formattedDateValue) {
//     return Obx(() => GestureDetector(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: Get.context!,
//           initialDate: dateValue.value ?? DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2100),
//         );

//         if (pickedDate != null) {
//           // If this is the end date field and start date is set, validate
//           if (name == "end_date" && startDate.value != null) {
//             if (pickedDate.isBefore(startDate.value!)) {
//               Get.snackbar("Invalid Date", "End date cannot be earlier than the start date.",
//                   backgroundColor: Colors.red, colorText: Colors.white);
//               return;
//             }
//           }

//           dateValue.value = pickedDate;
//           formattedDateValue.value = DateFormat("yyyy-MM-dd").format(pickedDate);
//           displayData();
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               formattedDateValue.value.isNotEmpty
//                   ? formattedDateValue.value
//                   : label,
//               style: TextStyle(
//                   fontSize: 16.sp,
//                   color: formattedDateValue.value.isNotEmpty
//                       ? Colors.black
//                       : Colors.black54),
//             ),
//             Icon(Icons.calendar_today, color: Colors.grey),
//           ],
//         ),
//       ),
//     ));
//   }

// }
