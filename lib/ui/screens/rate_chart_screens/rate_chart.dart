// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/ui/screens/rate_chart_screens/fat_based_manual_rate.dart';
// import 'package:aasaan_flutter/ui/screens/rate_chart_screens/fat_snf_based_rate.dart';
// import 'package:aasaan_flutter/ui/screens/rate_chart_screens/fate_based_rate.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RateChart extends StatefulWidget {
//   @override
//   _RateChartState createState() => _RateChartState();
// }

// class _RateChartState extends State<RateChart> {
//   final isGridView = true.obs; // Observable to toggle grid/list

//   final List<Map<String, dynamic>> rateOptions = [
//     {"name": "Fat Based Rate", "icon": Icons.analytics, "route": "/fatBased"},
//     {"name": "Fat Based Manual Rate", "icon": Icons.settings, "route": "/manualFat"},
//     {"name": "Fat SNF Based Rate", "icon": Icons.insert_chart, "route": "/fatSnf"},
//     {"name": "Fat CLR Based Rate", "icon": Icons.bar_chart, "route": "/fatClr"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Rate Selection", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
//         centerTitle: true,
//         backgroundColor: AppColors.appColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Obx(() => isGridView.value ? buildListView() : buildGridView()),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.appColor,
//         onPressed: () {
//           isGridView.value = !isGridView.value; // Toggle List/Grid
//         },
//         child: Icon(isGridView.value ? Icons.list : Icons.grid_view, size: 24.sp),
//       ),
//     );
//   }

//   /// **ListView with modern UI**
//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: rateOptions.length,
//       itemBuilder: (context, index) {
//         final option = rateOptions[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//           elevation: 3,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//           child: ListTile(
//             contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
//             leading: Icon(option['icon'], color: AppColors.appColor, size: 24.sp),
//             title: Text(option['name'], style: TextStyle(fontSize: 16.sp)),
//             trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
//             onTap: () {
//               if(option['name']=="Fat Based Manual Rate"){
//                 Get.to(FatBasedManualRateScreen());
//               }else  if(option['name']=="Fat SNF Based Rate"){
//                 Get.to(FatSNFBasedRateScreen());
//               }else  if(option['name']=="Fat Based Rate"){
//                 Get.to(FatBasedRateScreen());
//               }
//             },
//           ),
//         );
//       },
//     );
//   }

//   /// **GridView with rounded icons and labels**
//   Widget buildGridView() {
//     return GridView.builder(
//       itemCount: rateOptions.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.w,
//         mainAxisSpacing: 10.h,
//         childAspectRatio: 1.2,
//       ),
//       itemBuilder: (context, index) {
//         final option = rateOptions[index];
//         return InkWell(
//           onTap: () {
//             Get.toNamed(option['route']);
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//             elevation: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(option['icon'], size: 40.sp, color: AppColors.appColor),
//                 SizedBox(height: 8.h),
//                 Text(option['name'],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
