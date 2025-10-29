// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/ui/screens/settings/data_settings_screen.dart';
// import 'package:aasaan_flutter/ui/screens/settings/general_setting_screen.dart';
// import 'package:aasaan_flutter/ui/screens/settings/rate_amount_settings_screen.dart';
// import 'package:aasaan_flutter/ui/screens/settings/tab_profile_setting.dart';
// import 'package:aasaan_flutter/ui/screens/settings/printer_related_settings.dart';
// import 'package:aasaan_flutter/ui/screens/settings/session_related_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final isGridView = true.obs; // Observable to toggle grid/list
//   var istablet = Utils.checkTablet();

//   final List<Map<String, dynamic>> settingsOptions = [
//     {"name": "Session Related", "icon": Icons.schedule, "route": "/session"},
//     {"name": "Printer Setting", "icon": Icons.print, "route": "/printer"},
//     {
//       "name": "Tab Profile Setting",
//       "icon": Icons.tablet_android,
//       "route": "/tabProfile"
//     },
//     {"name": "Data Setting", "icon": Icons.storage, "route": "/data"},
//     {
//       "name": "Rate/Amount Setting",
//       "icon": Icons.attach_money,
//       "route": "/rateAmount"
//     },
//     {"name": "General Setting", "icon": Icons.settings, "route": "/general"},
//     {
//       "name": "Export Milk Collection",
//       "icon": Icons.cloud_upload,
//       "route": "/exportMilk"
//     },
//     {
//       "name": "Export Template RateChart",
//       "icon": Icons.insert_chart,
//       "route": "/exportTemplate"
//     },
//     {
//       "name": "Import Fat SNF Rate Chart",
//       "icon": Icons.file_download,
//       "route": "/importFatSNF"
//     },
//     {
//       "name": "Import Fat Rate Chart",
//       "icon": Icons.file_download,
//       "route": "/importFat"
//     },
//     {"name": "Reset Settings", "icon": Icons.refresh, "route": "/reset"},
//     {"name": "Sync Status", "icon": Icons.sync, "route": "/sync"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Settings",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         backgroundColor: AppColors.appColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Obx(() => isGridView.value ? buildListView() : buildGridView()),
//       ),
//       floatingActionButton: Container(
//         height: istablet ? 50.h : 50.h,
//         width: istablet ? 50.w : 50.w,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.appColor,
//           onPressed: () {
//             isGridView.value = !isGridView.value; // Toggle View Mode
//           },
//           child: Icon(isGridView.value ? Icons.list : Icons.grid_view,
//               size: 24.sp),
//         ),
//       ),
//     );
//   }

//   /// **ListView with modern UI**
//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: settingsOptions.length,
//       itemBuilder: (context, index) {
//         final option = settingsOptions[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//           elevation: 3,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//           child: ListTile(
//             contentPadding: EdgeInsets.symmetric(
//                 vertical: istablet ? 14.h : 8.h,
//                 horizontal: istablet ? 10.w : 8.w),
//             leading:
//                 Icon(option['icon'], color: AppColors.appColor, size: 24.sp),
//             title: Text(option['name'], style: TextStyle(fontSize: 16.sp)),
//             trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
//             onTap: () {
//               if (option['name'].toString().toLowerCase() == "session related") {
//                 Get.to(SessionRelatedScreen());
//               }else if (option['name'].toString().toLowerCase() == "printer setting") {
//                 Get.to(PrinterSettingsScreen());
//               }else if (option['name'].toString().toLowerCase() == "tab profile setting") {
//                 Get.to(TabProfileSettingScreen());
//               }else if (option['name'].toString().toLowerCase() == "data setting") {
//                 Get.to(DataSettingScreen());
//               }else if (option['name'].toString().toLowerCase() == "rate/amount setting") {
//                 Get.to(RateAmountSettingScreen());
//               }else if (option['name'].toString().toLowerCase() == "general setting") {
//                 Get.to(GeneralSettingScreen());
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
//       itemCount: settingsOptions.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.w,
//         mainAxisSpacing: 10.h,
//         childAspectRatio: 1.2,
//       ),
//       itemBuilder: (context, index) {
//         final option = settingsOptions[index];
//         return InkWell(
//           onTap: () {
//             // Get.toNamed(option['route']);
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r)),
//             elevation: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(option['icon'], size: 40.sp, color: AppColors.appColor),
//                 SizedBox(height: 8.h),
//                 Text(option['name'],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 14.sp, fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
