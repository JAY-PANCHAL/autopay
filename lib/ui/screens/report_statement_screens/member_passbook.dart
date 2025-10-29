// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../db/db_helper.dart';
// import '../../../network/model/member_profile.dart';
// import '../../../network/model/milkCollectionModel.dart';

// class MemberPassbookScreen extends StatefulWidget {
//   @override
//   _MemberPassbookScreenState createState() => _MemberPassbookScreenState();
// }

// class _MemberPassbookScreenState extends State<MemberPassbookScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String capturedTime = DateFormat('HH:mm:ss').format(DateTime.now());
//   var istablet = Utils.checkTablet();
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

//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   RxString startDateFormat = "".obs;
//   var listMembers = <MMembersProfile>[].obs;

//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   RxString endDateFormat = "".obs;
//   var milkCollectionList = <MilkCollection>[].obs;
//   var totalvalue = 0.0.obs;

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
//           title: Utils.normalText("Member's Passbook",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(istablet ? 20.w : 20.w),
//           child: FormBuilder(
//             key: _formKey,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   // Start Date
//                   _buildDateField(
//                     "start_date",
//                     "Start Date",
//                     startDate,
//                     startDateFormat,
//                   ),
//                   SizedBox(height: 15.h),
//                   _buildDateField(
//                       "end_date", "End Date", endDate, endDateFormat),
//                   // SizedBox(height: 15.h),
//                   // From Member Dropdown
//                   // _buildfromMemberCodeField(),
//                   // Utils.addGap(istablet ? 16 : 15),
//                   // From Member Dropdown
//                   // _buildToMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildFromMemberCodeField(),
//                   Utils.addGap(istablet ? 16 : 15),
//                   _buildToMemberCodeField(),

//                   milkCollectionList.length > 0
//                       ? SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Row of titles
//                                 // Row(
//                                 //   children: [
//                                 //     _buildHeaderCell("Date", true),
//                                 //     _buildHeaderCell("Sess", false),
//                                 //     //_buildHeaderCell("Ct"),
//                                 //     _buildHeaderCell("Ltr", false),
//                                 //     _buildHeaderCell("Fat", false),
//                                 //     _buildHeaderCell("SNF", false),
//                                 //     _buildHeaderCell("Amt", false),
//                                 //     //_buildHeaderCell("Sync"),
//                                 //   ],
//                                 // ),
//                                 Utils.addGap(2),
//                                 // Row of values (each entry is a column)
//                                 Column(
//                                     children: List.generate(
//                                   milkCollectionList.value.length,
//                                   (index) {
//                                     final entry =
//                                         milkCollectionList.value[index];
//                                     final showName = index == 0 ||
//                                         entry.memName !=
//                                             milkCollectionList
//                                                 .value[index - 1].memName;

//                                     final isLastForThisUser = index ==
//                                             milkCollectionList.value.length -
//                                                 1 ||
//                                         entry.memName !=
//                                             milkCollectionList
//                                                 .value[index + 1].memName;

//                                     // Calculate total for current user group
//                                     double totalLiters = 0;
//                                     double totalFat = 0;
//                                     double totalSNF = 0;
//                                     double totalAmount = 0;

//                                     if (isLastForThisUser) {
//                                       final currentUser = entry.memName;
//                                       final groupEntries =
//                                           milkCollectionList.value.where(
//                                         (e) => e.memName == currentUser,
//                                       );

//                                       for (var e in groupEntries) {
//                                         totalLiters +=
//                                             double.tryParse(e.liters ?? '0') ??
//                                                 0;
//                                         totalFat +=
//                                             double.tryParse(e.fat ?? '0') ?? 0;
//                                         totalSNF +=
//                                             double.tryParse(e.snf ?? '0') ?? 0;
//                                         totalAmount +=
//                                             double.tryParse(e.amount ?? '0') ??
//                                                 0;
//                                       }
//                                     }

//                                     return Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         if (showName)
//                                           _buildTextRow("Name : ",
//                                               "${entry.memName ?? " "} (${entry.memCode})"),
//                                         if (showName)
//                                           Row(
//                                             children: [
//                                               _buildHeaderCell("Date", true),
//                                               _buildHeaderCell("Sess", false),
//                                               _buildHeaderCell("Ltr", false),
//                                               _buildHeaderCell("Fat", false),
//                                               _buildHeaderCell("SNF", false),
//                                               _buildHeaderCell("Amt", false),
//                                             ],
//                                           ),
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             _buildDataCell(
//                                                 _formatDate(
//                                                     entry.collDate ?? ""),
//                                                 true),
//                                             _buildDataCell(
//                                                 entry.collSession ?? "", false),
//                                             _buildDataCell(
//                                                 entry.liters ?? "", false),
//                                             _buildDataCell(
//                                                 entry.fat ?? "", false),
//                                             _buildDataCell(
//                                                 entry.snf ?? "", false),
//                                             _buildDataCell(
//                                                 entry.amount ?? "", false),
//                                           ],
//                                         ),
//                                         if (isLastForThisUser)
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 4.0, bottom: 12.0),
//                                             child: Row(
//                                               children: [
//                                                 _buildDataCell("Total", true),
//                                                 _buildDataCell("-", false),
//                                                 _buildDataCell(
//                                                     totalLiters
//                                                         .toStringAsFixed(2),
//                                                     false),
//                                                 _buildDataCell(
//                                                     totalFat.toStringAsFixed(2),
//                                                     false),
//                                                 _buildDataCell(
//                                                     totalSNF.toStringAsFixed(2),
//                                                     false),
//                                                 _buildDataCell(
//                                                     totalAmount
//                                                         .toStringAsFixed(2),
//                                                     false),
//                                               ],
//                                             ),
//                                           ),
//                                       ],
//                                     );
//                                   },
//                                 )),
//                                 const SizedBox(height: 10),
//                                 //  _buildTextRow("Total Amount : ",  "${totalvalue.value}")
//                               ],
//                             ),
//                           ),
//                         )
//                       : Container(),
//                   /*
//                     ElevatedButton(
//                       onPressed: () {
//                         Utils.showToast("No Report Available To Generate");
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.appColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16.h),
//                         child: Text("Generate Report",
//                             style: TextStyle(fontSize: 18.sp)),
//                       ),
//                     ),
//                 */
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
//                     /* String query = "SELECT Code, AutoID, MemCode, CollDate, CollTime, CollSession, "
//                           "PRINTF('%.2f', SUM(KgFat) / SUM(Liters)) AS FAT, "
//                           "PRINTF('%.2f', SUM(Amount)) AS Amount, "
//                           "PRINTF('%.2f', SUM(Liters)) AS Liters, Cattle, LitersEntryType, "
//                           "PRINTF('%.2f', SUM(KgSnf) / SUM(Liters)) AS SNF, AVG(CLR) AS CLR, "
//                           "FAT_SNF_EntryType, PRINTF('%.2f', AVG(Rate)) AS Rate, Amount_Type, "
//                           "ReceiptPrinted, SentStatus, SentOn, UploadStatus, UploadOn, IsSync, "
//                           "SampleNo, VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, "
//                           "Locked, KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount "
//                           "FROM MilkCollection WHERE MemCode BETWEEN '${ fromMemberCodeController.text}' AND '${toMemberCodeController.text}' "
//                           "AND CollDate BETWEEN '${startDateFormat.value}' AND '${endDateFormat.value}' "
//                           "AND LOCKED <> '1' GROUP BY MemCode, CollDate, CollSession "
//                           "ORDER BY MemCode, CollDate ASC;";
// */

//                     /*  String query = "SELECT Code, AutoID, MemCode, CollDate, CollTime, CollSession, "
//                           "PRINTF('%.2f', (KgFat) /(Liters)) AS FAT, "
//                           "PRINTF('%.2f', (Amount)) AS Amount, "
//                           "PRINTF('%.2f', (Liters)) AS Liters, Cattle, LitersEntryType, "
//                           "PRINTF('%.2f', (KgSnf) /(Liters)) AS SNF, (CLR) AS CLR, "
//                           "FAT_SNF_EntryType, PRINTF('%.2f',(Rate)) AS Rate, Amount_Type, "
//                           "ReceiptPrinted, SentStatus, SentOn, UploadStatus, UploadOn, IsSync, "
//                           "SampleNo, VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, "
//                           "Locked, KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount "
//                           "FROM MilkCollection WHERE MemCode BETWEEN '${ fromMemberCodeController.text}' AND '${toMemberCodeController.text}' "
//                           "AND CollDate BETWEEN '${startDateFormat.value}' AND '${endDateFormat.value}' "
//                           "AND LOCKED <> '1' ORDER BY MemCode, CollDate ASC;";

// */

//                     String query = """
//   SELECT 
//     Code, 
//     AutoID, 
//     MemCode, 
//     CollDate, 
//     CollTime, 
//     CollSession,
//     PRINTF('%.2f', KgFat / Liters) AS FAT,
//     PRINTF('%.2f', Amount) AS Amount,
//     PRINTF('%.2f', Liters) AS Liters,
//     Cattle, 
//     LitersEntryType,
//     PRINTF('%.2f', KgSnf / Liters) AS SNF,
//     CLR,
//     FAT_SNF_EntryType,
//     PRINTF('%.2f', Rate) AS Rate,
//     Amount_Type,
//     ReceiptPrinted,
//     SentStatus,
//     SentOn,
//     UploadStatus,
//     UploadOn,
//     IsSync,
//     SampleNo,
//     VoucherNo,
//     IsUpdate,
//     MemName,
//     KgFatRate,
//     Payment_Type,
//     Locked,
//     KgFat,
//     KgSnf,
//     OldWeight,
//     OldFat,
//     OldSNF,
//     OldAmount
//   FROM MilkCollection 
//   WHERE 
//     MemCode BETWEEN '${fromMemberCodeController.text}' AND '${toMemberCodeController.text}'
//     AND CollDate BETWEEN '${startDateFormat.value}' AND '${endDateFormat.value}'
//     AND Locked <> '1'
//   ORDER BY MemCode, CollDate ASC;
// """;

//                     milkCollectionList.value =
//                         await DBHelper().getMilkCollection(query);
//                     print(milkCollectionList.value);

//                     for (int i = 0; i < milkCollectionList.value.length; i++) {
//                       totalvalue.value = totalvalue.value +
//                           (double.tryParse(
//                                   milkCollectionList.value[i].amount ?? "") ??
//                               0);
//                     }

//                     // Get.toNamed(Routes.milkCollectionEntryScreen);
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
//                 onPressed: () async {},
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
//                           final matchedMember = listMembers.value.firstWhere(
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

//                       return listMembers.value.where((member) {
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
//                           final matchedMember = listMembers.value.firstWhere(
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

//                       return listMembers.value.where((member) {
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

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd-MM').format(date);
//     } catch (e) {
//       return dateStr; // fallback if format fails
//     }
//   }

//   Widget _buildHeaderCell(String title, bool isDate) {
//     return Container(
//       width: isDate ? 60.sp : 60.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildHeaderCellAction(String title) {
//     return Container(
//       width: 60.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }

//   Widget _buildDataCell(String value, bool isDate) {
//     return Container(
//       width: isDate ? 60.sp : 60.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(value),
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

//   // Widget _buildfromMemberCodeField() {
//   //   return FormBuilderField<String>(
//   //     name: 'fromMemberCode',
//   //     validator: FormBuilderValidators.required(
//   //         errorText: 'From Member Code is required'),
//   //     builder: (FormFieldState<String> field) {
//   //       return Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           TypeAheadField<MMembersProfile>(
//   //             suggestionsCallback: (search) {
//   //               return listMembers.value
//   //                   .where((member) => (member.memberName ?? "")
//   //                       .toLowerCase()
//   //                       .contains(search.toLowerCase()))
//   //                   .toList();
//   //             },
//   //             builder: (context, textController, focusNode) {
//   //               return TextField(
//   //                 controller: fromMemberCodeController,
//   //                 // Use our custom controller
//   //                 focusNode: focusNode,
//   //                 decoration: InputDecoration(
//   //                   border: OutlineInputBorder(),
//   //                   labelText: 'Enter From Member Code',
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
//   //               fromMemberCodeController.text =
//   //                   member.memCode ?? ""; // Show selected value
//   //               field.didChange(member.memCode);
//   //               //strMemberCodeValue = member.memCode ?? "";

//   //               // Update form value
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   // Widget _buildToMemberCodeField() {
//   //   return FormBuilderField<String>(
//   //     name: 'toMemberCode',
//   //     validator: FormBuilderValidators.required(
//   //         errorText: 'To Member Code is required'),
//   //     builder: (FormFieldState<String> field) {
//   //       return Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           TypeAheadField<MMembersProfile>(
//   //             suggestionsCallback: (search) {
//   //               return listMembers.value
//   //                   .where((member) => (member.memberName ?? "")
//   //                       .toLowerCase()
//   //                       .contains(search.toLowerCase()))
//   //                   .toList();
//   //             },
//   //             builder: (context, textController, focusNode) {
//   //               return TextField(
//   //                 controller: toMemberCodeController,
//   //                 // Use our custom controller
//   //                 focusNode: focusNode,
//   //                 decoration: InputDecoration(
//   //                   border: OutlineInputBorder(),
//   //                   labelText: 'Enter To Member Code',
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
//   //               toMemberCodeController.text =
//   //                   member.memCode ?? ""; // Show selected value
//   //               field.didChange(member.memCode);
//   //               //strMemberCodeValue = member.memCode ?? "";

//   //               // Update form value
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }
