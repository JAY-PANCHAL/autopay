// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PrintDuplicate extends StatefulWidget {
//   const PrintDuplicate({Key? key}) : super(key: key);

//   @override
//   State<PrintDuplicate> createState() => _PrintDuplicateState();
// }

// class _PrintDuplicateState extends State<PrintDuplicate> {
//   var istablet = Utils.checkTablet();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Print Duplicate",
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
