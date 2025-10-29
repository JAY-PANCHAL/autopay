// import 'dart:ffi';

// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/dispatch_slip_entry_controller.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class DispatchSlipEntryScreen extends StatefulWidget {
//   @override
//   State<DispatchSlipEntryScreen> createState() =>
//       _DispatchSlipEntryScreenState();
// }

// class _DispatchSlipEntryScreenState extends State<DispatchSlipEntryScreen> {
//   final DispatchSlipEntryController controller =
//       Get.put(DispatchSlipEntryController());

//   var istablet = Utils.checkTablet();

//   void setSession() {
//     DateTime now = DateTime.now();

//     // Set 4:00 PM as the threshold time
//     DateTime eveningStartTime =
//         DateTime(now.year, now.month, now.day, 16, 0); // 4:00 PM

//     if (now.isBefore(eveningStartTime)) {
//       controller.formKey.currentState?.fields['session']?.didChange("Morning");
//     } else {
//       controller.formKey.currentState?.fields['session']?.didChange("Evening");
//     }
//   }

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setSession();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Dispatch Slip Entry",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//         child: FormBuilder(
//           key: controller.formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // **Date Selection**
//               FormBuilderDateTimePicker(
//                 name: "date",
//                 style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                 initialValue: DateTime.now(),
//                 inputType: InputType.date,
//                 onChanged: (value) =>
//                     controller.updateDate(value ?? DateTime.now()),
//                 format: DateFormat('dd/MM/yyyy'),
//                 decoration: InputDecoration(
//                   labelText: "Date Selection",
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: FormBuilderValidators.required(
//                     errorText: "Date is required"),
//               ),

//               Utils.addGap(istablet ? 16 : 15),

//               // **Session Dropdown**
//               FormBuilderDropdown(
//                 name: "session",
//                 style: TextStyle(
//                   fontSize: istablet ? 9.sp : 16.sp,
//                   color: Colors.black,
//                 ),
//                 initialValue: "Morning",
//                 decoration: InputDecoration(
//                   labelText: "Session",
//                   labelStyle: TextStyle(
//                     fontSize: istablet ? 12.sp : 16.sp,
//                   ),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) => controller.updateSession(value!),
//                 items: ["Morning", "Evening"]
//                     .map((session) =>
//                         DropdownMenuItem(value: session, child: Text(session)))
//                     .toList(),
//                 validator: FormBuilderValidators.required(
//                     errorText: "Session is required"),
//               ),

//               Utils.addGap(istablet ? 16 : 15),

//               // **Cattle Dropdown**
//               Obx(() => FormBuilderDropdown(
//                     name: "cattle",
//                     style: TextStyle(
//                       fontSize: istablet ? 9.sp : 16.sp,
//                       color: Colors.black,
//                     ),
//                     initialValue: controller.selectedCattle.value,
//                     items: ["Buffalo", "Cow"]
//                         .map((cattle) => DropdownMenuItem(
//                             value: cattle, child: Text(cattle)))
//                         .toList(),
//                     onChanged: (value) => controller.updateCattle(value!),
//                     decoration: InputDecoration(
//                       labelText: "Cattle",
//                       border: OutlineInputBorder(),
//                       labelStyle: TextStyle(
//                         fontSize: istablet ? 12.sp : 16.sp,
//                       ),
//                     ),
//                   )),

//               Utils.addGap(istablet ? 16 : 15),
//               // **Volume Field**
//               Obx(() => _buildTextField("cans", "cans", controller.cans, true,
//                   controller.updateCans)),

//               Utils.addGap(istablet ? 16 : 15),
//               // **Volume Field**
//               Obx(() => _buildTextField("volume", "Volume", controller.volume,
//                   true, controller.updateVolume)),

//               Utils.addGap(istablet ? 16 : 15),

//               // **Kg Volume Field**
//               Obx(() => _buildTextField("kgVolume", "Kg Volume",
//                   controller.kgVolume, false, controller.updateKgVolume)),

//               // **Submit & Cancel Buttons**
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Obx(() {
//         if (controller.isSuccess.value) {
//           // Show the dialog when success is true
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             showAutoDismissDialog(context);
//             controller.isSuccess.value =
//                 false; // Reset it after showing the dialog
//           });
//         }

//         return Row(
//           children: [
//             // Cancel Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () => Get.back(),
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

//             // Submit Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   controller.submitForm();
//                   // if (controller.isSuccess.value) {
//                   //   // Do not call the dialog here anymore, handled by Obx
//                   // }
//                   controller.isSuccess.value = false;
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),

// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           String query = '''
// // INSERT INTO ODairyRegister (
// //     AutoId, LocationCode, CompanyCode, EntryDate, Session, Category,
// //     LastCanNo, LastCanLiter, LocalEntryUserId, LocalEntryTime, LocalWeight, LocalRate, LocalAmount,
// //     IsLocalSaleByCoupon, SaleGood1Weight, SaleGood1Fat, SaleGood1SNF, SaleGood1KgFat, SaleGood1Rate, SaleGood1Amount,
// //     SaleGood2Weight, SaleGood2Fat, SaleGood2SNF, SaleGood2KgFat, SaleGood2Rate, SaleGood2Amount,
// //     SaleSourWeight, SaleSourFat, SaleSourSNF, SaleSourKgFat, SaleSourRate, SaleSourAmount,
// //     SaleCurdWeight, SaleCurdFat, SaleCurdSNF, SaleCurdKgFat, SaleCurdRate, SaleCurdAmount,
// //     SaleEntryTime, SaleEntryUserId, DairyAmount, DairyKgFatRate, DairyRate, ExpectedDairyWeight,
// //     ExpectedDairyAmount, ExpectedDairyKgFatRate, ExpectedDairyRate, ExpectedProfitAmount,
// //     PurchaseGoodRate1, PurchaseGoodRate2, PurchaseGoodRate3, PurchaseCommission,
// //     AutoWeightPercent, AutoFatPercent, ManualWeightPercent, ManualFatPercent,
// //     TotalSample, TotalCan, IsTruckSlipEntry, MixedAutoId, BillFromDate, BillToDate,
// //     EntryUserId, DispatchVoucherNo, DispatchNoteCan, DispatchNoteWeight, DispatchNoteFat, DispatchNoteSNF,
// //     DispatchNoteEntryUserId, DispatchNoteEntryTime, IsManualDispatchNote, IsMixAmount, Notes, Remark, LastUpdate,
// //     NoDisplay, SaleGood1Can, SaleGood2Can, SaleSourCan, SaleCurdCan, SyncDateTime, MilkSlipMessage,
// //     IsDelete, IsEdit, MilkDispatchAutoId, PurchaseMilkMembers, PurchaseMilkWeight, PurchaseMilkFat,
// //     PurchaseMilkSNF, PurchaseMilkAmount, isSync
// // ) VALUES (
// //     1, 101, 1001,'2025-03-27','M','B',
// //     5, 50.0, 1, '2025-03-17 08:00:00', 100.0, 50.0, 5000.0,
// //     0, NULL, NULL, 8.5, NULL, 45.0, 900.0,
// //     15.0, 4.2, 8.2, 0.8, 42.0, 630.0,
// //     10.0, 3.8, 7.8, 0.7, 38.0, 380.0,
// //     8.0, 3.5, 7.5, 0.6, 35.0, 280.0,
// //     '2025-03-17 09:00:00', 2, 2000.0, 42.5, 40.0, 95.0,
// //     3800.0, 40.0, 38.0, 200.0,
// //     35.0, 33.0, 30.0, 5.0,
// //     98.0, 3.2, 97.0, 3.5,
// //     10, 5, 0, 2, '2025-03-17', '2025-03-18',
// //     3, NULL, 2, NULL, 4.0, 8.0,
// //     4, '2025-03-17 10:00:00', 0, 1, 'No issues', 'Good quality', '2025-03-17 11:00:00',
// //     0, 3, 2, 1, 1, '2025-03-17 12:00:00', 'Milk ready',
// //     0, 0, 10, 5, 200.0, 4.0,
// //     8.0, 760.0, 1
// // );
// //   ''';
// //           int result = await DBHelper().executeRawInsertQuery(query);
// //           print(result);
// //         },
// //       ),
//     );
//   }

//   void showAutoDismissDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         // Automatically dismiss the dialog after 3 seconds
//         /* Future.delayed(Duration(seconds: 3), () {
//           if (Navigator.canPop(context)) {
//             Navigator.pop(context);
//           }
//         });*/

//         return AlertDialog(
//           title: Text("Dispatch Sale Entry Update Done"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("📍 date: ${controller.selectedDate.value}"),
//               SizedBox(height: 8),
//               Text("👤 session: ${controller.selectedSession.value} "),
//               SizedBox(height: 8),
//               Text("🐄 Cattle Type: ${controller.selectedCattle.value}"),
//               SizedBox(height: 8),
//               Text("🥛 volume: ${controller.volume.value}"),
//               SizedBox(height: 8),
//               Text("🥛 KG volume: ${controller.kgVolume.value}"),
//               SizedBox(height: 8),
//               Text("🛢️ Cans: ${controller.volume.value}"),
//               // SizedBox(height: 8),
//               // Text("💰 Rate: ₹${controller.rate.value}"),
//               // SizedBox(height: 8),
//               // Text("🧾 Amount: ₹${controller.amount.value}",
//               //     style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 controller.clearFormFields();
//                 // Set focus to liter  field
//                 // WidgetsBinding.instance.addPostFrameCallback((_) {
//                 //   FocusScope.of(context).requestFocus(memberFocus);
//                 // });
//               },
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTextField(String name, String label, RxString value,
//       bool isEnabled, Function(String) onChanged) {
//     return FormBuilderTextField(
//       name: name,
//       enabled: isEnabled,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       initialValue: value.value,
//       onChanged: (newValue) => onChanged(newValue ?? ""),
//       keyboardType: TextInputType.number,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         disabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//       ),
//       validator:
//           FormBuilderValidators.required(errorText: "$label is required"),
//     );
//   }
// }
