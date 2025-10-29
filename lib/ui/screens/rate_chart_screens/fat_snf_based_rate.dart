// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';

// class FatSNFBasedRateScreen extends StatefulWidget {
//   @override
//   State<FatSNFBasedRateScreen> createState() => _FatSNFBasedRateScreenState();
// }

// class _FatSNFBasedRateScreenState extends State<FatSNFBasedRateScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   final RxString selectedAnimal = "Buffalo".obs;

//   var istablet = Utils.checkTablet();

//   var dfFatSnf = NumberFormat("0.0").obs;

//   var fat="";
//   var snf="";
//   var rate="";
//   var effectiveDate="";
//   var isSubmitted=false.obs;
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//        () {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appColor,
//             title: Utils.normalText("Fat SNF Based Rate",
//                 size: istablet ? 4.sp : 15.sp, color: Colors.white),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // **Animal Selection**
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildAnimalOption("Buffalo"),
//                     _buildAnimalOption("Cow"),
//                   ],
//                 ),

//                 SizedBox(height: 16),

//                 // **Form Inputs**
//                 FormBuilder(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       _buildTextField("fat", "Fat %", true),
//                       SizedBox(height: 16),
//                       _buildTextField("snf", "SNF %", true),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 24),

//                 // **Show Rate Button**
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.saveAndValidate()) {
//                         final formData = _formKey.currentState!.value;
//                         print("Form Data: $formData");
//                          fat = formData['fat'];
//                          snf = formData['snf'];
//                         isSubmitted.value=true;
//                         var doublefat = double.tryParse(fat) ?? 0.0;
//                         var doublesnf = double.tryParse(snf) ?? 0.0;

//                         if (doublefat < 0.5) {
//                           Utils.showToast(
//                               "please Enter Fat values greater than 0.5");
//                           return;
//                         }

//                         if (doublefat > 12.5) {
//                           Utils.showToast("please Enter Fat values less than 12.5");
//                           return;
//                         }

//                         if (doublesnf < 6.5) {
//                           Utils.showToast(
//                               "please Enter Snf values greater than 6.5");
//                           return;
//                         }

//                         if (doublesnf > 11) {
//                           Utils.showToast("please Enter Snf values less than 11");
//                           return;
//                         }

//                         fat = dfFatSnf.value.format(double.tryParse(fat));

//                         String columnName = "FAT_${fat.replaceAll('.', '_')}";
//                         var strCattleType =
//                             selectedAnimal.value == "Buffalo" ? "B" : "C";

//                         String? formattedSnf =
//                             dfFatSnf.value.format(double.tryParse(snf ?? '') ?? 0);

//                         String queryRate =
//                             "SELECT $columnName FROM FATBasedRateChartManualExcel "
//                             "WHERE SNF = '$formattedSnf' AND CattleType = '$strCattleType'";

//                         String queryRate1 =
//                             "SELECT EffectiveDate FROM FATBasedRateChartManualExcel "
//                             "WHERE SNF = '$formattedSnf' AND CattleType = '$strCattleType'";

//                         rate =
//                             await DBHelper().getScalarQueryStringFromDB(queryRate);
//                         effectiveDate =
//                             await DBHelper().getScalarQueryStringFromDB(queryRate1);

//                         snf="${dfFatSnf.value.format(double.tryParse(snf))}%";


//                       } else {

//                         print("Form validation failed!");

//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.appColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                     ),
//                     child: Text("Show Rate", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),

//                 Utils.addGap(20),

//                 Visibility(
//                   visible:isSubmitted.value,
//                   child: Container(
//                     width: Utils.getScreenWidth(context),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             blurRadius: 5,
//                             spreadRadius: 2,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(16.sp),
//                       margin: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 5.sp),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             buildTextRow("Fat: ",fat),
//                             buildTextRow("Snf: ",snf),
//                             buildTextRow("Rate: ",rate),
//                             buildTextRow("EffectiveDate: ",effectiveDate),
//                           ])),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }

//   Widget buildTextRow(String title, String value) {
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

//   /// **Builds the Animal Selection UI**
//   Widget _buildAnimalOption(String animal) {
//     return Obx(() => GestureDetector(
//           onTap: () => selectedAnimal.value = animal,
//           child: Container(
//             width: istablet ? 160 : 120,
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: selectedAnimal.value == animal
//                   ? AppColors.appColor
//                   : Colors.grey[300],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 animal,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: selectedAnimal.value == animal
//                       ? Colors.white
//                       : Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   /// **Builds a text field with validation**
//   Widget _buildTextField(String name, String label, bool isRequired) {
//     return FormBuilderTextField(
//       name: name,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       validator: isRequired
//           ? FormBuilderValidators.required(errorText: "This field is required")
//           : null,
//       keyboardType: TextInputType.number,
//       decoration:
//           InputDecoration(labelText: label, border: OutlineInputBorder()),
//     );
//   }
// }
