// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/share_register_model.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';

// class ShareRegisterScreen extends StatefulWidget {
//   @override
//   _ShareRegisterScreenState createState() => _ShareRegisterScreenState();
// }

// class _ShareRegisterScreenState extends State<ShareRegisterScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   var shareRegisterList = <MShareRegister>[].obs;

//   Rx<DateTime?> selDate = Rx<DateTime?>(null);
//   RxString selDateFormat = "".obs;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Share Register",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//               return Visibility(
//                 visible: shareRegisterList.isNotEmpty,
//                 child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportShareRegisterToDownloadsFolder(
//                       shareRegisterList,
//                       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                       "ShareRegister",
//                     );
//                   },
//                   child: Icon(Icons.share),
//                 ),
//               );
//             }),
//             Utils.addHGap(20),
//           ],

//         ),
//         body: Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Start Date
//                 _buildDateField("date", "Date", selDate, selDateFormat),
//                 Utils.addGap(20),
//                 shareRegisterList.value.length > 0
//                     ? ListView.builder(
//                         itemCount: shareRegisterList.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final item = shareRegisterList[index];
//                           return Padding(
//                             padding: EdgeInsets.symmetric(vertical: 5.sp),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     blurRadius: 5,
//                                     spreadRadius: 2,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               padding: EdgeInsets.all(12.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildItemRow("Date", item.date ?? ""),
//                                   _buildItemRow("Mem Code", item.memCode ?? ""),
//                                   _buildItemRow("Location Code",
//                                       item.locationCode.toString()),
//                                   _buildItemRow("Share Quality",
//                                       item.shareQuality.toString()),
//                                   _buildItemRow(
//                                       "Share Amount", "₹${item.shareAmount}"),
//                                   _buildItemRow("Total", "₹${item.total}"),
//                                   _buildItemRow("Share", item.share.toString()),
//                                   _buildItemRow("Chiller Amount",
//                                       "₹${item.shareChillerAmount}"),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                     : Center(
//                         child: Utils.normalText("No Records Found",
//                             size: istablet ? 3.sp : 16.sp, color: Colors.grey),
//                       ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: Container(
//           height: istablet ? 40.h : 50.h,
//           width: istablet ? 40.w : 50.w,
//           child: FloatingActionButton(
//             backgroundColor: AppColors.appColor,
//             onPressed: () {
//               setState(() {
//                 Get.toNamed(Routes.shareRegisterEntryScreen);
//               });
//             },
//             child: Icon(
//               Icons.add,
//               size: istablet ? 16.sp : 18.sp,
//             ),
//           ),
//         ),
//         bottomNavigationBar: Row(
//           children: [
//             // Cancel Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//             // Start Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     final formData = _formKey.currentState!.value;
//                     print("Form Data: $formData");

//                     // Get.toNamed(Routes.milkCollectionEntryScreen);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildDateField(String name, String label, Rx<DateTime?> dateValue,
//       RxString formattedDateValue) {
//     return Obx(() => GestureDetector(
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: Get.context!,
//               initialDate: dateValue.value ?? DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );

//             if (pickedDate != null) {
//               dateValue.value = pickedDate;
//               formattedDateValue.value =
//                   DateFormat("yyyy-MM-dd").format(pickedDate);
//               displayData();
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   formattedDateValue.value.isNotEmpty
//                       ? formattedDateValue.value
//                       : label,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: formattedDateValue.value.isNotEmpty
//                         ? Colors.black
//                         : Colors.black54,
//                   ),
//                 ),
//                 Icon(Icons.calendar_today, color: Colors.grey),
//               ],
//             ),
//           ),
//         ));
//   }

//   displayData() async {
//     String query = "SELECT * FROM ShareRegister WHERE Date = '$selDateFormat'";
//     shareRegisterList.value = await DBHelper().getShareRegister(query);
//   }

//   Widget _buildItemRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 3.sp),
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: "$title: ",
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//             ),
//             TextSpan(
//               text: value,
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
