// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/deduction_entry_controller.dart';
// import 'package:aasaan_flutter/controller/union_truck_entry_controller.dart';
// import 'package:aasaan_flutter/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../../db/db_helper.dart';
// import '../../../network/model/member_profile.dart';

// class DeductionEntryDetailScreen extends StatefulWidget {
//   @override
//   State<DeductionEntryDetailScreen> createState() =>
//       _DeductionEntryDetailScreenState();
// }

// class _DeductionEntryDetailScreenState
//     extends State<DeductionEntryDetailScreen> {
//   final DeductionEntryController controller =
//       Get.put(DeductionEntryController());
//   final FocusNode fromMemberFocus = FocusNode();
//   String strMemberCodeValue = "";

//   var istablet = Utils.checkTablet();
//   @override
//   void initState() {
//     getData();

//     super.initState();
//   }

//   getData() async {
//     controller.listMembers.value =
//         await DBHelper().getMembersProfile("Select * FROM MembersProfile");
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
//             title: Utils.normalText("Deduction Entry",
//                 size: istablet ? 3.sp : 15.sp, color: Colors.white),
//             backgroundColor: AppColors.appColor,
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             // 👈 Prevents keyboard overflow
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Utils.addGap(istablet ? 10 : 16),
//                   // **Form Inputs**
//                   FormBuilder(
//                     key: controller.formKey,
//                     child: Column(
//                       children: [
//                         Utils.addGap(istablet ? 10 : 8),
//                         _buildDateField(),
//                         Utils.addGap(istablet ? 16 : 15),
//                         /*   _buildTextField(
//                               "memCode",
//                               "Mem Code",
//                               true,
//                               (value) => controller.updateMemCode(value!),
//                               TextInputType.number),*/
//                         _buildMemberCodeField(),
//                         Utils.addGap(istablet ? 16 : 15),
//                     /*    TextField(
//                           style: TextStyle(
//                               fontSize: istablet ? 9.sp : 16.sp,
//                               color: Colors.black),
//                           readOnly: true,
//                           controller: controller.memberNameController,
//                           // validator: isRequired
//                           //     ? FormBuilderValidators.required(
//                           //         errorText: "This field is required")
//                           //     : null,
//                           // onChanged: onChanged,
//                           keyboardType: TextInputType.numberWithOptions(),
//                           decoration: InputDecoration(
//                               labelText: "Member Name",
//                               hintText: "Member Name",
//                               border: OutlineInputBorder()),
//                         ),
//                         // _buildTextField(
//                         //     "memName",
//                         //     "Member Name",
//                         //     true,
//                         //     (value) => controller.updateMermName(value!),
//                         //     TextInputType.text,
//                         //     false,
//                         //     ""),
//                         Utils.addGap(istablet ? 16 : 15),
//  */                       _buildDropDownField(
//                             ["Dan", "Ghee", "Bajra", "General", "Other"],
//                             (value) => controller.updateDeductionType(value!)),
//                         Utils.addGap(istablet ? 16 : 15),
//                         _buildTextField(
//                             "qty",
//                             "Qty",
//                             true,
//                             (value) => controller.updateQTY(value!),
//                             TextInputType.number,
//                             false,
//                             ""),
//                         Utils.addGap(istablet ? 16 : 15),
//                         _buildTextField(
//                             "rate",
//                             "Rate",
//                             true,
//                             (value) => controller.updateRate(value!),
//                             TextInputType.number,
//                             false,
//                             ""),
//                         Utils.addGap(istablet ? 16 : 15),
//                         _buildTextField(
//                             "amount",
//                             "Amount",
//                             false,
//                             (value) => controller.updateAmount(value!),
//                             TextInputType.number,
//                             true,
//                             controller.selectedAmount.value),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: Obx(() {
//             if (controller.isSuccess.value) {
//               // Show the dialog when success is true
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 showAutoDismissDialog(context);
//                 controller.isSuccess.value =
//                     false; // Reset it after showing the dialog
//               });
//             }

//             return Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => Get.back(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.zero),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
//                     ),
//                   ),
//                 ),

//                 // Submit Button
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       controller.submitForm();
//                       // if (controller.isSuccess.value) {
//                       //   // Do not call the dialog here anymore, handled by Obx
//                       // }
//                       controller.isSuccess.value = false;
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.zero),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ),
//       );
//     });
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
//           title: Text("Deduction Entry Done"),
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
//                 Get.offAllNamed(Routes.dashboard);
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

// /*
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
//                 return controller.listMembers.value
//                     .where((member) => (member.memberName ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: controller
//                       .memberCodeController, // Use our custom controller
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
//                   title: Text(
//                       "${member.memCode ?? ""}   (${member.memberName ?? ""})"),
//                 );
//               },
//               onSelected: (member) {
//                 controller.memberCodeController.text =
//                     member.memCode ?? ""; // Show selected value
//                 controller.selectedMemCode.value =
//                     controller.memberCodeController.text; //
//                 controller.memberNameController.text =
//                     member.memberName ?? ""; // Show selected value
//                 controller.selectedMernName.value =
//                     controller.memberNameController.text; //
//                 debugPrint(
//                     "Selected Member Code: ${controller.selectedMemCode.value}");
//                 field.didChange(member.memCode); // Update form value
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// */
//   Widget _buildMemberCodeField() {

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
//               /*FormBuilderValidators.minLength(4,
//                   errorText: 'Minimum 4 characters required'),*/
//             ]),
//             builder: (FormFieldState<String> field) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TypeAheadField<MMembersProfile>(
//                     builder: (context, textEditingController, focusNode) {
//                       controller
//                           .memberCodeController = textEditingController;
//                       return TextField(
//                         controller: textEditingController,
//                         focusNode: fromMemberFocus,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Enter Member Code',
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
//                           final matchedMember = controller.listMembers.value.firstWhere(
//                                 (member) => (member.memCode ?? "")
//                                 .toLowerCase()
//                                 .contains(adjustedQuery),
//                             orElse: () => MMembersProfile(),
//                           );

//                           if ((matchedMember.memCode ?? "").isNotEmpty) {

//                             // clearForm();

//                             // Set member data
//                             controller.memberCodeController.text =
//                             "${matchedMember.memCode}";
//                             controller.selectedMemCode.value=  "${matchedMember.memCode}";
//                             controller.selectedMernName.value= matchedMember.memberName ?? "";
//                             controller.memberNameController.text =
//                                 matchedMember.memberName ?? "";
//                             field.didChange(matchedMember.memCode);
//                             strMemberCodeValue = matchedMember.memCode ?? "";
//                           //  fromMemberFName = matchedMember.memberName;
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
//                             controller
//                                 .memberNameController.text = "";
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

//                       return controller
//                           .listMembers.value.where((member) {
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

//                       controller.memberCodeController.text = "${member.memCode ?? " "}";
//                       controller.selectedMernName.value = "${member.memberName}";
//                       field.didChange(
//                           member.memCode); // updates FormBuilder field value
//                       strMemberCodeValue = member.memCode ?? "";
//                       },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         Utils.addHGap(10),
//         Expanded(flex: 2, child: _buildSelectedMemberNameField())
//       ],
//     );
//   }
//   Widget _buildSelectedMemberNameField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         controller.selectedMernName.value.isEmpty ? 'Member Name' :controller.selectedMernName.value,
//         style: TextStyle(
//           fontSize: 16,
//           color: controller.selectedMernName.value.isEmpty ? Colors.grey : Colors.black,
//         ),
//       ),
//     );
//   }

//   /// **Builds the Animal Selection UI**
//   Widget _buildAnimalOption(String animal) {
//     final UnionTruckEntryController controller = Get.find();
//     return GestureDetector(
//       onTap: () => controller.updateAnimal(animal),
//       child: Obx(() => Container(
//             width: istablet ? 180 : 120,
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: controller.selectedAnimal.value == animal
//                   ? AppColors.appColor
//                   : Colors.grey[300],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 animal,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: controller.selectedAnimal.value == animal
//                       ? Colors.white
//                       : Colors.black,
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   /// **Builds a text field with validation**
//   // Widget _buildTextField(String name, String label, bool isRequired) {
//   //   return FormBuilderTextField(
//   //     style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//   //     name: name,
//   //     validator: isRequired
//   //         ? FormBuilderValidators.required(errorText: "This field is required")
//   //         : null,
//   //     keyboardType: TextInputType.number,
//   //     decoration:
//   //         InputDecoration(labelText: label, border: OutlineInputBorder()),
//   //   );
//   // }

//   Widget _buildTextField(
//       String name,
//       String label,
//       bool isRequired,
//       void Function(String?) onChanged,
//       TextInputType keyboardType,
//       bool isReadOnly,
//       String? hintText) {
//     return FormBuilderTextField(
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       readOnly: isReadOnly,
//       name: name,
//       validator: isRequired
//           ? FormBuilderValidators.required(errorText: "This field is required")
//           : null,
//       onChanged: onChanged,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//           labelText: label, hintText: hintText, border: OutlineInputBorder()),
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
//   Widget _buildDropDownField(
//       List<String> items, void Function(String?) onChanged) {
//     return FormBuilderDropdown(
//       name: "deduction type",
//       style: TextStyle(
//         fontSize: istablet ? 9.sp : 16.sp,
//         color: Colors.black,
//       ),
//       initialValue: "Dan",
//       decoration: InputDecoration(
//         labelText: "Deduction Type",
//         labelStyle: TextStyle(
//           fontSize: istablet ? 12.sp : 16.sp,
//         ),
//         border: OutlineInputBorder(),
//       ),
//       items: items
//           .map((session) =>
//               DropdownMenuItem(value: session, child: Text(session)))
//           .toList(),
//       onChanged: onChanged,
//       validator:
//           FormBuilderValidators.required(errorText: "Session is required"),
//     );
//   }
// }
// //
