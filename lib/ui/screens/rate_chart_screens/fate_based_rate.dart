// import 'dart:math';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/controller/fat_based_rate_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// // class RateEntry {
// //   final String animalType;
// //   final int grade;
// //   final double fatFrom;
// //   final double fatTo;
// //   final String timestamp;
// //   final double ratePerKg;

// //   RateEntry({
// //     required this.animalType,
// //     required this.grade,
// //     required this.fatFrom,
// //     required this.fatTo,
// //     required this.timestamp,
// //     required this.ratePerKg,
// //   });
// // }

// class FatBasedRateScreen extends StatefulWidget {
//   @override
//   State<FatBasedRateScreen> createState() => _FatBasedRateScreenState();
// }

// class _FatBasedRateScreenState extends State<FatBasedRateScreen> {
//   FatBasedRateController fatBasedRateController = FatBasedRateController();
//   // final List<RateEntry> rateEntries = List.generate(10, (index) {
//   //   Random random = Random();
//   //   return RateEntry(
//   //     animalType: random.nextBool() ? "Buffalo" : "Cow",
//   //     grade: random.nextInt(3) + 1,
//   //     // Grade 1 to 3
//   //     fatFrom: (random.nextDouble() * 10 + 6).toDouble(),
//   //     // Fat from 6 to 15
//   //     fatTo: (random.nextDouble() * 10 + 20).toDouble(),
//   //     // Fat to 21 to 30
//   //     timestamp: DateFormat('yyyy-MM-dd HH:mm:ss')
//   //         .format(DateTime.now().subtract(Duration(days: random.nextInt(30)))),
//   //     ratePerKg:
//   //         (random.nextDouble() * 50 + 100).toDouble(), // Rate between 100-150
//   //   );
//   // });

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fatBasedRateController.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Fat Based Rates"),
//         centerTitle: true,
//         backgroundColor: AppColors.appColor,
//       ),
//       body: Obx(
//         () => ListView.builder(
//           itemCount: fatBasedRateController.mMilkCollections.length,
//           itemBuilder: (context, index) {
//             // final entry = rateEntries[index];
//             return Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.circular(10), // Updated corner radius
//               ),
//               margin: EdgeInsets.all(8.0.sp),
//               child: Padding(
//                 padding: EdgeInsets.all(12.0.sp),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${fatBasedRateController.mMilkCollections[index].animalType == "0" ? "Cow" : "Buffalo"} - Grade ${fatBasedRateController.mMilkCollections[index].grade}",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       "Fat:",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       "${fatBasedRateController.mMilkCollections[index].fatFrom.toStringAsFixed(1)}% to ${fatBasedRateController.mMilkCollections[index].fatTo.toStringAsFixed(1)}%",
//                       style: TextStyle(fontSize: 14.sp, color: Colors.black54),
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       "Date:",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       fatBasedRateController.mMilkCollections[index].timestamp,
//                       style: TextStyle(fontSize: 14.sp, color: Colors.black54),
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       "Rate per KG:",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       "₹${fatBasedRateController.mMilkCollections[index].ratePerKg}",
//                       style: TextStyle(fontSize: 14.sp, color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
