// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/union_truck_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class TruckSlipConfirmation extends StatefulWidget {
//   const TruckSlipConfirmation({Key? key}) : super(key: key);

//   @override
//   State<TruckSlipConfirmation> createState() => _TruckSlipConfirmationState();
// }

// class _TruckSlipConfirmationState extends State<TruckSlipConfirmation> {
//   var istablet = Utils.checkTablet();
//   UnionTruckController unionTruckController = UnionTruckController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     unionTruckController.getTruckEntry();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Utils.normalText("Union Truck Slip Entry",
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
//             Utils.addGap(15),
//             Padding(
//               padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
//               child: FormBuilder(
//                 key: unionTruckController.formKey,
//                 child: FormBuilderDateTimePicker(
//                   name: "date",
//                   style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                   initialValue: DateTime.now(),
//                   onChanged: (value) =>
//                       unionTruckController.updateDate(value ?? DateTime.now()),
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
//             //TO DO -----------------------Remove below code when you get data--------------------------

//             Utils.addGap(istablet ? 16 : 15),
//             unionTruckController.moDairyRegister.value.isEmpty
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
//                               _buildHeaderCell("Vol",false),
//                               _buildHeaderCell("Fat",false),
//                               _buildHeaderCell("SNF",false),
//                               _buildHeaderCell("Amt",false),
//                               //  _buildHeaderCell("Sync"),
//                             ],
//                           ),
//                           const SizedBox(height: 10),

//                           // Row of values (each entry is a column)
//                           Column(
//                             children: unionTruckController.moDairyRegister.value
//                                 .map((entry) {
//                               return Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildDataCell(entry.entryDate ?? "",true),
//                                   _buildDataCell(entry.session ?? "",false),
//                                   _buildDataCell(entry.category ?? "",false),
//                                   _buildDataCell(
//                                       entry.saleGood1Weight.toString() ?? "",false),
//                                   _buildDataCell(
//                                       entry.saleGood1Fat.toString() ?? "",false),
//                                   _buildDataCell(
//                                       entry.saleGood1SNF.toString() ?? "",false),
//                                   _buildDataCell(
//                                       entry.saleGood1Amount.toString() ?? "",false),
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



//               setState(() {

//                 Get.toNamed(Routes.newEntryUnionTruckSlip)
//                     ?.then((value){
//                   unionTruckController.getTruckEntry();
//                 });

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
