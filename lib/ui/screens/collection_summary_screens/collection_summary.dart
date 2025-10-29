// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:aasaan_flutter/ui/screens/collection_summary_screens/periodic_collection.dart';
// import 'package:aasaan_flutter/ui/screens/collection_summary_screens/today_collection_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class CollectionSummary extends StatefulWidget {
//   const CollectionSummary({Key? key}) : super(key: key);

//   @override
//   State<CollectionSummary> createState() => _CollectionSummaryState();
// }

// class _CollectionSummaryState extends State<CollectionSummary> {
//   var istablet = Utils.checkTablet();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Collection Summary",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         backgroundColor: AppColors.appColor,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Utils.addGap(20), // Add some spacing before buttons
//             _buildButton("Today Collection", Icons.today, () {
//               Get.to(TodayCollectionScreen());
//              /* Get.snackbar("Info", "Today Collection Clicked",
//                   snackPosition: SnackPosition.BOTTOM);*/
//             }),
//             Utils.addGap(16),
//             _buildButton("Periodic Collection", Icons.date_range, () {

//               Get.to(PeriodicCollectionScreen());
//             }),
//             Utils.addGap(16),
//             _buildButton("SMS Summary Record", Icons.message, () {
//               Get.snackbar("Info", "SMS Summary Clicked");
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   /// **Builds a Date Field**
//   Widget _buildDateField() {
//     return FormBuilderDateTimePicker(
//       name: "date",
//       style: TextStyle(fontSize: istablet ? 12.sp : 16.sp),
//       initialValue: DateTime.now(),
//       inputType: InputType.date,
//       format: DateFormat('dd/MM/yyyy'),
//       decoration: InputDecoration(
//         labelText: "Date Selection",
//         border: OutlineInputBorder(),
//         suffixIcon: Icon(Icons.calendar_today),
//       ),
//       validator: FormBuilderValidators.required(errorText: "Date is required"),
//     );
//   }

//   /// **Reusable Button Widget**
//   Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
//     return SizedBox(
//       height: 55.h,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.appColor, // Your app theme color
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 12.h),
//           elevation: 4,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(width: 10.w),
//             Icon(icon, color: Colors.white, size: 24.sp),
//             SizedBox(width: 20.w),
//             Text(
//               text,
//               style: TextStyle(fontSize: 16.sp, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
