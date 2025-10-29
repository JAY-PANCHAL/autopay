// import 'package:aasaan_flutter/common/utils/app_constants.dart';
// import 'package:aasaan_flutter/common/utils/image_paths.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/controller/dashboard_controller.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/token_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../../common/notification_main.dart';
// import '../../common/utils/color_constants.dart';
// import '../../common/utils/utility.dart';
// import '../../main.dart';
// import '../../routes/app_pages.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => DashboardScreenState();
// }

// class DashboardScreenState extends State<DashboardScreen> {
//   final DashboardController dashboardController =
//       Get.put((DashboardController()));
//   bool obscureText = true;
//   var istablet = Utils.checkTablet();
//   @override
//   void initState() {
//     addData();
//     super.initState();
//   }

//   addData() async {
//     dashboardController.locationMasterApiCall(context);
//     await DBHelper().database; // Initialize database


//     dashboardController.list.value = [
//       FileModel(
//         name: "Milk Collection",
//         path: AppIcons.milkCollection,
//         onPressed: () {
//           Get.toNamed(Routes.milkCollection);
//         },
//       ),
//       FileModel(
//         name: "Local Sales Entry",
//         path: AppIcons.localSalesEntry,
//         onPressed: () {
//           Get.toNamed(Routes.localSalesEntry);
//         },
//       ),
//       FileModel(
//         name: "Dispatch Sales Entry",
//         path: AppIcons.dispatchSlipEntry,
//         onPressed: () {
//           Get.toNamed(Routes.dispatchSalesEntry);
//         },
//       ),
//       FileModel(
//         name: "Union Truck Slip Confirmation Entry",
//         path: AppIcons.confirmationEntry,
//         onPressed: () {
//           Get.toNamed(Routes.truckSlipConfirmation);
//         },
//       ),
//       FileModel(
//         name: "Deduction Entry",
//         path: AppIcons.deductionEntry,
//         onPressed: () {
//         // Utils.showToast("Under Development");
//            Get.toNamed(Routes.deductionEntry);
//         },
//       ),
//       FileModel(
//         name: "Collection Summary",
//         path: AppIcons.todaysSummary,
//         onPressed: () {
//           Get.toNamed(Routes.collectionSummary);
//         },
//       ),
//       FileModel(
//         name: "Farmer Profile",
//         path: AppIcons.farmerProfile,
//         onPressed: () {
//           Get.toNamed(Routes.farmerProfile);
//         },
//       ),
//       FileModel(
//         name: "Report Statement",
//         path: AppIcons.reportStatement,
//         onPressed: () {
//           Get.toNamed(Routes.reportStatement);
//         },
//       ),
//       FileModel(
//         name: "Print Duplicate",
//         path: AppIcons.printDuplicate,
//         onPressed: () {
//           Get.toNamed(Routes.printDuplicate);
//         },
//       ),
//       FileModel(
//         name: "Feedback",
//         path: AppIcons.feedback,
//         onPressed: () {
//           Get.toNamed(Routes.feedback);
//         },
//       ),
//       FileModel(
//         name: "Rate Chart",
//         path: AppIcons.rateMaster,
//         onPressed: () {
//           Get.toNamed(Routes.rateChart);
//         },
//       ),
//       FileModel(
//         name: "Import Rate Chart",
//         path: AppIcons.feedback,
//         onPressed: () {
//           Get.toNamed(Routes.importRateChart);
//         },
//       ),
//       FileModel(
//         name: "Setting",
//         path: AppIcons.setting,
//         onPressed: () {
//           Get.toNamed(Routes.setting);
//         },
//       ),
//       FileModel(
//         name: "Bulk Farmer Data Management",
//         path: AppIcons.multipleMember,
//         onPressed: () {
//           Get.toNamed(Routes.bulkFarmerData);
//         },
//       ),
//       FileModel(
//         name: "Get Milk Collection Data From Server",
//         path: AppIcons.deductionEntry,
//         onPressed: () {
//           Get.toNamed(Routes.syncMilkCollection);
//         },
//       ),
//       FileModel(
//         name: "Sync Milk Collection to Server",
//         path: AppIcons.deductionEntry,
//         onPressed: () async {
//           dashboardController.isLoading.value=true;
//           await commonController.callPostMilkCollection(true);
//           dashboardController.isLoading.value=false;
//         },
//       ),
//       FileModel(
//         name: "Get Farmer Data from Server",
//         path: AppIcons.deductionEntry,
//         onPressed: () async {
//           dashboardController.isLoading.value=true;
//           await commonController.getMemberCountApiCall(context);
//           dashboardController.isLoading.value=false;
//         },
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = Utils.getScreenWidth(context);
//     var height = Utils.getScreenHeight(context);

//     return Obx(() {
//       return ModalProgressHUD(
//           color: Colors.black.withOpacity(0.6),
//           dismissible: false,
//           blur: 5,
//           progressIndicator: Utils.loader(context),
//           inAsyncCall: dashboardController.isLoading.value,
//           child: Scaffold(
//             resizeToAvoidBottomInset: true,
//             appBar: AppBar(
//               title: Utils.normalText("Dashboard",
//                   size: istablet ? 4.sp : 15.sp, color: Colors.white),
//               centerTitle: true,
//               backgroundColor: AppColors.appColor,

//               actions: [
//                /* GestureDetector(
//                     onTap: (){
//                         Get.toNamed(Routes.bluetoothScreen);
//                     },
//                     child: Icon(Icons.bluetooth)),
//                 Utils.addHGap(20),*/
//                 GestureDetector(
//                     onTap: (){
//                       DBHelper().showLogoutConfirmation(context);
//                     },
//                     child: Icon(Icons.logout)),
//                 Utils.addHGap(20)
//               ],
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(10.w),
//               child: dashboardController.isGridView.value
//                   ? buildGridView()
//                   : buildListView(),
//             ),
//             floatingActionButton: Container(
//               height: istablet ? 50.h : 50.h,
//               width: istablet ? 50.w : 50.w,
//               child: FloatingActionButton(
//                 backgroundColor: AppColors.appColor,
//                 onPressed: () {
//                   setState(() {
//                     dashboardController.isGridView.value =
//                         !dashboardController.isGridView.value;
//                   });
//                 },
//                 child: Icon(
//                   dashboardController.isGridView.value
//                       ? Icons.list
//                       : Icons.grid_view,
//                   size: istablet ? 16.sp : 18.sp,
//                 ),
//               ),
//             ),
//           ));
//     });
//   }

//   // ListView with rounded images and text
//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: dashboardController.list.value.length,
//       itemBuilder: (context, index) {
//         final file = dashboardController.list.value[index];
//         return InkWell(
//           onTap: file.onPressed,
//           child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r)),
//               margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//               elevation: 3,
//               child: ListTile(
//                   contentPadding: EdgeInsets.all(10.w),
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(10.r),
//                     child: Image.asset(file.path,
//                         width: istablet ? 30.w : 50.w,
//                         height: istablet ? 60.h : 50.h,
//                         fit: BoxFit.cover),
//                   ),
//                   title: Text(file.name,
//                       style: TextStyle(
//                           fontSize: 16.sp, fontWeight: FontWeight.w500)))),
//         );
//       },
//     );
//   }

//   // GridView with images and text
//   Widget buildGridView() {
//     return GridView.builder(
//       itemCount: dashboardController.list.value.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.w,
//         mainAxisSpacing: 10.h,
//         childAspectRatio: istablet ? 1.4 : 1.0,
//       ),
//       itemBuilder: (context, index) {
//         final file = dashboardController.list.value[index];
//         return InkWell(
//           onTap: file.onPressed,
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r)),
//             elevation: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10.r),
//                   child: Image.asset(file.path,
//                       width: 80.w, height: 80.h, fit: BoxFit.cover),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(file.name,
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
