// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/local_sales_entry_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../db/db_helper.dart';

// class LocalSalesEntryScreen extends StatefulWidget {
//   @override
//   State<LocalSalesEntryScreen> createState() => _LocalSalesEntryScreenState();
// }

// class _LocalSalesEntryScreenState extends State<LocalSalesEntryScreen> {
//   final LocalSalesEntryController controller =
//       Get.put(LocalSalesEntryController());

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

//   @override
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
//         title: Utils.normalText("Local Sales Entry",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // **FormBuilder**
//                 FormBuilder(
//                   key: controller.formKey,
//                   child: Column(
//                     children: [
//                       // **Date Picker**
//                       FormBuilderDateTimePicker(
//                         name: "date",
//                         style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                         initialValue: DateTime.now(),
//                         onChanged: (value) =>
//                             controller.updateDate(value ?? DateTime.now()),
//                         inputType: InputType.date,
//                         format: DateFormat('dd/MM/yyyy'),
//                         decoration: InputDecoration(
//                           labelText: "Date Selection",
//                           border: OutlineInputBorder(),
//                           suffixIcon: Icon(Icons.calendar_today),
//                         ),
//                         validator: FormBuilderValidators.required(
//                             errorText: "Date is required"),
//                       ),

//                       Utils.addGap(istablet ? 16 : 15),

//                       // **Session Dropdown**
//                       FormBuilderDropdown(
//                         name: "session",
//                         style: TextStyle(
//                           fontSize: istablet ? 9.sp : 16.sp,
//                           color: Colors.black,
//                         ),
//                         initialValue: "Morning",
//                         decoration: InputDecoration(
//                           labelText: "Session",
//                           labelStyle: TextStyle(
//                             fontSize: istablet ? 12.sp : 16.sp,
//                           ),
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) => controller.updateSession(value!),
//                         items: ["Morning", "Evening"]
//                             .map((session) => DropdownMenuItem(
//                                 value: session, child: Text(session)))
//                             .toList(),
//                         validator: FormBuilderValidators.required(
//                             errorText: "Session is required"),
//                       ),

//                       Utils.addGap(istablet ? 16 : 15),

//                       // **Cattle Dropdown**
//                       FormBuilderDropdown(
//                         name: "cattle",
//                         style: TextStyle(
//                           fontSize: istablet ? 9.sp : 16.sp,
//                           color: Colors.black,
//                         ),
//                         initialValue: controller.selectedCattle.value,
//                         onChanged: (value) =>
//                             controller.updateCattle(value as String),
//                         items: ["Buffalo", "Cow"]
//                             .map((cattle) => DropdownMenuItem(
//                                 value: cattle, child: Text(cattle)))
//                             .toList(),
//                         decoration: InputDecoration(
//                             labelText: "Cattle",
//                             labelStyle: TextStyle(
//                               fontSize: istablet ? 12.sp : 16.sp,
//                             ),
//                             border: OutlineInputBorder()),
//                         validator: FormBuilderValidators.required(
//                             errorText: "Cattle type is required"),
//                       ),

//                       Utils.addGap(istablet ? 16 : 15),

//                       // **Volume Field**
//                       _buildTextField("volume", "Volume", controller.volume,
//                           controller.updateVolume, true),

//                       Utils.addGap(istablet ? 16 : 15),

//                       // **Rate Field**
//                       _buildTextField("rate", "Rate", controller.rate,
//                           controller.updateRate, true),

//                       Utils.addGap(istablet ? 16 : 15),

//                       // **Amount Field**
//                       _buildTextField("amount", "Amount", controller.amount,
//                           controller.updateAmount, false),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 16),
//               ],
//             ),
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
//                   submitForm();
// /*
//                   if (controller.isSuccess.value) {
//                     print("is Success called");
//                     controller.volume.value = "";
//                     controller.rate.value = "";
//                     controller.amount.value = "0";
//                     controller.formKey.currentState?.reset();
//                     // Do not call the dialog here anymore, handled by Obx
//                   }
//                   controller.isSuccess.value = false;*/
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
//           title: Text("Local Sale Entry Update Done"),
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
//               Text("💰 Rate: ₹${controller.rate.value}"),
//               SizedBox(height: 8),
//               Text("🧾 Amount: ₹${controller.amount.value}",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);

//                   controller.clearFormFields();
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

//   /// **Builds a text field with validation**
//   Widget _buildTextField(String name, String label, RxString value,
//       Function(String) onChanged, bool isEnabled) {
//     return FormBuilderTextField(
//       name: name,
//       enabled: isEnabled,
//       textInputAction: TextInputAction.next,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       initialValue: value.value,
//       // ✅ Access .value inside Obx
//       onChanged: (newValue) => onChanged(newValue ?? ""),
//       keyboardType: TextInputType.number,
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
//   void submitForm() async {
//     if (controller.formKey.currentState!.saveAndValidate()) {
//       final formData = controller.formKey.currentState!.value;
//       // final formData = formKey.currentState!.value;
//       // print("Form Submitted: $formData");
//       // bool isRecordInserted = await entryFun();
//       // bool isRecordDeleted = await deleteFun();
//       controller.selectedSession.value = formData["session"];
//       controller. session.value = controller.selectedSession.value == "Morning" ? "M" : "E";
//       controller.cattle.value = controller.selectedCattle.value == "Buffalo" ? "B" : "C";
//       bool isRecordSelected = await controller.selectIfDataExists();

//       if (isRecordSelected && controller.purchaseMilkWeight.value != "0.0") {
//         if (double.parse(controller.purchaseMilkWeight.value) >
//             double.parse(controller.volume.value)) {
//           //Query to get local weight or sale voulme and then store it in oldweigh.value
//           //   bool isRecordExists = await selectLocalWeightExists();
//           String query =
//               "Select LocalWeight FROM ODairyRegister WHERE Code='${controller.oDairyCode.value}'";
//           String saleVolume =
//           await DBHelper().getScalarQueryStringFromDB(query);

//           controller. oldWeight.value = double.tryParse(saleVolume) ?? 0.0;

//           // if (isRecordExists) {
//           //   oldWeight.value = double.parse(localWeight.value);
//           if (controller.oldWeight.value == 0.0 ||
//               controller.  oldWeight.value + double.parse(controller.volume.value) <=
//                   double.parse(controller.purchaseMilkWeight.value)) {
//             bool result = await controller.updateODairyRegisterIfRecordsNotExists();


//           } else {
//             print("No Remaining. You sold all milk. ");
//             Utils.showToast("No Remaining. You sold all milk. ");
//             return;
//           }
//           // } else {
//           //   print("No Record for local weight Found");
//           //   Utils.showToast("No Record for local weight Found");
//           // }
//         } else {
//           print("Volume should be greater than Purchase Milk Weight");
//           Utils.showToast("Volume should be greater than Purchase Milk Weight");
//         }
//       } else {
//         print("No Milk available for local sale");
//         Utils.showToast("No Milk available for local sale");
//       }
//       // bool isRecordDeleted = await deleteFun();
//     } else {
//       debugPrint("Form Validation Failed!");
//     }
//   }

// }
