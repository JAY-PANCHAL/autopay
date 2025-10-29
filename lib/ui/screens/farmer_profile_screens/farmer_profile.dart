// import 'dart:io';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/image_paths.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/farmer_profile_controller.dart';
// import 'package:aasaan_flutter/network/model/bank_master_model.dart';
// import 'package:aasaan_flutter/ui/screens/milk_collection_screens/milk_collection_entry_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../../../common/utils/app_constants.dart';
// import '../../../db/db_helper.dart';
// import '../../../network/model/member_profile.dart';

// class FarmerProfile extends StatefulWidget {
//   @override
//   State<FarmerProfile> createState() => _FarmerProfileState();
// }

// class _FarmerProfileState extends State<FarmerProfile> {
//   final FarmerProfileController controller = Get.put(FarmerProfileController());
//   var istablet = Utils.checkTablet();
//   Rx<DateTime?> selDate = Rx<DateTime?>(null);
//   RxString selDateFormat = "".obs;

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   getData() async {
//     controller.listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");

//     controller.listBankName.value =
//         await DBHelper().getBankMaster("Select * FROM BankMaster");
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
//             title: Utils.normalText("Farmer Profile",
//                 size: istablet ? 3.sp : 15.sp, color: Colors.white),
//             backgroundColor: AppColors.appColor,
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: FormBuilder(
//               key: controller.formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildMemberCodeField(),
//                   SizedBox(height: 16),
//                   Center(
//                     child: Stack(
//                       children: [
//                         Obx(() => CircleAvatar(
//                               radius: 50,
//                               backgroundImage: controller
//                                       .profileImagePath.value.isNotEmpty
//                                   ? FileImage(
//                                       File(controller.profileImagePath.value))
//                                   : AssetImage(AppIcons.profilePhotoView)
//                                       as ImageProvider,
//                             )),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: GestureDetector(
//                             onTap: () => _showImagePickerDialog(context),
//                             child: CircleAvatar(
//                               radius: 16,
//                               backgroundColor: Colors.blue,
//                               child: Icon(Icons.camera_alt,
//                                   color: Colors.white, size: 18),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                           child: _buildTextField("firstName", "Name",
//                               controller.firstName, "Enter First Name",
//                               isRequired: false)),
//                     /*  SizedBox(width: 8),
//                       Expanded(
//                           child: _buildTextField("middleName", "Middle Name",
//                               controller.middleName, "Enter Middle Name",
//                               isRequired: false)),
//                       SizedBox(width: 8),
//                       Expanded(
//                           child: _buildTextField("lastName", "Last Name",
//                               controller.lastName, "Enter Last Name",
//                               isRequired: false)),*/
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   _buildDateField(
//                       "date", "Date Of Birth", selDate, selDateFormat),
//                   SizedBox(height: 16),
//                   _buildRadioGroup("CattleType", controller.cattleType,
//                       ["COW", "BUFF", "BOTH"],
//                       isRequired: false),
//                   SizedBox(height: 16),
//                   _buildTextField("mobileNumber", "Mobile Number",
//                       controller.mobileNumber, "Enter Mobile Number",
//                       isRequired: false, isNumeric: true),
//                   SizedBox(height: 16),
//                   _buildRadioGroup(
//                       "Gender", controller.gender, ["Male", "Female"],
//                       isRequired: false),
//                   SizedBox(height: 16),
//                   _buildTextField("noofcows", "No Of Cows", controller.noOfCows,
//                       "Enter no of cows",
//                       isRequired: false, isNumeric: true),
//                   SizedBox(height: 16),
//                   _buildTextField("noofbufs", "No Of Buffalo",
//                       controller.noOfBuffalo, "Enter no of Bufs",
//                       isRequired: false, isNumeric: true),
//                   SizedBox(height: 16),
//                   _buildTextField("nomineename", "Nominee Name",
//                       controller.nomineeName, "Enter Nominee Name",
//                       isRequired: false, isNumeric: false),
//                   SizedBox(height: 16),
//                   _buildTextField("aadharNumber", "Aadhar Number",
//                       controller.aadharNumber, "Enter Aadhar Number",
//                       isRequired: false, isNumeric: true),
//                   SizedBox(height: 16),
//                   _buildTextField("panNumber", "PAN Number",
//                       controller.panNumber, "Enter PAN Number"),
//                   SizedBox(height: 16),

//                   /*_buildTextField("bankName", "Bank Name", controller.bankName,
//                       "Enter Bank Name"),
// */
//                   _buildBankNameField(),
//                   SizedBox(height: 16),
//                   _buildTextField("ifscNumber", "Bank IFSC Number",
//                       controller.ifscNumber, "Enter IFSC Number"),
//                   SizedBox(height: 16),
//                   _buildTextField("bankAccountNumber", "Bank Account Number",
//                       controller.bankAccountNumber, "Enter Bank Account Number",
//                       isRequired: false, isNumeric: true),
//                   SizedBox(height: 16),
//                   _buildTextField("bplno", "BPL No", controller.bplNumber,
//                       "Enter BPL Number",
//                       isRequired: false, isNumeric: false),
//                   Obx(() => SwitchListTile(
//                         title: Text("Member"),
//                         value: controller.isMember.value,
//                         onChanged: (value) => controller.isMember.value = value,
//                       )),
//                   Obx(() => SwitchListTile(
//                         title: Text("Committee Member"),
//                         value: controller.isCommitteeMember.value,
//                         onChanged: (value) =>
//                             controller.isCommitteeMember.value = value,
//                       )),
//                   SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: Row(
//             children: [
//               // Cancel Button
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
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
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (controller.formKey.currentState!.saveAndValidate()) {
//                       final formData = controller.formKey.currentState!.value;
//                       print("Form Data: $formData");
//                       collectFormData();
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

//   Widget _buildBankNameField() {
//     return FormBuilderField<String>(
//       name: 'bankName',
//       //validator: FormBuilderValidators.required(errorText: 'Bank Name is required'),
//       builder: (FormFieldState<String> field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TypeAheadField<Bankmodel>(
//               suggestionsCallback: (search) {
//                 return controller.listBankName.value
//                     .where((member) => (member.bankName ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: controller.bankNameController,
//                   // Use our custom controller
//                   focusNode: focusNode,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter Bank Name',
//                     errorText: field.errorText, // Show validation error
//                   ),
//                 );
//               },
//               itemBuilder: (context, bankName) {
//                 return ListTile(
//                   title: Text(bankName.bankName ?? ""),
//                 );
//               },
//               onSelected: (member) {
//                 controller.selectedBankName.value = member;
//                 controller.bankNameController.text =
//                     member.bankName ?? ""; // Show selected value
//                 field.didChange(member.bankName);
//                 print(member.toJson());
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildMemberCodeField() {
//     return FormBuilderField<String>(
//       name: 'memberCode',
//       // validator:
//       // FormBuilderValidators.required(errorText: 'Member Code is required'),
//       builder: (FormFieldState<String> field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TypeAheadField<MMembersProfile>(
//               suggestionsCallback: (search) {
//                 return controller.listMembers.value
//                     .where((member) => (member.memberName ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: controller.memberCodeController,
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
//                 controller.selectedMember.value = member;
//                 controller.memberCodeController.text = member.memCode ?? "";
//                 field.didChange(member.memCode);
//                 setMemberDetails(member);
//               },
//             ),
//           ],
//         );
//       },
//     );
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
//       /*  validator: isRequired
//           ? FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: "$label is required"),
//               if (isNumeric)
//                 FormBuilderValidators.numeric(
//                     errorText: "$label must be a number"),
//             ])
//          : null,*/
//       validator: (value) {
//         if (isRequired && (value == null || value.isEmpty)) {
//           return "$label is required";
//         }

//         if (isNumeric && value != null && value.isNotEmpty) {
//           if (!RegExp(r'^\d+$').hasMatch(value)) {
//             return "$label must be a number";
//           }
//         }

//         if (name == "bankAccountNumber") {
//           if (value == null || value.length > 20 || !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
//             return "Please Enter Valid Account Number (no spaces or special characters)";
//           }
//         }

//         if (name == "aadharNumber") {
//           if (value == null || value.length != 12 || !RegExp(r'^\d{12}$').hasMatch(value)) {
//             return "Please Enter Valid 12-digit Aadhar Number";
//           }
//         }

//         if (name == "mobileNumber") {
//           if (value == null || value.length != 10) {
//             return "Please Enter Valid 10-digit Mobile Number";
//           }
//         }

//         if (name == "panNumber") {
//           if (value == null || value.length != 10) {
//             return "Please Enter Valid PAN Number (must be 10 characters)";
//           }

//           if (value != value.toUpperCase()) {
//             return "Please use only CAPITAL letters for PAN Number";
//           }

//           if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
//             return "Please Enter Valid PAN Number (e.g., ABCDE1234F)";
//           }
//         }

//         if (name == "bplno") {
//           if (value == null || value.length > 10 || !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
//             return "Please Enter Valid BPL Number (no spaces or special characters)";
//           }
//         }




//         return null;
//       },
//     );
//   }

//   Widget _buildRadioGroup(
//       String label, RxString controllerVar, List<String> options,
//       {bool isRequired = false}) {
//     return FormBuilderRadioGroup(
//       name: label,
//       decoration: InputDecoration(
//         labelText: label,
//         border: InputBorder.none, // Removes the underline
//       ),
//       options: options
//           .map((value) =>
//               FormBuilderFieldOption(value: value, child: Text(value)))
//           .toList(),
//       onChanged: (value) => controllerVar.value = value ?? "",
//       validator: isRequired
//           ? FormBuilderValidators.required(errorText: "$label is required")
//           : null,
//     );
//   }

//   void _showImagePickerDialog(BuildContext context) {
//     Get.defaultDialog(
//       title: "Choose Image",
//       content: Column(
//         children: [
//           ListTile(
//               title: Text("Camera"),
//               onTap: () => controller.pickImage(ImageSource.camera)),
//           ListTile(
//               title: Text("Gallery"),
//               onTap: () => controller.pickImage(ImageSource.gallery)),
//         ],
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
//                     fontSize: 16.sp,
//                     color: formattedDateValue.value.isNotEmpty
//                         ? Colors.black
//                         : Colors.black54,
//                   ),
//                 ),
//                 Icon(Icons.calendar_today, color: Colors.grey),
//               ],
//             ),
//           ),
//         ));
//   }

//   void setMemberDetails(MMembersProfile member) {
//     // Ensure form is initialized
//     if (controller.formKey.currentState != null) {
//       controller.formKey.currentState!.patchValue({
//         "memberCode": member.memCode ?? "",
//         "firstName": "${member.fname ?? " " }${ member.mname ?? ""}${ member.lname ?? ""}",
//         "middleName": member.mname ?? "",
//         "lastName": member.lname ?? "",
//         "mobileNumber": member.mobileNumber ?? "",
//         "gender": member.gender == 1 ? "Male" : "Female",
//         "noofcows": member.noOfCows ?? "",
//         "noofbufs": member.noOfBuffalos ?? "",
//         "nomineename": member.nomineeName ?? "",
//         "aadharNumber": member.adharNo ?? "",
//         "panNumber": member.pan ?? "",
//         "bankName": member.bankName ?? "",
//         "ifscNumber": member.ifscNumber ?? "",
//         "bankAccountNumber": member.bankAccountNo ?? "",
//         "bplno": member.bplNumber ?? "",
//       });

//       controller.isMember.value = member.isMember == 1 ? true : false;
//       controller.isCommitteeMember.value =
//           member.isCommitteeMember == 1 ? true : false;

//       // Handle Date Conversion
//       if (member.dob != null && member.dob!.isNotEmpty) {
//         DateTime parsedDate = DateTime.parse(member.dob!);
//         selDate.value = parsedDate;
//         selDateFormat.value = DateFormat("yyyy-MM-dd").format(parsedDate);
//         controller.formKey.currentState!
//             .patchValue({"date": selDateFormat.value});
//       } else {
//         selDate.value = null;
//         selDateFormat.value = "";
//         controller.formKey.currentState!.patchValue({"date": ""});
//       }

//       if (member.gender == 0) {
//         controller.formKey.currentState!.patchValue({"Gender": "Male"});
//       } else {
//         controller.formKey.currentState!.patchValue({"Gender": "Female"});
//       }

//       if (member.cattleTypeName != null) {
//         controller.cattleType.value = member.cattleTypeName!;
//         controller.formKey.currentState!
//             .patchValue({"CattleType": member.cattleTypeName!});
//       }
//     }
//   }

//   Future<void> collectFormData() async {
//     final formData = {
//       "memberCode": controller.memberCodeController.text,
//       "firstName": controller.firstName.value,
//       "middleName": controller.middleName.value,
//       "lastName": controller.lastName.value,
//       "dateOfBirth": selDateFormat.value,
//       "cattleType": controller.cattleType.value == "Cow"
//           ? "C"
//           : controller.cattleType.value == "Buff"
//               ? "B"
//               : "M",
//       "mobileNumber": controller.mobileNumber.value,
//       "gender": controller.gender.value == "Male" ? 0 : 1,
//       "noOfCows": controller.noOfCows.value,
//       "noOfBuffalo": controller.noOfBuffalo.value,
//       "nomineeName": controller.nomineeName.value,
//       "aadharNumber": controller.aadharNumber.value,
//       "panNumber": controller.panNumber.value,
//       "bankName": controller.selectedBankName.value.bankName,
//       "ifscNumber": controller.ifscNumber.value,
//       "bankAccountNumber": controller.bankAccountNumber.value,
//       "bplNumber": controller.bplNumber.value,
//       // This seems duplicated, check if it's correct
//       "isMember": controller.isMember.value == true ? 1 : 0,
//       "isCommitteeMember": controller.isCommitteeMember.value == true ? 1 : 0,
//     };

//     print("Collected Form Data: $formData");

//     int? maxMemCode = int.tryParse(
//         await StorageService().getString(AppConstants.maxmembercodePr));
//     int? maxMemCodeLocal = int.tryParse(Utils.replaceNullZero(await DBHelper()
//         .getScalarQueryStringFromDB(
//             "Select Max(MemCode) From MembersProfile")));

//     if (formData['memberCode'] == "") {
//       //means add
//       var strMemberCodeValue = "";
//       if (maxMemCodeLocal! > maxMemCode!) {
//         strMemberCodeValue = "${maxMemCodeLocal + 1}";
//       } else {
//         strMemberCodeValue = "${maxMemCode + 1}";
//       }

//       String query = """
//   INSERT INTO MembersProfile (
//     MemCode, DOB, MobileNumber, IsCommitteeMember, IsMember, BPLNumber, 
//     BankAccountNo, IFSCNumber, BankName, PAN, AdharNo, NomineeName, Gender, 
//     NoOfBuffalos, NoOfCows, Fname, Mname, Lname, MemberName, Photo, 
//     CattleTypeName, BankCode
//   ) VALUES (
//     '${Formatter.m4d(strMemberCodeValue)}', '${selDateFormat.value}','${formData["mobileNumber"]}', 
//     '${formData["isCommitteeMember"]}', '${formData["isMember"]}', '${formData["bplNumber"]}', 
//     '${formData["bankAccountNumber"]}', '${formData["ifscNumber"]}', '${formData["bankName"]}', 
//     '${formData["panNumber"]}', '${formData["aadharNumber"]}', '${formData["nomineeName"]}', '${formData["gender"]}', 
//     '${formData["noOfBuffalo"]}', '${formData["noOfCows"]}', '${formData["firstName"]}', '${formData["middleName"]}', 
//     '${formData["lastName"]}', '${controller.selectedMember.value.memberName}','', '${formData['cattleType']}', 
//     '${controller.selectedBankName.value.bankCode}'
//   );
// """;
//       DBHelper().executeRawQuery(query);

//     } else {

//       String updateQuery = """
// UPDATE MembersProfile SET 
//   DOB = '${selDateFormat.value}', 
//   CattleTypeName = '${formData["cattleType"]}', 
//   MobileNumber = '${formData["mobileNumber"]}', 
//   IsCommitteeMember = '${formData["isCommitteeMember"]}', 
//   IsMember = '${formData["isMember"]}', 
//   BPLNumber = '${formData["bplNumber"]}', 
//   BankAccountNo = '${formData["bankAccountNumber"]}', 
//   IFSCNumber = '${formData["ifscNumber"]}', 
//   BankName = '${formData["bankName"]}', 
//   PAN = '${formData["panNumber"]}', 
//   AdharNo = '${formData["aadharNumber"]}', 
//   NomineeName = '${formData["nomineeName"]}', 
//   Gender = '${formData["gender"]}', 
//   NoOfBuffalos = '${formData["noOfBuffalo"]}', 
//   NoOfCows = '${formData["noOfCows"]}', 
//   Fname = '${formData["firstName"]}', 
//   Photo = '', 
//   Mname = '${formData["middleName"]}', 
//   MemberName = '${controller.selectedMember.value.memberName}', 
//   Lname = '${formData["lastName"]}', 
//   BankCode = '${controller.selectedBankName.value.bankCode}' 
// WHERE Code = '${Formatter.m4d("${controller.selectedMember.value.memCode}")}';
// """;
//       DBHelper().executeRawQuery(updateQuery);
//     }

//   }
// }
