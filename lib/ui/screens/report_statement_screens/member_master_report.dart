// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../common/excel_export.dart';
// import '../../../db/db_helper.dart';
// import '../../../network/model/member_profile.dart';
// import '../../../network/model/milkCollectionModel.dart';

// class MemberMasterReportScreen extends StatefulWidget {
//   const MemberMasterReportScreen({Key? key}) : super(key: key);

//   @override
//   State<MemberMasterReportScreen> createState() =>
//       _MemberMasterReportScreenState();
// }

// class _MemberMasterReportScreenState extends State<MemberMasterReportScreen> {
//   var istablet = Utils.checkTablet();
//   var listMembers = <MMembersProfile>[].obs;
//   final TextEditingController memberCodeController = TextEditingController();
//   var selectedFromMemCode = "".obs;

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   getData() async {
//     listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");
//   }

//   getSelectedData(String memCode) async {
//     listMembers.value = memCode != ""
//         ? await DBHelper().getMembersProfile(
//             "SELECT * FROM MembersProfile WHERE MemCode = '${memCode ?? ""}'")
//         : await DBHelper().getMembersProfile("SELECT * FROM MembersProfile ");
//     print(listMembers.length);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.appColor,
//           title: Utils.normalText("Member Master Report",
//               size: istablet ? 4.sp : 15.sp, color: Colors.white),
//           centerTitle: true,
//           actions: [
//             Obx(() {
//               return Visibility(
//                 visible: listMembers.isNotEmpty,
//                 child: GestureDetector(
//                   onTap: () {
//                     ExcelService.exportMemberMasterToDownloadsFolder(
//                       listMembers,
//                       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                       "MemberMaster",
//                     );
//                   },
//                   child: Icon(Icons.share),
//                 ),
//               );
//             }),
//             Utils.addHGap(20),
//           ],

//         ),
//         body: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.all(8.0.sp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Utils.addGap(10),
//                 _buildFromMemberCodeField(),
//                 Utils.addGap(10),
//                 listMembers.length > 0
//                     ? ListView.builder(
//                         itemCount: listMembers.length,
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final item = listMembers[index];
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   blurRadius: 5,
//                                   spreadRadius: 2,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             padding: EdgeInsets.all(12.sp),
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 4.sp, vertical: 5.sp),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildTextRow("Sr No : ", "${index + 1}"),
//                                 _buildTextRow(
//                                     "Member Name : ", item.memberName ?? ""),
//                                 _buildTextRow(
//                                     "Cattle : ", item.cattleTypeName ?? ""),
//                                 _buildTextRow(
//                                     "Phone : ", item.mobileNumber ?? ""),
//                                 _buildTextRow(
//                                     "Bank Name : ", item.bankName ?? ""),
//                                 _buildTextRow("Bank Account Number : ",
//                                     item.bankAccountNo ?? ""),
//                               ],
//                             ),
//                           );
//                         },
//                       )
//                     : Container(),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildFromMemberCodeField() {
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
//                   controller: memberCodeController, // Use our custom controller
//                   focusNode: focusNode,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Member',
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
//                 getSelectedData(member.memCode ?? "");
//                 memberCodeController.text =
//                     member.memCode ?? ""; // Show selected value
//                 selectedFromMemCode.value = memberCodeController.text; //
//                 debugPrint(
//                     "Selected From Member Code: ${selectedFromMemCode.value}");
//                 field.didChange(member.memCode); // Update form value
//               },
//             ),
//           ],
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
// }
