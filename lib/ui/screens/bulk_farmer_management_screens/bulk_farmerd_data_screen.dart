// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BulkFarmerDataScreen extends StatefulWidget {
//   const BulkFarmerDataScreen({Key? key}) : super(key: key);

//   @override
//   State<BulkFarmerDataScreen> createState() => _BulkFarmerDataScreenState();
// }

// class _BulkFarmerDataScreenState extends State<BulkFarmerDataScreen> {
//   var istablet = Utils.checkTablet();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Bulk Farmer Data",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //TO DO -----------------------Remove below code when you get data--------------------------
//           Utils.addGap(250),
//           Center(
//             child: Utils.normalText("No Records Found",
//                 size: istablet ? 3.sp : 16.sp, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
