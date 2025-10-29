// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/dispatch_slip_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class DispatchSalesScreen extends StatefulWidget {
//   const DispatchSalesScreen({Key? key}) : super(key: key);

//   @override
//   State<DispatchSalesScreen> createState() => _DispatchSalesScreenState();
// }

// class _DispatchSalesScreenState extends State<DispatchSalesScreen> {
//   var istablet = Utils.checkTablet();
//   DispatchSlipController dispatchSlipController =
//       Get.put(DispatchSlipController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dispatchSlipController.getDispatchSlip();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Dispatch Slip Entry",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         backgroundColor: AppColors.appColor,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Utils.addGap(15),
//             // Padding(
//             //   padding: EdgeInsets.only(left: 10.sp),
//             //   child: SizedBox(width: 150.sp, child: _buildDateField()),
//             // ),
//             // //TO DO -----------------------Remove below code when you get data--------------------------
//             // Utils.addGap(200),
//             // Center(
//             //   child: Utils.normalText("No Records Found",
//             //       size: istablet ? 3.sp : 16.sp, color: Colors.grey),
//             // ),
//             Utils.addGap(istablet ? 16 : 18),
//             Padding(
//               padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
//               child: FormBuilder(
//                 key: dispatchSlipController.formKey,
//                 child: FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) => dispatchSlipController
//                       .updateDate(value ?? DateTime.now()),
//                   inputType: InputType.date,
//                   format: DateFormat('dd/MM/yyyy'),
//                   decoration: InputDecoration(
//                     labelText: "Date Selection",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: FormBuilderValidators.required(
//                       errorText: "Date is required"),
//                 ),
//               ),
//             ),

//             Utils.addGap(istablet ? 16 : 15),
//             dispatchSlipController.moDairyRegister.value.isEmpty
//                 ? Column(
//                     children: [
//                       // Utils.addGap(100),
//                       // Center(child: Text("No Records Found")),
//                     ],
//                   )
//                 : SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Row of titles
//                           Row(
//                             children: [
//                               _buildHeaderCell("Date",true),
//                               _buildHeaderCell("Shift",false),
//                               _buildHeaderCell("Cat",false),
//                               _buildHeaderCell("Cans",false),
//                               _buildHeaderCell("Vol",false),
//                               // _buildHeaderCell("Fat%"),
//                               // _buildHeaderCell("SNF%"),
//                               // _buildHeaderCell("Rate"),
//                               _buildHeaderCell("Kg Vol",false),
//                               //  _buildHeaderCell("Sync"),
//                             ],
//                           ),
//                           const SizedBox(height: 10),

//                           // Row of values (each entry is a column)
//                           Column(
//                             children: dispatchSlipController
//                                 .moDairyRegister.value
//                                 .map((entry) {
//                               return Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildDataCell(entry.entryDate ?? "",true),
//                                   _buildDataCell(entry.session ?? "",false),
//                                   _buildDataCell(entry.category ?? "",false),
//                                   _buildDataCell(
//                                       entry.dispatchNoteCan.toString() ?? "",false),
//                                   // volume = mContext.getResources().getString(R.string.volume) + " :&nbsp;<b>" + decimalFormat.format(oDairyRegister.getDispatchNoteWeight()/
//                                   //         (oDairyRegister.getDispatchNoteCan()*1.03)) + "</b>";
//                                   _buildDataCell(
//                                     "${((entry.dispatchNoteWeight ?? 0.0) / (entry.dispatchNoteCan ?? 1.0) * 1.03).toStringAsFixed(2)}",
//                                       false),
//                                   _buildDataCell(
//                                       entry.dispatchNoteWeight.toString() ??
//                                           "",false),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//       floatingActionButton: Container(
//         height: istablet ? 40.h : 50.h,
//         width: istablet ? 40.w : 50.w,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.appColor,
//           onPressed: () {
//             setState(() {

//               Get.toNamed(Routes.dispatchSalesEntryScreen)
//               ?.then((value){
//                 dispatchSlipController.getDispatchSlip();
//               });
//             });
//           },
//           child: Icon(
//             Icons.add,
//             size: istablet ? 16.sp : 18.sp,
//           ),
//         ),
//       ),
//     );
//   }

//   /// **Builds a Date Field**
//   Widget _buildDateField() {
//     return FormBuilderDateTimePicker(
//       name: "date",
//       style: TextStyle(fontSize: istablet ? 12.sp : 16.sp),
//       initialValue: DateTime.now(),
//       inputType: InputType.date,
//       format: DateFormat('dd/MM/yyyy'),
//       decoration: InputDecoration(
//         labelText: "Date Selection",
//         border: OutlineInputBorder(),
//         suffixIcon: Icon(Icons.calendar_today),
//       ),
//       validator: FormBuilderValidators.required(errorText: "Date is required"),
//     );
//   }

//   Widget _buildHeaderCell(String title,bool isDate) {
//     return Container(
//       width: isDate?100.sp:80.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildDataCell(String value,bool isDate) {
//     return Container(
//       width: isDate?100.sp:80.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(value),
//     );
//   }
// }
