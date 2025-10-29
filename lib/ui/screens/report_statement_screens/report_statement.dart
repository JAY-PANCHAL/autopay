// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/image_paths.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/report_statement_controller.dart';
// import 'package:aasaan_flutter/network/model/token_model.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// class ReportStatement extends StatefulWidget {
//   const ReportStatement({Key? key}) : super(key: key);

//   @override
//   State<ReportStatement> createState() => _ReportStatementState();
// }

// class _ReportStatementState extends State<ReportStatement> {
//   final ReportStatementController reportStatementController =
//       Get.put((ReportStatementController()));
//   var istablet = Utils.checkTablet();

//   @override
//   void initState() {
//     addData();
//     super.initState();
//   }

//   addData() {
//     reportStatementController.list.value = [
//       FileModel(
//         name: "Member Slip",
//         path: AppIcons.farmerProfile,
//         onPressed: () {
//           Get.toNamed(Routes.memberSlipScreen);
//         },
//       ),
//       FileModel(
//         name: "Session Report",
//         path: AppIcons.localSalesEntry,
//         onPressed: () {
//           Get.toNamed(Routes.sessionReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Payment Report",
//         path: AppIcons.rateMaster,
//         onPressed: () {
//           Get.toNamed(Routes.paymentReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Session Time Report",
//         path: AppIcons.confirmationEntry,
//         onPressed: () {
//           Get.toNamed(Routes.sessionTimeReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Bonus Report",
//         path: AppIcons.deductionEntry,
//         onPressed: () {
//           Get.toNamed(Routes.bonusReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Member Master Report",
//         path: AppIcons.todaysSummary,
//         onPressed: () {
//           Get.toNamed(Routes.memberMasterReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Member's Passbook",
//         path: AppIcons.farmerProfile,
//         onPressed: () {
//           Get.toNamed(Routes.memberPassbookScreen);
//         },
//       ),
//       FileModel(
//         name: "Dairy Register Report",
//         path: AppIcons.reportStatement,
//         onPressed: () {
//           Get.toNamed(Routes.dairyRegisterReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Local Milk Sales Register",
//         path: AppIcons.reportStatement,
//         onPressed: () {
//           Get.toNamed(Routes.localMilkSalesRegisterScreen);
//         },
//       ),
//       FileModel(
//         name: "Kapat Report",
//         path: AppIcons.feedback,
//         onPressed: () {
//           Get.toNamed(Routes.kapatReportScreen);
//         },
//       ),
//       FileModel(
//         name: "Election Register",
//         path: AppIcons.localSalesEntry,
//         onPressed: () {
//           Get.toNamed(Routes.electionRegisterScreen);
//         },
//       ),
//       FileModel(
//         name: "Share Register",
//         path: AppIcons.feedback,
//         onPressed: () {
//           Get.toNamed(Routes.shareRegisterScreen);
//         },
//       ),
//       FileModel(
//         name: "Bank Payment",
//         path: AppIcons.setting,
//         onPressed: () {
//           Get.toNamed(Routes.bankPaymentScreen);
//         },
//       ),
//       FileModel(
//         name: "Member Ledger",
//         path: AppIcons.multipleMember,
//         onPressed: () {
//           Get.toNamed(Routes.memberLedgerScreen);
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
//           inAsyncCall: reportStatementController.isLoading.value,
//           child: Scaffold(
//             resizeToAvoidBottomInset: true,
//             appBar: AppBar(
//               title: Utils.normalText("Report Statement",
//                   size: istablet ? 4.sp : 15.sp, color: Colors.white),
//               centerTitle: true,
//               backgroundColor: AppColors.appColor,
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(10.w),
//               child: reportStatementController.isGridView.value
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
//                     reportStatementController.isGridView.value =
//                         !reportStatementController.isGridView.value;
//                   });
//                 },
//                 child: Icon(
//                   reportStatementController.isGridView.value
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
//       itemCount: reportStatementController.list.value.length,
//       itemBuilder: (context, index) {
//         final file = reportStatementController.list.value[index];
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
//       itemCount: reportStatementController.list.value.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.w,
//         mainAxisSpacing: 10.h,
//         childAspectRatio: istablet ? 1.4 : 1.0,
//       ),
//       itemBuilder: (context, index) {
//         final file = reportStatementController.list.value[index];
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
