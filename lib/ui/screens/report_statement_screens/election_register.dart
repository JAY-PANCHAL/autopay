// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';
// import '../../../network/model/member_profile.dart';
// import '../../../network/model/milkCollectionModel.dart';

// class ElectionRegisterScreen extends StatefulWidget {
//   @override
//   _ElectionRegisterScreenState createState() => _ElectionRegisterScreenState();
// }

// class _ElectionRegisterScreenState extends State<ElectionRegisterScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final TextEditingController fromMemberCodeController =
//       TextEditingController();
//   final TextEditingController toMemberCodeController = TextEditingController();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   var litres = "".obs;
//   var days = "".obs;

//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;
//   var listMembers = <MMembersProfile>[].obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;
//   var milkCollectionList = <MilkCollection>[].obs;

//   @override
//   void initState() {
//     getData();

//     super.initState();
//   }

//   getData() async {
//     listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Election Register",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//               return Visibility(
//                 visible: milkCollectionList.isNotEmpty,
//                 child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportElectionRegisterToDownloadsFolder(
//                       milkCollectionList,
//                       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                       "ElectionRegister",
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
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   _buildDateField(
//                     "start_date",
//                     "Start Date",
//                     startDate,
//                     startDateFormat,
//                   ),
//                   SizedBox(height: 15.h),
//                   _buildDateField(
//                       "end_date", "End Date", endDate, endDateFormat),
//                   SizedBox(height: 15.h),
//                   // From Member Dropdown
//                   _buildfromMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   // From Member Dropdown
//                   _buildToMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildTextField("liters", "Liters", litres, "Enter Liters",
//                       isRequired: true, isNumeric: true),
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildTextField("days", "Days", days, "Enter Days",
//                       isRequired: true, isNumeric: true),
//                   Utils.addGap(istablet ? 16 : 25),
//                   milkCollectionList.length > 0
//                       ? ListView.builder(
//                           itemCount: milkCollectionList.length,
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final item = milkCollectionList[index];
//                             return Container(
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
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: 4.sp, vertical: 5.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildTextRow("Member: ",
//                                       "${item.memCode ?? " "}${item.memName ?? " "} "),
//                                   _buildTextRow("Days: ", item.collDate ?? ""),
//                                   _buildTextRow("Liters: ", item.liters ?? ""),
//                                   _buildTextRow("FAT: ", item.fat ?? ""),
//                                   _buildTextRow("SNF: ", item.snf ?? ""),
//                                   _buildTextRow("Amount: ", "₹${item.amount}"),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       : Container(),
//                 ],
//               ),
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
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     final formData = _formKey.currentState!.value;
//                     print("Form Data: $formData");
//                     String litersValue = formData['liters'];
//                     String daysValue = formData['days'];

//                     String query =
//                         "SELECT *, COUNT(DISTINCT(CollDate)) AS CollDate " +
//                             "FROM MilkCollection WHERE MemCode BETWEEN '" +
//                             fromMemberCodeController.text +
//                             "' AND '" +
//                             toMemberCodeController.text +
//                             "' AND CollDate BETWEEN '" +
//                             startDateFormat.value +
//                             "' AND '" +
//                             endDateFormat.value +
//                             "' " +
//                             "GROUP BY MemCode HAVING SUM(Liters) >= " +
//                             litersValue +
//                             " AND COUNT(DISTINCT(CollDate)) >= " +
//                             daysValue +
//                             ";";
//                     milkCollectionList.value =
//                         await DBHelper().getMilkCollection(query);
//                     print(milkCollectionList.value);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.appColor,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16.h),
//                   child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//                 ),
//               ),
//             ),
//             // Start Button
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {},
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

//   Widget _buildTextRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 5.sp),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(fontSize: 14.sp, color: Colors.black),
//           children: [
//             TextSpan(
//               text: title + " ",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextSpan(text: value),
//           ],
//         ),
//       ),
//     );
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
//               // If this is the end date field and start date is set, validate
//               if (name == "end_date" && startDate.value != null) {
//                 if (pickedDate.isBefore(startDate.value!)) {
//                   Get.snackbar("Invalid Date",
//                       "End date cannot be earlier than the start date.",
//                       backgroundColor: Colors.red, colorText: Colors.white);
//                   return;
//                 }
//               }
//               dateValue.value = pickedDate;
//               formattedDateValue.value =
//                   DateFormat("yyyy-MM-dd").format(pickedDate);
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
//                       fontSize: 16.sp,
//                       color: formattedDateValue.value.isNotEmpty
//                           ? Colors.black
//                           : Colors.black54),
//                 ),
//                 Icon(Icons.calendar_today, color: Colors.grey),
//               ],
//             ),
//           ),
//         ));
//   }

//   Widget _buildTextField(
//       String name, String label, RxString controllerVar, String hintText,
//       {bool isRequired = false, bool isNumeric = false}) {
//     return FormBuilderTextField(
//       name: name,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         hintText: hintText,
//       ),
//       onChanged: (value) => controllerVar.value = value ?? "",
//       keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//       validator: isRequired
//           ? FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: "$label is required"),
//               if (isNumeric)
//                 FormBuilderValidators.numeric(
//                     errorText: "$label must be a number"),
//             ])
//           : null,
//     );
//   }

//   Widget _buildfromMemberCodeField() {
//     return FormBuilderField<String>(
//       name: 'fromMemberCode',
//       validator: FormBuilderValidators.required(
//           errorText: 'From Member Code is required'),
//       builder: (FormFieldState<String> field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TypeAheadField<MMembersProfile>(
//               suggestionsCallback: (search) {
//                 return listMembers.value
//                     .where((member) => (member.memberName ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: fromMemberCodeController,
//                   // Use our custom controller
//                   focusNode: focusNode,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter From Member Code',
//                     errorText: field.errorText, // Show validation error
//                   ),
//                 );
//               },
//               itemBuilder: (context, member) {
//                 return ListTile(
//                   title: Text(member.memberName ?? ""),
//                 );
//               },
//               onSelected: (member) {
//                 fromMemberCodeController.text =
//                     member.memCode ?? ""; // Show selected value
//                 field.didChange(member.memCode);
//                 //strMemberCodeValue = member.memCode ?? "";

//                 // Update form value
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildToMemberCodeField() {
//     return FormBuilderField<String>(
//       name: 'toMemberCode',
//       validator: FormBuilderValidators.required(
//           errorText: 'To Member Code is required'),
//       builder: (FormFieldState<String> field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TypeAheadField<MMembersProfile>(
//               suggestionsCallback: (search) {
//                 return listMembers.value
//                     .where((member) => (member.memberName ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: toMemberCodeController,
//                   // Use our custom controller
//                   focusNode: focusNode,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter To Member Code',
//                     errorText: field.errorText, // Show validation error
//                   ),
//                 );
//               },
//               itemBuilder: (context, member) {
//                 return ListTile(
//                   title: Text(member.memberName ?? ""),
//                 );
//               },
//               onSelected: (member) {
//                 toMemberCodeController.text =
//                     member.memCode ?? ""; // Show selected value
//                 field.didChange(member.memCode);
//                 //strMemberCodeValue = member.memCode ?? "";

//                 // Update form value
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
