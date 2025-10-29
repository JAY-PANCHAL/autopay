// import 'package:aasaan_flutter/common/rounded_button.dart';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/sync_milk_collection_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// class SyncMilkCollectionScreen extends StatefulWidget {
//   const SyncMilkCollectionScreen({Key? key}) : super(key: key);

//   @override
//   State<SyncMilkCollectionScreen> createState() =>
//       _SyncMilkCollectionScreenState();
// }

// class _SyncMilkCollectionScreenState extends State<SyncMilkCollectionScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   var istablet = Utils.checkTablet();
//   final SyncMilkCollectionController controller =
//       Get.put((SyncMilkCollectionController()));

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return ModalProgressHUD(
//         color: Colors.black.withOpacity(0.6),
//         dismissible: false,
//         blur: 5,
//         progressIndicator: Utils.loader(context),
//         inAsyncCall: controller.isLoading.value,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appColor,
//             title: Utils.normalText("Sync Milk Collection Data",
//                 size: istablet ? 4.sp : 15.sp, color: Colors.white),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: FormBuilder(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   FormBuilderDateTimePicker(
//                     name: "start_date",
//                     style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                     initialValue: DateTime.now(),
//                     onChanged: (value) =>
//                         controller.updateStartDate(value ?? DateTime.now()),
//                     inputType: InputType.date,
//                     format: DateFormat('dd/MM/yyyy'),
//                     decoration: InputDecoration(
//                       labelText: "Start Date",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: FormBuilderValidators.required(
//                         errorText: "Start date is required"),
//                   ),
//                   SizedBox(height: 16),
//                   FormBuilderDateTimePicker(
//                     name: "end_date",
//                     style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                     initialValue: DateTime.now(),
//                     onChanged: (value) =>
//                         controller.updateEndDate(value ?? DateTime.now()),
//                     inputType: InputType.date,
//                     format: DateFormat('dd/MM/yyyy'),
//                     decoration: InputDecoration(
//                       labelText: "End Date",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: FormBuilderValidators.required(
//                         errorText: "End date is required"),
//                   ),
//                   SizedBox(height: 24),
//                   RoundedButton(
//                       buttonText: "Submit",
//                       color: AppColors.appblue,
//                       width: MediaQuery.of(context).size.width / 2,
//                       height: 50.sp,
//                       onpressed: () async {
//                         if (_formKey.currentState?.saveAndValidate() ?? false) {
//                           final formData = _formKey.currentState!.value;
//                           final DateTime startDate = formData['start_date'];
//                           final DateTime endDate = formData['end_date'];

//                           if (startDate.isAfter(endDate)) {
//                             Utils.showToast(
//                                 "Start Date should not be after End Date");
//                             return;
//                           }

//                           // Convert DateTime to String (yyyy-MM-dd)
//                           final startDateString = formatDate(startDate);
//                           final endDateString = formatDate(endDate);

//                           debugPrint("Start Date: $startDateString");
//                           debugPrint("End Date: $endDateString");
//                           await controller.getMilkCollectionData(
//                               startDateString, endDateString);
//                         } else {
//                           debugPrint("Form validation failed.");
//                         }
//                       }

//                       /* child: Text("Submit"),*/
//                       ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   String formatDate(DateTime date) {
//     return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//   }
// }
