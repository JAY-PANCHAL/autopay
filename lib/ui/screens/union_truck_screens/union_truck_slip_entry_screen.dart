// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/union_truck_entry_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class UnionTruckSlipEntryScreen extends StatefulWidget {
//   @override
//   State<UnionTruckSlipEntryScreen> createState() =>
//       _UnionTruckSlipEntryScreenState();
// }

// class _UnionTruckSlipEntryScreenState extends State<UnionTruckSlipEntryScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   final UnionTruckEntryController controller =
//       Get.put(UnionTruckEntryController());

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
//         title: Utils.normalText("Union Truck Slip Entry",
//             size: istablet ? 3.sp : 15.sp, color: Colors.white),
//         backgroundColor: AppColors.appColor,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         // 👈 Prevents keyboard overflow
//         child: Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Utils.addGap(istablet ? 10 : 16),
//               // **Form Inputs**
//               FormBuilder(
//                 key: controller.formKey,
//                 child: Column(
//                   children: [
//                     Utils.addGap(istablet ? 10 : 8),
//                     _buildDateField(),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildDropDownField(["Morning", "Evening"]),
//                     Utils.addGap(istablet ? 16 : 15),
//                     // **Animal Selection**
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildAnimalOption("Buffalo"),
//                         _buildAnimalOption("Cow"),
//                       ],
//                     ),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildTextField(
//                         "cans",
//                         "Cans",
//                         true,
//                         controller.updateCansBuff,
//                         controller.updateCansCow,
//                         controller.selectedCansBuff,
//                         controller.selectedCansCow),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildTextField(
//                         "volume",
//                         "Volume",
//                         true,
//                         controller.updateVolumeBuff,
//                         controller.updateVolumeCow,
//                         controller.selectedVolumeBuff,
//                         controller.selectedVolumeCow),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildTextField(
//                         "fat",
//                         "Fat %",
//                         true,
//                         controller.updateFatBuff,
//                         controller.updateFatCow,
//                         controller.selectedFatBuff,
//                         controller.selectedFatCow),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildTextField(
//                         "snf",
//                         "SNF %",
//                         true,
//                         controller.updateSnfBuff,
//                         controller.updateSnfCow,
//                         controller.selectedSnfBuff,
//                         controller.selectedSnfCow),
//                     Utils.addGap(istablet ? 16 : 15),
//                     _buildTextField(
//                         "amount",
//                         "Amount",
//                         true,
//                         controller.updateAmountBuff,
//                         controller.updateAmountCow,
//                         controller.selectedAmountBuff,
//                         controller.selectedAmountCow),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //     onPressed: (controller.insertODairyRegister), child: Icon(Icons.add)),
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
//     );
//   }

//   /// **Builds the Animal Selection UI**
//   Widget _buildAnimalOption(String animal) {
//     final UnionTruckEntryController controller = Get.find();
//     return Container(
//       width: istablet ? 180 : 120,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color:
//             // controller.selectedAnimal.value == animal
//             //     ? AppColors.appColor
//             //     :
//             Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Center(
//         child: Text(
//           animal,
//           style: TextStyle(
//             fontSize: 18,
//             color:
//                 // controller.selectedAnimal.value == animal
//                 //     ? Colors.white
//                 Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   /// **Builds a text field with validation**
//   Widget _buildTextField(
//     String name,
//     String label,
//     bool isRequired,
//     Function(String) onChangedBuff,
//     Function(String) onChangedCow,
//     RxString valueBuff,
//     RxString valueCow,
//   ) {
//     return Obx(
//       () => Row(children: [
//         Expanded(
//           child: FormBuilderTextField(
//             style: TextStyle(
//                 fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//             name: name,
//             initialValue: valueBuff.value,
//             textInputAction: TextInputAction.next,
//             onChanged: (newValue) => onChangedBuff(newValue ?? ""),
//             validator: isRequired
//                 ? FormBuilderValidators.required(
//                     errorText: "$label is required")
//                 : null,
//             keyboardType: TextInputType.number,
//             decoration:
//                 InputDecoration(labelText: label, border: OutlineInputBorder()),
//           ),
//         ),
//         Expanded(child: Container()),
//         Expanded(
//           child: FormBuilderTextField(
//             style: TextStyle(
//                 fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//             name: name,
//             initialValue: valueCow.value,
//             textInputAction: TextInputAction.next,
//             onChanged: (newValue) => onChangedCow(newValue ?? ""),
//             validator: isRequired
//                 ? FormBuilderValidators.required(
//                     errorText: "$label is required")
//                 : null,
//             keyboardType: TextInputType.number,
//             decoration:
//                 InputDecoration(labelText: label, border: OutlineInputBorder()),
//           ),
//         ),
//       ]),
//     );
//   }

//   /// **Builds a Date Field**
//   Widget _buildDateField() {
//     return FormBuilderDateTimePicker(
//       name: "date",
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//       initialValue: DateTime.now(),
//       inputType: InputType.date,
//       onChanged: (value) => controller.updateDate(value ?? DateTime.now()),
//       format: DateFormat('dd/MM/yyyy'),
//       decoration: InputDecoration(
//         labelText: "Date Selection",
//         border: OutlineInputBorder(),
//         suffixIcon: Icon(Icons.calendar_today),
//       ),
//       validator: FormBuilderValidators.required(errorText: "Date is required"),
//     );
//   }

//   /// **Builds a DropDown Field**
//   Widget _buildDropDownField(List<String> items) {
//     return FormBuilderDropdown(
//       name: "session",
//       style: TextStyle(
//         fontSize: istablet ? 9.sp : 16.sp,
//         color: Colors.black,
//       ),
//       initialValue: "Morning",
//       decoration: InputDecoration(
//         labelText: "Session",
//         labelStyle: TextStyle(
//           fontSize: istablet ? 12.sp : 16.sp,
//         ),
//         border: OutlineInputBorder(),
//       ),
//       onChanged: (value) => controller.updateSession(value as String),
//       items: ["Morning", "Evening"]
//           .map((session) =>
//               DropdownMenuItem(value: session, child: Text(session)))
//           .toList(),
//       validator:
//           FormBuilderValidators.required(errorText: "Session is required"),
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
//           // content: Column(
//           //   mainAxisSize: MainAxisSize.min,
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Text("📍 date: ${controller.selectedDate.value}"),
//           //     SizedBox(height: 8),
//           //     Text("👤 session: ${controller.selectedSession.value} "),
//           //     SizedBox(height: 8),
//           //     Text("🐄 Cattle Type: ${controller.selectedCattle.value}"),
//           //     SizedBox(height: 8),
//           //     Text("🥛 volume: ${controller.volume.value}"),
//           //     SizedBox(height: 8),
//           //     Text("🥛 KG volume: ${controller.kgVolume.value}"),
//           //     SizedBox(height: 8),
//           //     Text("🛢️ Cans: ${controller.volume.value}"),
//           //     // SizedBox(height: 8),
//           //     // Text("💰 Rate: ₹${controller.rate.value}"),
//           //     // SizedBox(height: 8),
//           //     // Text("🧾 Amount: ₹${controller.amount.value}",
//           //     //     style: TextStyle(fontWeight: FontWeight.bold)),
//           //   ],
//           // ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 controller.clearUnionTruckSlipFormFields();
//                 setState(() {

//                 });
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
// }
// //
