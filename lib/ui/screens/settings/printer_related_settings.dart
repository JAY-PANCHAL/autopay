// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class PrinterSettingsScreen extends StatefulWidget {
//   const PrinterSettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<PrinterSettingsScreen> createState() => _PrinterSettingsScreenState();
// }

// class _PrinterSettingsScreenState extends State<PrinterSettingsScreen> {
//   var istablet = Utils.checkTablet();
//   RxString selectedPageWidth = 'Two Inches'.obs;
//   var selectedPrinterType = "TVS".obs; // Default value set to "TVS"
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Printer Settings",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         backgroundColor: AppColors.appColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: ListView(
//           children: [
//             _buildListTile("Connect Printer", Icons.bluetooth, () {}),
//             _buildListTile("Set Printer Page Width", Icons.straighten, showSetPrinterPageWidthDialog),
//             _buildListTile("Set Printer Type", Icons.print,   showSetPrinterTypeDialog,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       child: ListTile(
//         contentPadding: EdgeInsets.symmetric(
//             vertical: istablet ? 14.h : 8.h, horizontal: istablet ? 10.w : 8.w),
//         leading: Icon(icon, color: AppColors.appColor, size: 24.sp),
//         title: Text(title, style: TextStyle(fontSize: 16.sp)),
//         trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
//         onTap: onTap,
//       ),
//     );
//   }

//   void showSetPrinterPageWidthDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Set Printer Page Width"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Obx(() => RadioListTile<String>(
//               title: Text("Two Inches"),
//               value: "Two Inches",
//               groupValue: selectedPageWidth.value,
//               onChanged: (value) {
//                 selectedPageWidth.value = value!;
//               },
//             )),
//             Obx(() => RadioListTile<String>(
//               title: Text("Four Inches"),
//               value: "Four Inches",
//               groupValue: selectedPageWidth.value,
//               onChanged: (value) {
//                 selectedPageWidth.value = value!;
//               },
//             )),
//             Obx(() => RadioListTile<String>(
//               title: Text("Eight Inches"),
//               value: "Eight Inches",
//               groupValue: selectedPageWidth.value,
//               onChanged: (value) {
//                 selectedPageWidth.value = value!;
//               },
//             )),
//           ],
//         ),
//         actions: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     color: Colors.red,
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: GestureDetector(
//                   onTap: () {
//                     print("Selected Page Width: ${selectedPageWidth.value}");
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     color: Colors.green,
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Set",
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   void showSetPrinterTypeDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Set Printer Type"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Obx(() => RadioListTile<String>(
//               title: Text("TVS"),
//               value: "TVS",
//               groupValue: selectedPrinterType.value,
//               onChanged: (value) {
//                 selectedPrinterType.value = value!;
//               },
//             )),
//             Obx(() => RadioListTile<String>(
//               title: Text("Epson"),
//               value: "Epson",
//               groupValue: selectedPrinterType.value,
//               onChanged: (value) {
//                 selectedPrinterType.value = value!;
//               },
//             )),
//           ],
//         ),
//         actions: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: GestureDetector(
//                   onTap: (){
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     color: Colors.red,
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: GestureDetector(
//                   onTap: () {
//                     print("Selected Printer Type: ${selectedPrinterType.value}");

//                     Navigator.of(context, rootNavigator: true).pop();
//                     //  Get.back();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     color: Colors.green,
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Set",
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRadioOption(String value) {
//     return Obx(() => RadioListTile<String>(
//       title: Text(value, style: TextStyle(fontSize: 16.sp)),
//       value: value,
//       groupValue: selectedPageWidth.value,
//       onChanged: (val) {
//         selectedPageWidth.value = val!;
//       },
//     ));
//   }
// }
