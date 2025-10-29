// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/member_slip_controller.dart';
// import 'package:aasaan_flutter/network/model/member_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../common/excel_export.dart';
// import '../../../common/utils/app_constants.dart';

// class MemberSlipScreen extends StatefulWidget {
//   @override
//   _MemberSlipScreenState createState() => _MemberSlipScreenState();
// }

// class _MemberSlipScreenState extends State<MemberSlipScreen> {
//   MemberSlipController memberSlipController = Get.put(MemberSlipController());
//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
//   var locName = "".obs;
//   TextEditingController fromMemberCodeController = TextEditingController();
//   TextEditingController toMemberCodeController = TextEditingController();
//   TextEditingController fromMemberNameController = TextEditingController();
//   TextEditingController toMemberNameController = TextEditingController();
//   String strMemberCodeValue = "";
//   var fromMemberName = "".obs;
//   var toMemberName = "".obs;
//   String? fromMemberFName;
//   String? toMemberFName;
//   final FocusNode fromMemberFocus = FocusNode();
//   final FocusNode toMemberFocus = FocusNode();
//   var listMembers = <MMembersProfile>[].obs;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     locName.value =
//         await StorageService().getString(AppConstants.locationNamePr);
//     setSession();
//   }

//   void setSession() {
//     DateTime now = DateTime.now();

//     // Set 4:00 PM as the threshold time
//     DateTime eveningStartTime =
//         DateTime(now.year, now.month, now.day, 16, 0); // 4:00 PM

//     if (now.isBefore(eveningStartTime)) {
//       memberSlipController.formKey.currentState?.fields['session']
//           ?.didChange("Morning");
//     } else {
//       memberSlipController.formKey.currentState?.fields['session']
//           ?.didChange("Evening");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: Utils.normalText("Member Slip",
//             size: istablet ? 4.sp : 15.sp, color: Colors.white),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             return Visibility(
//               visible: memberSlipController.listMilkCollection.value.length > 0,
//               child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportMilkCollectionToDownloadsFolder(
//                         memberSlipController.listMilkCollection.value,
//                         DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                         "MemberSlip");
//                   },
//                   child: Icon(Icons.share)),
//             );
//           }),
//           Utils.addHGap(20)
//         ],
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//             child: FormBuilder(
//               key: memberSlipController.formKey,
//               child: Column(
//                 children: [
//                   // Date Selection
//                   FormBuilderDateTimePicker(
//                     name: "date",
//                     style: TextStyle(fontSize: istablet ? 9.sp : 16.sp),
//                     initialValue: DateTime.now(),
//                     onChanged: (value) => memberSlipController
//                         .updateDate(value ?? DateTime.now()),
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
//                     onChanged: (value) =>
//                         memberSlipController.updateSession(value as String),
//                     initialValue: memberSlipController.selectedSession.value,
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
//                   // From Member Dropdown
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildFromMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   // To Member Dropdown
//                   _buildToMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   memberSlipController.listMilkCollection.isEmpty
//                       ? Container()
//                       : SizedBox(
//                           height:
//                               400, // or MediaQuery.of(context).size.height * 0.5
//                           child: buildListView()),
//                   SizedBox(
//                     height: 160,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Row(
//         children: [
//           // Cancel Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//           // Start Button
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 memberSlipController.selectedFromMemCode.value =
//                     fromMemberCodeController.text;
//                 memberSlipController.selectedToMemCode.value =
//                     toMemberCodeController.text;
//                 memberSlipController.submitForm();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 child: Text("Print", style: TextStyle(fontSize: 18.sp)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: memberSlipController.listMilkCollection.value.length,
//       itemBuilder: (context, index) {
//         final file = memberSlipController.listMilkCollection.value[index];
//         return InkWell(
//           onTap: () {},
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
//             elevation: 3,
//             child: ListTile(
//               contentPadding: EdgeInsets.all(10.w),
//               // leading: SizedBox(
//               //   width: 50.w,
//               //   height: 50.h,
//               //   child: ClipRRect(
//               //     borderRadius: BorderRadius.circular(10.r),
//               //     child: Container(
//               //       color: Colors.grey.shade300,
//               //       child: Icon(Icons.pets, size: 30, color: Colors.black),
//               //     ),
//               //   ),
//               // ),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextRow(locName.value, ""),
//                   Divider(
//                     height: 2.sp,
//                     color: Colors.black,
//                   ),
//                   Utils.addGap(10),
//                   _buildTextRow(
//                       " ${memberSlipController.selectedDate.value}( ${memberSlipController.selectedSession.value} )",
//                       ""),
//                   _buildTextRow("Member : ",
//                       "${file.memName ?? " "} (${file.memCode ?? ""})"),
//                   _buildTextRow(
//                       "Cattle Type : ",
//                       file.cattle != null
//                           ? (file.cattle!.contains("B") ? "Buffalo" : "Cow")
//                           : ''),
//                   _buildTextRow("Liters : ", "${file.liters ?? '0'}"),
//                   _buildTextRow("Fat: ", "${file.fat ?? '0'}"),
//                   _buildTextRow("SNF: ", "${file.snf ?? '0'}"),
//                   _buildTextRow(
//                       "Rate: ",
//                       file.rate != null
//                           ? double.parse(file.rate!).toStringAsFixed(2)
//                           : '0.00'),
//                   _buildTextRow("Amount: ", "${file.amount}"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
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

//   // Widget _buildFromMemberCodeField() {
//   //   return FormBuilderField<String>(
//   //     name: 'memberCode',
//   //     validator:
//   //         FormBuilderValidators.required(errorText: 'Member Code is required'),
//   //     builder: (FormFieldState<String> field) {
//   //       return Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           TypeAheadField<MMembersProfile>(
//   //             suggestionsCallback: (search) {
//   //               return memberSlipController.listAllMembers.value
//   //                   .where((member) => (member.memberName ?? "")
//   //                       .toLowerCase()
//   //                       .contains(search.toLowerCase()))
//   //                   .toList();
//   //             },
//   //             builder: (context, textController, focusNode) {
//   //               return TextField(
//   //                 controller: memberSlipController
//   //                     .fromMemberCodeController, // Use our custom controller
//   //                 focusNode: focusNode,
//   //                 decoration: InputDecoration(
//   //                   border: OutlineInputBorder(),
//   //                   labelText: 'From Member',
//   //                   errorText: field.errorText, // Show validation error
//   //                 ),
//   //               );
//   //             },
//   //             itemBuilder: (context, member) {
//   //               return ListTile(
//   //                 title: Text(member.memberName ?? ""),
//   //               );
//   //             },
//   //             onSelected: (member) {
//   //               memberSlipController.fromMemberCodeController.text =
//   //                   member.memCode ?? ""; // Show selected value
//   //               memberSlipController.selectedFromMemCode.value =
//   //                   memberSlipController.fromMemberCodeController.text; //
//   //               debugPrint(
//   //                   "Selected From Member Code: ${memberSlipController.selectedFromMemCode.value}");
//   //               field.didChange(member.memCode); // Update form value
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   Widget _buildFromMemberCodeField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 1,
//           child: FormBuilderField<String>(
//             name: 'memberCode',
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(
//                   errorText: 'Member Code is required'),
//               FormBuilderValidators.minLength(4,
//                   errorText: 'Minimum 4 characters required'),
//             ]),
//             builder: (FormFieldState<String> field) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TypeAheadField<MMembersProfile>(
//                     builder: (context, textEditingController, focusNode) {
//                       fromMemberCodeController = textEditingController;
//                       return TextField(
//                         controller: textEditingController,
//                         focusNode: fromMemberFocus,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Enter From Member Code',
//                           errorText: field.errorText,
//                         ),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp(r'^\d*$'))
//                         ],
//                         onSubmitted: (search) async {
//                           if (search == "") {
//                             /* Get.snackbar("Member Code!", "Please select member Code",
//                                     backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//                               */
//                             FocusScope.of(context)
//                                 .requestFocus(fromMemberFocus);
//                             return;
//                           }

//                           String query = search.toLowerCase().trim();
//                           // Adjust query with leading zeros
//                           String adjustedQuery = query;
//                           if (int.tryParse(query) != null) {
//                             if (query.length == 1) {
//                               adjustedQuery = "000$query";
//                             } else if (query.length == 2) {
//                               adjustedQuery = "00$query";
//                             }
//                           }

//                           // Find the first matching member (same logic as suggestionsCallback)
//                           final matchedMember = memberSlipController
//                               .listAllMembers.value
//                               .firstWhere(
//                             (member) => (member.memCode ?? "")
//                                 .toLowerCase()
//                                 .contains(adjustedQuery),
//                             orElse: () => MMembersProfile(),
//                           );

//                           if ((matchedMember.memCode ?? "").isNotEmpty) {
//                             // // _bluetoothService.resumeData();
//                             // String sql = "SELECT Code FROM MilkCollection "
//                             //     "WHERE CollSession = '$strSession' "
//                             //     "AND MemCode = '${matchedMember.memCode}' "
//                             //     "AND CollDate = '$strDate' and Locked=0";

//                             // String code = await DBHelper()
//                             //     .getScalarQueryStringFromDB(sql);

//                             // if (Utils.replaceNullZero(code) != "0") {
//                             //   showDialog(
//                             //     context: context,
//                             //     barrierDismissible: false,
//                             //     builder: (BuildContext context) {
//                             //       return AlertDialog(
//                             //         content: Text(
//                             //             "This member already poured milk this session. Would you like to add more?"),
//                             //         actions: <Widget>[
//                             //           TextButton(
//                             //             child: Text("Add"),
//                             //             onPressed: () =>
//                             //                 Navigator.of(context).pop(),
//                             //           ),
//                             //           TextButton(
//                             //             child: Text("No"),
//                             //             onPressed: () =>
//                             //                 Navigator.of(context).pop(),
//                             //           ),
//                             //         ],
//                             //       );
//                             //     },
//                             //   );
//                             // }
//                             // clearForm();

//                             // Set member data
//                             fromMemberCodeController.text =
//                                 "${matchedMember.memCode}";
//                             fromMemberName.value =
//                                 matchedMember.memberName ?? "";
//                             field.didChange(matchedMember.memCode);
//                             strMemberCodeValue = matchedMember.memCode ?? "";
//                             fromMemberFName = matchedMember.memberName;
//                             // controller.selectedAnimal.value =
//                             //     (matchedMember.cattleTypeName ?? "")
//                             //             .contains("Buff")
//                             //         ? "Buffalo"
//                             //         : "Cow";
//                             print(matchedMember.cattleTypeName);
//                             // FocusScope.of(context).requestFocus(literFocus);
//                           } else {
//                             // Optionally show error or do nothing
//                             Utils.showToast("No member found for $search");
//                           }
//                         },
//                         onChanged: (val) {
//                           if (val.length < 4) {
//                             fromMemberNameController.text = "";
//                           }
//                           focusNode
//                               .requestFocus(); // Keep focus so suggestions keep updating
//                         },
//                       );
//                     },
//                     /*
//                         suggestionsCallback: (search) {
//                           print("Search value is called: <$search>");
//                           return controller.listMembers.value.where((member) {
//                             final memCode = (member.memCode ?? "").toLowerCase();
//                             final name = (member.memberName ?? "").toLowerCase();
//                             final query = search.toLowerCase().trim();

//                             return memCode.contains(query) || name.contains(query) ||
//                                 "$name $memCode".contains(query);
//                           }).toList();
//                         },
//               */

//                     suggestionsCallback: (search) {
//                       print("Search value is called: <$search>");
//                       final query = search.toLowerCase().trim();

//                       // Adjust query with leading zeros if it's numeric and length <= 2
//                       String adjustedQuery = query;
//                       if (int.tryParse(query) != null) {
//                         if (query.length == 1) {
//                           adjustedQuery = "000$query";
//                           print(adjustedQuery);
//                         } else if (query.length == 2) {
//                           adjustedQuery = "00$query";
//                           print(adjustedQuery);
//                         }
//                       }

//                       return memberSlipController.listAllMembers.value
//                           .where((member) {
//                         final memCode = (member.memCode ?? "").toLowerCase();
//                         // final name = (member.memberName ?? "").toLowerCase();

//                         return memCode.contains(adjustedQuery) ||
//                             /*   name.contains(query) ||*/
//                             /*$name*/ " $memCode".contains(query);
//                       }).toList();
//                     },
//                     itemBuilder: (context, member) {
//                       return ListTile(
//                         title: Text(/*${member.memberName ?? " "}*/
//                             " ${member.memCode}"),
//                       );
//                     },
//                     onSelected: (member) async {
//                       // String query = "SELECT Code FROM MilkCollection "
//                       //     "WHERE CollSession = '$strSession' "
//                       //     "AND MemCode = '${member.memCode}' "
//                       //     "AND CollDate = '$strDate'";

//                       // String code =
//                       //     await DBHelper().getScalarQueryStringFromDB(query);

//                       // if (Utils.replaceNullZero(code) != "0") {
//                       //   showDialog(
//                       //     context: context,
//                       //     barrierDismissible: false,
//                       //     builder: (BuildContext context) {
//                       //       return AlertDialog(
//                       //         content: Text(
//                       //             "This member already poured milk this session. Would you like to add more?"),
//                       //         actions: <Widget>[
//                       //           TextButton(
//                       //             child: Text("Add"),
//                       //             onPressed: () =>
//                       //                 Navigator.of(context).pop(),
//                       //           ),
//                       //           TextButton(
//                       //             child: Text("No"),
//                       //             onPressed: () {
//                       //               Navigator.of(context).pop();
//                       //               return;
//                       //             },
//                       //           ),
//                       //         ],
//                       //       );
//                       //     },
//                       //   );
//                       // }

//                       fromMemberCodeController.text =
//                           /*${member.memberName}*/ "${member.memCode ?? " "}";
//                       fromMemberName.value = "${member.memberName}";
//                       field.didChange(
//                           member.memCode); // updates FormBuilder field value
//                       strMemberCodeValue = member.memCode ?? "";
//                       fromMemberFName = member.memberName;
//                       print(fromMemberName.value);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         Utils.addHGap(10),
//         Expanded(flex: 2, child: _buildSelectedFromMemberNameField())
//       ],
//     );
//   }

//   Widget _buildToMemberCodeField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 1,
//           child: FormBuilderField<String>(
//             name: 'memberCode',
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(
//                   errorText: 'Member Code is required'),
//               FormBuilderValidators.minLength(4,
//                   errorText: 'Minimum 4 characters required'),
//             ]),
//             builder: (FormFieldState<String> field) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TypeAheadField<MMembersProfile>(
//                     builder: (context, textEditingController, focusNode) {
//                       toMemberCodeController = textEditingController;
//                       return TextField(
//                         controller: textEditingController,
//                         focusNode: toMemberFocus,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Enter To Member Code',
//                           errorText: field.errorText,
//                         ),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp(r'^\d*$'))
//                         ],
//                         onSubmitted: (search) async {
//                           if (search == "") {
//                             /* Get.snackbar("Member Code!", "Please select member Code",
//                                     backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//                               */
//                             FocusScope.of(context).requestFocus(toMemberFocus);
//                             return;
//                           }

//                           String query = search.toLowerCase().trim();
//                           // Adjust query with leading zeros
//                           String adjustedQuery = query;
//                           if (int.tryParse(query) != null) {
//                             if (query.length == 1) {
//                               adjustedQuery = "000$query";
//                             } else if (query.length == 2) {
//                               adjustedQuery = "00$query";
//                             }
//                           }

//                           // Find the first matching member (same logic as suggestionsCallback)
//                           final matchedMember = memberSlipController
//                               .listAllMembers.value
//                               .firstWhere(
//                             (member) => (member.memCode ?? "")
//                                 .toLowerCase()
//                                 .contains(adjustedQuery),
//                             orElse: () => MMembersProfile(),
//                           );

//                           if ((matchedMember.memCode ?? "").isNotEmpty) {
//                             // // _bluetoothService.resumeData();
//                             // String sql = "SELECT Code FROM MilkCollection "
//                             //     "WHERE CollSession = '$strSession' "
//                             //     "AND MemCode = '${matchedMember.memCode}' "
//                             //     "AND CollDate = '$strDate' and Locked=0";

//                             // String code = await DBHelper()
//                             //     .getScalarQueryStringFromDB(sql);

//                             // if (Utils.replaceNullZero(code) != "0") {
//                             //   showDialog(
//                             //     context: context,
//                             //     barrierDismissible: false,
//                             //     builder: (BuildContext context) {
//                             //       return AlertDialog(
//                             //         content: Text(
//                             //             "This member already poured milk this session. Would you like to add more?"),
//                             //         actions: <Widget>[
//                             //           TextButton(
//                             //             child: Text("Add"),
//                             //             onPressed: () =>
//                             //                 Navigator.of(context).pop(),
//                             //           ),
//                             //           TextButton(
//                             //             child: Text("No"),
//                             //             onPressed: () =>
//                             //                 Navigator.of(context).pop(),
//                             //           ),
//                             //         ],
//                             //       );
//                             //     },
//                             //   );
//                             // }
//                             // clearForm();

//                             // Set member data
//                             toMemberCodeController.text =
//                                 "${matchedMember.memCode}";
//                             toMemberName.value = matchedMember.memberName ?? "";
//                             field.didChange(matchedMember.memCode);
//                             strMemberCodeValue = matchedMember.memCode ?? "";
//                             toMemberFName = matchedMember.memberName;
//                             // controller.selectedAnimal.value =
//                             //     (matchedMember.cattleTypeName ?? "")
//                             //             .contains("Buff")
//                             //         ? "Buffalo"
//                             //         : "Cow";
//                             print(matchedMember.cattleTypeName);
//                             // FocusScope.of(context).requestFocus(literFocus);
//                           } else {
//                             // Optionally show error or do nothing
//                             Utils.showToast("No member found for $search");
//                           }
//                         },
//                         onChanged: (val) {
//                           if (val.length < 4) {
//                             fromMemberNameController.text = "";
//                           }
//                           focusNode
//                               .requestFocus(); // Keep focus so suggestions keep updating
//                         },
//                       );
//                     },
//                     /*
//                         suggestionsCallback: (search) {
//                           print("Search value is called: <$search>");
//                           return controller.listMembers.value.where((member) {
//                             final memCode = (member.memCode ?? "").toLowerCase();
//                             final name = (member.memberName ?? "").toLowerCase();
//                             final query = search.toLowerCase().trim();

//                             return memCode.contains(query) || name.contains(query) ||
//                                 "$name $memCode".contains(query);
//                           }).toList();
//                         },
//               */

//                     suggestionsCallback: (search) {
//                       print("Search value is called: <$search>");
//                       final query = search.toLowerCase().trim();

//                       // Adjust query with leading zeros if it's numeric and length <= 2
//                       String adjustedQuery = query;
//                       if (int.tryParse(query) != null) {
//                         if (query.length == 1) {
//                           adjustedQuery = "000$query";
//                           print(adjustedQuery);
//                         } else if (query.length == 2) {
//                           adjustedQuery = "00$query";
//                           print(adjustedQuery);
//                         }
//                       }

//                       return memberSlipController.listAllMembers.value
//                           .where((member) {
//                         final memCode = (member.memCode ?? "").toLowerCase();
//                         // final name = (member.memberName ?? "").toLowerCase();

//                         return memCode.contains(adjustedQuery) ||
//                             /*   name.contains(query) ||*/
//                             /*$name*/ " $memCode".contains(query);
//                       }).toList();
//                     },
//                     itemBuilder: (context, member) {
//                       return ListTile(
//                         title: Text(/*${member.memberName ?? " "}*/
//                             " ${member.memCode}"),
//                       );
//                     },
//                     onSelected: (member) async {
//                       // String query = "SELECT Code FROM MilkCollection "
//                       //     "WHERE CollSession = '$strSession' "
//                       //     "AND MemCode = '${member.memCode}' "
//                       //     "AND CollDate = '$strDate'";

//                       // String code =
//                       //     await DBHelper().getScalarQueryStringFromDB(query);

//                       // if (Utils.replaceNullZero(code) != "0") {
//                       //   showDialog(
//                       //     context: context,
//                       //     barrierDismissible: false,
//                       //     builder: (BuildContext context) {
//                       //       return AlertDialog(
//                       //         content: Text(
//                       //             "This member already poured milk this session. Would you like to add more?"),
//                       //         actions: <Widget>[
//                       //           TextButton(
//                       //             child: Text("Add"),
//                       //             onPressed: () =>
//                       //                 Navigator.of(context).pop(),
//                       //           ),
//                       //           TextButton(
//                       //             child: Text("No"),
//                       //             onPressed: () {
//                       //               Navigator.of(context).pop();
//                       //               return;
//                       //             },
//                       //           ),
//                       //         ],
//                       //       );
//                       //     },
//                       //   );
//                       // }

//                       fromMemberCodeController.text =
//                           /*${member.memberName}*/ "${member.memCode ?? " "}";
//                       toMemberName.value = "${member.memberName}";
//                       field.didChange(
//                           member.memCode); // updates FormBuilder field value
//                       strMemberCodeValue = member.memCode ?? "";
//                       toMemberFName = member.memberName;
//                       print(toMemberName.value);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         Utils.addHGap(10),
//         Expanded(flex: 2, child: _buildSelectedToMemberNameField())
//       ],
//     );
//   }

//   //   void clearForm() {
//   //   _formKey.currentState?.reset();
//   //   controller.memberCodeController.text = "";
//   //   controller.memberName.value = "";
//   //   strMemberCodeValue = "";
//   //   memberFName = "";
//   //   controller.selectedAnimal.value = "Buffalo";
//   // }

//   Widget _buildSelectedFromMemberNameField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         fromMemberName.value.isEmpty ? 'Member Name' : fromMemberName.value,
//         style: TextStyle(
//           fontSize: 16,
//           color: fromMemberName.value.isEmpty ? Colors.grey : Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectedToMemberNameField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         toMemberName.value.isEmpty ? 'Member Name' : toMemberName.value,
//         style: TextStyle(
//           fontSize: 16,
//           color: toMemberName.value.isEmpty ? Colors.grey : Colors.black,
//         ),
//       ),
//     );
//   }

// // Widget _buildToMemberCodeField() {
// //   return FormBuilderField<String>(
// //     name: 'memberCode',
// //     validator:
// //         FormBuilderValidators.required(errorText: 'Member Code is required'),
// //     builder: (FormFieldState<String> field) {
// //       return Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           TypeAheadField<MMembersProfile>(
// //             suggestionsCallback: (search) {
// //               return memberSlipController.listAllMembers.value
// //                   .where((member) => (member.memberName ?? "")
// //                       .toLowerCase()
// //                       .contains(search.toLowerCase()))
// //                   .toList();
// //             },
// //             builder: (context, textController, focusNode) {
// //               return TextField(
// //                 controller: memberSlipController
// //                     .toMemberCodeController, // Use our custom controller
// //                 focusNode: focusNode,
// //                 decoration: InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   labelText: 'To Member',
// //                   errorText: field.errorText, // Show validation error
// //                 ),
// //               );
// //             },
// //             itemBuilder: (context, member) {
// //               return ListTile(
// //                 title: Text(member.memberName ?? ""),
// //               );
// //             },
// //             onSelected: (member) {
// //               memberSlipController.toMemberCodeController.text =
// //                   member.memCode ?? ""; // Show selected value
// //               memberSlipController.selectedToMemCode.value =
// //                   memberSlipController.toMemberCodeController.text; //
// //               debugPrint(
// //                   "Selected To Member Code: ${memberSlipController.selectedToMemCode.value}");
// //               field.didChange(member.memCode); // Update form value
// //             },
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }
// }
