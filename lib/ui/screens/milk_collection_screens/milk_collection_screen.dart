// import 'package:aasaan_flutter/common/utils/app_constants.dart';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/milk_collection_screen_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../../common/notification_main.dart';
// import '../../../controller/sync_milk_collection_controller.dart';
// import '../../../main.dart';

// class MilkCollectionScreen extends StatefulWidget {
//   @override
//   _MilkCollectionScreenState createState() => _MilkCollectionScreenState();
// }

// class _MilkCollectionScreenState extends State<MilkCollectionScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final MilkCollectionScreenController controller =
//       Get.put(MilkCollectionScreenController());
//   var  rateChartUrl="".obs;
//   final SyncMilkCollectionController syncMilkCollectionController =
//   Get.put((SyncMilkCollectionController()));
//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();

//   void setSession() {
//     DateTime now = DateTime.now();

//     // Set 4:00 PM as the threshold time
//     DateTime eveningStartTime =
//         DateTime(now.year, now.month, now.day, 16, 0); // 4:00 PM

//     if (now.isBefore(eveningStartTime)) {
//       _formKey.currentState?.fields['session']?.didChange("Morning");
//     } else {
//       _formKey.currentState?.fields['session']?.didChange("Evening");
//     }
//   }

//   @override
//   void initState() {

//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setSession();
//     });
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
//             title: Utils.normalText("Milk Collection",
//                 size: istablet ? 4.sp : 15.sp, color: Colors.white),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//             child: FormBuilder(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Date Selection
//                   FormBuilderDateTimePicker(
//                     name: "date",
//                     style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                     initialValue: DateTime.now(),
//                     lastDate: DateTime.now(),

//                     inputType: InputType.date,
//                     format: DateFormat('dd/MM/yyyy'),
//                     decoration: InputDecoration(
//                       labelText: "Date Selection",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: FormBuilderValidators.required(
//                         errorText: "Date is required"),
//                   ),
//                   Utils.addGap(istablet ? 16 : 15),
//                   // Session Dropdown
//                   FormBuilderDropdown(
//                     name: "session",
//                     style: TextStyle(
//                       fontSize: istablet ? 9.sp : 16.sp,
//                       color: Colors.black,
//                     ),
//                     initialValue: "Morning",
//                     decoration: InputDecoration(
//                       labelText: "Session",
//                       labelStyle: TextStyle(
//                         fontSize: istablet ? 12.sp : 16.sp,
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     items: ["Morning", "Evening"]
//                         .map((session) => DropdownMenuItem(
//                             value: session, child: Text(session)))
//                         .toList(),
//                     validator: FormBuilderValidators.required(
//                         errorText: "Session is required"),
//                   ),
//                   Utils.addGap(istablet ? 16 : 15),
//                   // Captured Time (Uneditable)
//                   FormBuilderTextField(
//                     name: "capturedTime",
//                     style: TextStyle(
//                         fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//                     initialValue: capturedTime,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: "Captured Time",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: Row(
//             children: [
//               // Cancel Button
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape:
//                         RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//               ),
//               // Start Button
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.saveAndValidate()) {
//                       final formData = _formKey.currentState!.value;

//                       rateChartUrl.value=await StorageService().getString(AppConstants.rateChartUrlPr);

//                       bool isInternetAvailable= await NotificationHelper().checkInternetConnection();
//                       if(isInternetAvailable){
//                         await NotificationHelper().downloadExcelFile(rateChartUrl.value);
//                       }
//                       String selectedDate =
//                           DateFormat('dd/MM/yyyy').format(formData["date"]);
//                       String selectedSession = formData["session"];
//                       String capturedTime = formData["capturedTime"];
//                       controller.isLoading.value=true;
//                       await commonController.getMemberCountApiCall(context);

//                       var stdate= getTodayDate();
//                       var endate=getTodayDate();


//                       await syncMilkCollectionController.getMilkCollectionData(stdate, endate);
//                       controller.isLoading.value=false;
//                       Get.toNamed(
//                         Routes.milkCollectionEntryScreen,
//                         arguments: {
//                           "date": selectedDate,
//                           "session": selectedSession,
//                           "capturedTime": capturedTime,
//                         },
//                       );

//                       // Get.toNamed(Routes.milkCollectionEntryScreen);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape:
//                         RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text("Start", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//   String getTodayDate() {
//     final now = DateTime.now();
//     final formatted = "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
//     return formatted;
//   }

// }
