// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/ui/screens/milk_collection_screens/milk_collection_entry_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../common/utils/utility.dart';

// class TodayCollectionScreen extends StatefulWidget {
//   @override
//   State<TodayCollectionScreen> createState() => _TodayCollectionScreenState();
// }

// class _TodayCollectionScreenState extends State<TodayCollectionScreen> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

//   String strAmountValue = "",
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
//       strAvgSnfCowValue = "";


//   @override
//   void initState() {

//     getData();


//     super.initState();
//   }

// getData() async {


//   String time = DateFormat("HH:mm:ss").format(DateTime.now());
//   String date = DateFormat("yyyy-MM-dd").format(DateTime.now());


//   strAvgSnfCowValue=Formatter.m2d(Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB("SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection "
//         "WHERE CollDate = '$date' AND Cattle = 'C' AND Locked <> '1'")));

//   strAvgFatCowValue = Formatter.m2d(
//     Utils.replaceNullZero(
//       await DBHelper().getScalarQueryStringFromDB(
//           "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection "
//               "WHERE CollDate = '$date' AND Cattle = 'C' AND Locked <> '1'"
//       ),
//     ),
//   );

//   strAvgSnfBufValue = Formatter.m2d(
//     Utils.replaceNullZero(
//       await DBHelper().getScalarQueryStringFromDB(
//           "SELECT SUM(KgSnf)/SUM(Liters) FROM MilkCollection "
//               "WHERE CollDate = '$date' AND Cattle = 'B' AND Locked <> '1'"
//       ),
//     ),
//   );

//   strAvgFatBufValue = Formatter.m2d(
//     Utils.replaceNullZero(
//       await DBHelper().getScalarQueryStringFromDB(
//           "SELECT SUM(KgFat)/SUM(Liters) FROM MilkCollection "
//               "WHERE CollDate = '$date' AND Cattle = 'B' AND Locked <> '1'"
//       ),
//     ),
//   );
//   strTotalSnfValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(SNF) FROM MilkCollection WHERE CollDate = '$date' AND Locked <> '1'"
//     ),
//   );
//   strTotalFatValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(FAT) FROM MilkCollection WHERE CollDate = '$date' AND Locked <> '1'"
//     ),
//   );

//   strNoOfNonMembersValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT COUNT(DISTINCT MemCode) AS NonMemberCount "
//             "FROM MilkCollection A "
//             "WHERE EXISTS (SELECT 1 FROM MembersProfile B "
//             "WHERE B.MemCode = A.MemCode AND B.IsMember = 0) "
//             "AND CollDate = '$date' AND Locked <> '1'"
//     ),
//   );
//   strNoOfMembersValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT COUNT(DISTINCT MemCode) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Locked <> '1'"
//     ),
//   );

//   strMilkCollectionValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT COUNT(DISTINCT MemCode) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Locked <> '1'"
//     ),
//   );

//   strAmountValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(Amount) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Locked <> '1'"
//     ),
//   );
//   strCowsMilkLiterValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(Liters) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Cattle = 'C' AND Locked <> '1'"
//     ),
//   );

//   strBuffaloMilkLiterValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(Liters) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Cattle = 'B' AND Locked <> '1'"
//     ),
//   );

//   strCowsMilkAmountValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(Amount) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Cattle = 'C' AND Locked <> '1'"
//     ),
//   );
//   strBuffaloMilkAmountValue = Utils.replaceNullZero(
//     await DBHelper().getScalarQueryStringFromDB(
//         "SELECT SUM(Amount) FROM MilkCollection "
//             "WHERE CollDate = '$date' AND Cattle = 'B' AND Locked <> '1'"
//     ),
//   );
// // Setting values in the form
//   _formKey.currentState?.patchValue({
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Text("Today Collection", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.w),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
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
//       bottomNavigationBar: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => Get.back(),
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
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.saveAndValidate()) {
//                   final formData = _formKey.currentState!.value;
//                   print("Form Data: $formData");
//                 } else {
//                   print("Form validation failed!");
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
// }
