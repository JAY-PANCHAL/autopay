// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/deduction_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class DeductionEntry extends StatefulWidget {
//   const DeductionEntry({Key? key}) : super(key: key);

//   @override
//   State<DeductionEntry> createState() => _DeductionEntryState();
// }

// class _DeductionEntryState extends State<DeductionEntry> {
//   var istablet = Utils.checkTablet();
//   DeductionController deductionController = Get.put(DeductionController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Deduction Entry",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         backgroundColor: AppColors.appColor,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Utils.addGap(15),
//           Padding(
//             padding: EdgeInsets.only(left: 10.sp),
//             child: SizedBox(width: 150.sp, child: _buildDateField()),
//           ),
//           //TO DO -----------------------Remove below code when you get data--------------------------
//           Utils.addGap(20),
//         /*  deductionController.deductionEntries.value.length > 0
//               ? SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Row of titles
//                         Row(
//                           children: [
//                             _buildHeaderCell("Date"),
//                             _buildHeaderCell("Mem Code"),
//                             _buildHeaderCell("Cans"),
//                             _buildHeaderCell("Volume"),
//                             // _buildHeaderCell("Fat%"),
//                             // _buildHeaderCell("SNF%"),
//                             // _buildHeaderCell("Rate"),
//                             _buildHeaderCell("Kg Volume"),
//                             //  _buildHeaderCell("Sync"),
//                           ],
//                         ),
//                         const SizedBox(height: 10),

//                         //Row of values (each entry is a column)
//                         Column(
//                           children: deductionController.deductionEntries.value
//                               .map((entry) {
//                             return Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildDataCell(_formatDate(entry.voucherDate ?? "")),
//                                 _buildDataCell(entry.memberCode ?? ""),
//                                 _buildDataCell(
//                                     entry.qty.toString() ?? ""),
//                                 // volume = mContext.getResources().getString(R.string.volume) + " :&nbsp;<b>" + decimalFormat.format(oDairyRegister.getDispatchNoteWeight()/
//                                 //         (oDairyRegister.getDispatchNoteCan()*1.03)) + "</b>";
//                                 _buildDataCell(
//                                     "${(entry.rate ?? 0.0)}"),
//                                 _buildDataCell(
//                                     entry.amount.toString() ?? ""),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : Container()*/
//           buildDeductionListView(),
//         ],
//       ),
//       floatingActionButton: Container(
//         height: istablet ? 40.h : 50.h,
//         width: istablet ? 40.w : 50.w,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.appColor,
//           onPressed: () {
//             setState(() {
//               Get.toNamed(Routes.deductionEntryDetail);
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
//   Widget buildDeductionListView() {
//     return deductionController.deductionEntries.value.isNotEmpty
//         ? Obx(
//            () {
//             return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: deductionController.deductionEntries.value.length,
//                   itemBuilder: (context, index) {
//             final entry = deductionController.deductionEntries.value[index];

//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoRow("Date", _formatDate(entry.voucherDate ?? "")),
//                   _buildInfoRow("Member Code", entry.memberCode ?? ""),
//                   _buildInfoRow("Cans", entry.qty.toString()),
//                   _buildInfoRow("Volume", (entry.rate ?? 0.0).toString()),
//                   _buildInfoRow("Kg Volume", entry.amount.toString()),
//                 ],
//               ),
//             );
//                   },
//                 );
//           }
//         )
//         : const Center(child: Text("No deductions available"));
//   }
//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(
//             "$title: ",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.black54,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
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

//   Widget _buildHeaderCell(String title) {
//     return Container(
//       width: 80.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildDataCell(String value) {
//     return Container(
//       width: 80.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(value),
//     );
//   }
//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd-MM').format(date);
//     } catch (e) {
//       return dateStr; // fallback if format fails
//     }
//   }
// }
