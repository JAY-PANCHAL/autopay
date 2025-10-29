// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/session_related_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class SessionRelatedScreen extends StatefulWidget {
//   @override
//   State<SessionRelatedScreen> createState() => _SessionRelatedScreenState();
// }

// class _SessionRelatedScreenState extends State<SessionRelatedScreen> {
//   // Variables to hold session details (to be fetched from DB later)
//   final String morningSessionStart = "06:00 AM";

//   final String morningSessionEnd = "10:00 AM";

//   final String eveningSessionStart = "04:00 PM";

//   final String eveningSessionEnd = "08:00 PM";

//   final String sessionGraceTime = "15 Minutes";

//   var istablet = Utils.checkTablet();

//   SessionRelatedController sessionRelatedController =
//       Get.put(SessionRelatedController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     sessionRelatedController.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Session Related",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         backgroundColor: AppColors.appColor,
//       ),
//       body: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(12.w),
//           child: ListView(
//             children: [
//               buildSessionTile("Morning Session Starts At  :",
//                   sessionRelatedController.morningSessionStart.value),
//               buildSessionTile("Morning Session Ends At  :",
//                   sessionRelatedController.morningSessionEnd.value),
//               buildSessionTile("Evening Session Starts At  :",
//                   sessionRelatedController.eveningSessionStart.value),
//               buildSessionTile("Evening Session Ends At  :",
//                   sessionRelatedController.eveningSessionEnd.value),
//               buildSessionTile("Session Grace Time  :",
//                   sessionRelatedController.sessionGraceTime.value),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// **Reusable ListTile for displaying session details**
//   Widget buildSessionTile(String title, String value) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       child: ListTile(
//         contentPadding: EdgeInsets.symmetric(
//             vertical: istablet ? 14.h : 8.h, horizontal: istablet ? 10.w : 8.w),
//         leading: Icon(Icons.schedule, color: AppColors.appColor, size: 24.sp),
//         title: Text(title, style: TextStyle(fontSize: 16.sp)),
//         trailing: Text(value,
//             style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }
