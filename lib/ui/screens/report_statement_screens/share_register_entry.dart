// import 'package:aasaan_flutter/common/utils/app_constants.dart';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/local_sales_entry_controller.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../../network/model/member_profile.dart';

// class ShareRegisterEntryScreen extends StatefulWidget {
//   @override
//   State<ShareRegisterEntryScreen> createState() =>
//       _ShareRegisterEntryScreenState();
// }

// class _ShareRegisterEntryScreenState extends State<ShareRegisterEntryScreen> {
//   // final LocalSalesController controller = Get.put(LocalSalesController());
//   var istablet = Utils.checkTablet();

//   var memCode = "".obs;

//   var memberName = "".obs;

//   var shareQty = "".obs;

//   var shareAmount = "".obs;

//   var total = "".obs;

//   var share = "".obs;

//   var shareChillerAmount = "".obs;

//   final formKey = GlobalKey<FormBuilderState>();

//   var listMembers = <MMembersProfile>[].obs;

//   final TextEditingController memberCodeController = TextEditingController();

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   var isLoading = false.obs;

//   getData() async {
//     isLoading.value = true;
//     listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");
//     isLoading.value = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return ModalProgressHUD(
//         color: Colors.black.withOpacity(0.6),
//         dismissible: false,
//         blur: 5,
//         progressIndicator: Utils.loader(context),
//         inAsyncCall: isLoading.value,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appColor,
//             title: Utils.normalText("Share Register",
//                 size: istablet ? 3.sp : 15.sp, color: Colors.white),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // **FormBuilder**
//                   FormBuilder(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         // **Date Picker**
//                         FormBuilderDateTimePicker(
//                           name: "date",
//                           style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                           initialValue: DateTime.now(),
//                           inputType: InputType.date,
//                           format: DateFormat('dd/MM/yyyy'),
//                           decoration: InputDecoration(
//                             labelText: "Date Selection",
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.calendar_today),
//                           ),
//                           validator: FormBuilderValidators.required(
//                               errorText: "Date is required"),
//                         ),

//                         Utils.addGap(istablet ? 16 : 15),

//                         // **MemCode**
//                         _buildMemberCodeField(),
//                         Utils.addGap(istablet ? 16 : 15),

//                         Utils.addGap(istablet ? 16 : 15),

//                         // **ShareQty**
//                         _buildTextField(
//                           "shareQty",
//                           "Share QTY",
//                           shareQty,
//                           (p0) {},
//                         ),
//                         Utils.addGap(istablet ? 16 : 15),

//                         // **ShareAmount**
//                         _buildTextField(
//                           "shareAmount",
//                           "Share Amount",
//                           shareAmount,
//                           (p0) {},
//                         ),
//                         Utils.addGap(istablet ? 16 : 15),

//                         // **MemCode**
//                         _buildTextField(
//                           "total",
//                           "Total",
//                           total,
//                           (p0) {},
//                         ),
//                         Utils.addGap(istablet ? 16 : 15),

//                         // **MemCode**
//                         _buildTextField(
//                           "share",
//                           "Share",
//                           share,
//                           (p0) {},
//                         ),
//                         Utils.addGap(istablet ? 16 : 15),

//                         // **MemCode**
//                         _buildTextField(
//                           "shareChillerAmount",
//                           "Share Chiller Amount",
//                           shareChillerAmount,
//                           (p0) {},
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: Row(
//             children: [
//               // **Cancel Button**
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () => Get.back(),
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

//               // **Submit Button**
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (formKey.currentState!.saveAndValidate()) {
//                       var locCode = await StorageService().getInt(AppConstants.locationCodePr);
//                       final formData = formKey.currentState!.value;
//                       print("Form Data: $formData");
//                       String selectedDate = formData["date"] != null
//                           ? DateFormat('yyyy-MM-dd').format(formData["date"])
//                           : "";
//                       String selectedMemCode = memberCodeController.text;
//                       String selectedShareQty = formData["shareQty"] ?? "";
//                       String selectedShareAmount =
//                           formData["shareAmount"] ?? "";
//                       String total = formData["total"] ?? "";
//                       String share = formData["share"] ?? "";
//                       String selectedChillerAmount =
//                           formData["shareChillerAmount"] ?? "";
//                       String locationCode= locCode.toString();
//                       print("Selected Date: $selectedDate");
//                       print("MemCode: $selectedMemCode");
//                       print("ShareQty: $selectedShareQty");
//                       print("ShareAmount: $selectedShareAmount");
//                       print("Total: $total");
//                       print("Share: $share");
//                       print("Chiller Amount: $selectedChillerAmount");

//                       String query =
//                           "INSERT INTO ShareRegister (MemCode, LocationCode, Date, "
//                           "ShareQuality, ShareAmount, Total, Share, ShareChillerAmount) VALUES ("
//                           "'$selectedMemCode', "
//                           "'${locationCode}', "
//                           "'$selectedDate', "
//                           "'$selectedShareQty', "
//                           "'$selectedShareAmount', "
//                           "'$total', "
//                           "'$share', "
//                           "'$selectedChillerAmount')";
//                       await DBHelper().executeRawQuery(query);
//                       Get.back();
//                     } else {
//                       print("Form validation failed!");
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape:
//                         RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildMemberCodeField() {
//     return FormBuilderField<String>(
//       name: 'memberCode',
//       validator:
//           FormBuilderValidators.required(errorText: 'Member Code is required'),
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
//                   controller: memberCodeController,
//                   // Use our custom controller
//                   focusNode: focusNode,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter Member Code',
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
//                 memberCodeController.text =
//                     member.memCode ?? ""; // Show selected value
//                 field.didChange(member.memCode);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   /// **Builds a text field with validation**
//   Widget _buildTextField(
//       String name, String label, RxString value, Function(String) onChanged) {
//     return Obx(() => FormBuilderTextField(
//           name: name,
//           style:
//               TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//           initialValue: value.value,
//           // ✅ Access .value inside Obx
//           onChanged: (newValue) => onChanged(newValue ?? ""),
//           keyboardType: TextInputType.number,
//           decoration:
//               InputDecoration(labelText: label, border: OutlineInputBorder()),
//           validator:
//               FormBuilderValidators.required(errorText: "$label is required"),
//         ));
//   }
// }
