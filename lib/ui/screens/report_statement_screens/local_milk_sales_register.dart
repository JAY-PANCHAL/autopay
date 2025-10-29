// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/local_milk_sales_register_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class LocalMilkSalesRegisterScreen extends StatefulWidget {
//   @override
//   _LocalMilkSalesRegisterScreenState createState() =>
//       _LocalMilkSalesRegisterScreenState();
// }

// class _LocalMilkSalesRegisterScreenState
//     extends State<LocalMilkSalesRegisterScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   LocalMilkSalesReportController localMilkSalesReportController =
//       Get.put(LocalMilkSalesReportController());

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Local Milk Sales Register",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//     return Visibility(
//     visible: localMilkSalesReportController.moDairyRegister.isNotEmpty,
//     child: GestureDetector(
//     onTap: () {
//     ExcelService.exportLocalMilkSaleToDownloadsFolder(
//     localMilkSalesReportController.moDairyRegister,
//     DateFormat('yyyy-MM-dd').format(DateTime.now()),
//     "LocalMilkSale");
//     },
//     child: Icon(Icons.share)),
//     );
//     }),
//           Utils.addHGap(20)
//         ],
//       ),
//       body: Obx(
//         () => Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: localMilkSalesReportController.formKey,
//             child: Column(
//               children: [
//                 // Start Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => localMilkSalesReportController
//                       .updateStartDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "Start Date",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Start Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 // End Date
//                 FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => localMilkSalesReportController
//                       .updateEndDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "End Date",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "End Date is required"),
//                 ),
//                 Utils.addGap(istablet ? 16 : 15),
//                 localMilkSalesReportController.moDairyRegister.isEmpty
//                     ? Container()
//                     : Expanded(child: buildListView())
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Row(
//         children: [
//           // Cancel Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//           // Start Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 localMilkSalesReportController.submitForm();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: localMilkSalesReportController.moDairyRegister.value.length,
//       itemBuilder: (context, index) {
//         final file =
//             localMilkSalesReportController.moDairyRegister.value[index];
//         return InkWell(
//           onTap: () {},
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//             elevation: 3,
//             child: ListTile(
//               contentPadding: EdgeInsets.all(10.w),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Date: ${file.entryDate}",
//                       style: TextStyle(
//                           fontSize: 14.sp, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5.h),
//                   Text("SSN: ${file.session ?? ""}"),
//                   Text("Cattle: ${file.category ?? ""}"),
//                   Text("Liters: ${file.localWeight?.toString() ?? ""}"),
//                   Text("Rate: ${file.localRate?.toString() ?? ""}"),
//                   Text("Amount: ${file.localAmount?.toString() ?? ""}"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
