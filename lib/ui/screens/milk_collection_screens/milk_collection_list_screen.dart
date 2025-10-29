// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/milkCollectionModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../../common/excel_export.dart';
// import '../../../common/utils/color_constants.dart';
// import '../../../common/utils/utility.dart';
// import '../../../main.dart';

// class MilkCollectionListScreen extends StatefulWidget {
//   @override
//   _MilkCollectionListScreenState createState() =>
//       _MilkCollectionListScreenState();
// }

// class _MilkCollectionListScreenState extends State<MilkCollectionListScreen> {
//   var istablet = Utils.checkTablet();
//   var isLoading = false.obs;
//   var list = <MilkCollection>[].obs;
//   var date = "".obs;
//   var session = "".obs;

//   @override
//   void initState() {
//     super.initState();

//     final arguments = Get.arguments;

//     date.value = arguments["date"] ?? "";
//     session.value = arguments["session"] ?? "";
//     getData(date, session);
//   }

//   getData(date, session) async {
// /*
//     String query = """
//   SELECT Code, AutoID, MemCode, CollDate, CollTime, CollSession,
//     printf('%.2f', (SUM(KgFat) / SUM(Liters))) as FAT,
//     printf('%.2f', SUM(Amount)) as Amount,
//     printf('%.2f', SUM(Liters)) as Liters,
//     Cattle, LitersEntryType,
//     printf('%.2f', (SUM(KgSnf) / SUM(Liters))) as SNF,
//     AVG(CLR) as CLR,
//     FAT_SNF_EntryType,
//     printf('%.2f', AVG(Rate)) as Rate,
//     Amount_Type, ReceiptPrinted, SentStatus,
//     SentOn, UploadStatus, UploadOn, IsSync, SampleNo,
//     VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, Locked,
//     KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount, IsSync
//   FROM MilkCollection
//   WHERE CollDate = '$date' AND CollSession = '$session' AND Locked <> '1'
//   GROUP BY MemCode, Cattle, CollSession
// """;
// */  //old query


//     String query = """
//   SELECT 
//     Code, AutoID, MemCode, CollDate, CollTime, CollSession,
//     printf('%.2f', FAT) as FAT,
//     printf('%.2f', Amount) as Amount,
//     printf('%.2f', Liters) as Liters,
//     Cattle, LitersEntryType,
//     printf('%.2f', SNF) as SNF,
//     CLR,
//     FAT_SNF_EntryType,
//     printf('%.2f', Rate) as Rate,
//     Amount_Type, ReceiptPrinted, SentStatus,
//     SentOn, UploadStatus, UploadOn, IsSync, SampleNo,
//     VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, Locked,
//     KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount, IsSync
//   FROM MilkCollection
//   WHERE CollDate = '$date' AND CollSession = '$session' AND Locked <> '1'
// """;


//     list.value = await DBHelper().getMilkCollection(query);

//     print(list.length);
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
//             appBar: AppBar(
//               backgroundColor: AppColors.appColor,
//               title: Utils.normalText("Milk Collection List",
//                   size: istablet ? 4.sp : 15.sp, color: Colors.white),
//               centerTitle: true,
//               actions: [
//                 GestureDetector(
//                     onTap: (){
//                       ExcelService.exportMilkCollectionToDownloadsFolder(list,date.value,"MilkCollection");
//                     },

//                     child: Icon(Icons.share)),
//                 Utils.addHGap(20)
//               ],
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(istablet ? 20.w : 10.w),
//               child:
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Row of titles
//                       Row(
//                         children: [
//                           _buildHeaderCellAction(""),
//                           _buildHeaderCell("FCD"),
//                           _buildHeaderCell("Ct"),
//                           _buildHeaderCell("Ltr"),
//                           _buildHeaderCell("Fat"),
//                           _buildHeaderCell("Snf"),

//                           _buildHeaderCell("Rate"),
//                           _buildHeaderCell("Amt"),
//                           _buildHeaderCell("Sync"),

//                         ],
//                       ),
//                       const SizedBox(height: 10),

//                       // Row of values (each entry is a column)
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: list.map((entry) {
//                               return Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: 100.sp,
//                                     height: 40.sp,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         IconButton(
//                                           icon: Icon(Icons.edit),
//                                           onPressed: () {
//                                             Get.back(result: entry);
//                                           },
//                                         ),
//                                         IconButton(
//                                           icon: Icon(Icons.delete),
//                                           onPressed: () async {
//                                             String query =
//                                                 "SELECT * FROM MilkCollection WHERE CollSession = '${entry.collSession}' AND Cattle = '${entry.cattle}' AND CollDate = '${entry.collDate}' AND MemCode = '${entry.memCode}' AND Locked <> '1'";
//                                             var listMilkCollection =
//                                             await DBHelper().getMilkCollection(query);
                          
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: Text("Confirm Delete"),
//                                                   content: Text("Are you sure you want to delete this entry?"),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () => Navigator.of(context).pop(),
//                                                       child: Text("No"),
//                                                     ),
//                                                     ElevatedButton(
//                                                       onPressed: () async {
//                                                         Navigator.of(context).pop();
//                                                         for (var mc in listMilkCollection) {
//                                                           await DBHelper().executeRawUpdateQuery(
//                                                               "UPDATE MilkCollection SET Locked = '1', TransactionType = 'DEL', IsSync = NULL  WHERE AutoID = '${entry.autoID}'");
//                                                         }
//                                                         isLoading.value=true;
//                                                         await commonController.callPostMilkCollection(true);
//                                                         getData(date, session);
//                                                         isLoading.value=false;

//                                                       },
//                                                       child: Text("Yes"),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   _buildDataCell(entry.memCode ?? ""),
//                                   _buildDataCell(entry.cattle == "C" ? "Cow" : entry.cattle == "B" ? "Buffalo" : ""),
//                                   _buildDataCell(entry.liters ?? ""),
//                                   _buildDataCell(entry.fat ?? ""),
//                                   _buildDataCell(entry.snf ?? ""),
//                                   _buildDataCell(entry.rate ?? ""),
//                                   _buildDataCell(entry.amount ?? ""),
//                                   syncStatusIcon(entry.isSync??0),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),


//               /*ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     final entry = list[index];
//                     return Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                               10), // Updated corner radius
//                         ),
//                         margin: EdgeInsets.all(8.0.sp),
//                         child: Padding(
//                             padding: EdgeInsets.all(12.0.sp),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Spacer(),
//                                       GestureDetector(
//                                           onTap: () {
//                                            // print(entry);
//                                             Get.back(result: entry,);
//                                           },
//                                           child: Icon(Icons.edit)),
//                                       Utils.addHGap(10),
//                                       GestureDetector(
//                                           onTap: () async {
//                                             *//*  String sessionName = fieldlist.get(position).getCollSession();
//                                             String Cattle = fieldlist.get(position).getCattle();
//                                             String CollDate = fieldlist.get(position).getCollDate();
//                                             String MemCode = fieldlist.get(position).getMemCode();
//                                             String AutoID = String.valueOf(fieldlist.get(position).getAutoID());
//                                             *//*
//                                             String sessionName =
//                                                 entry.collSession ?? "";
//                                             String Cattle = entry.cattle ?? "";

//                                             String CollDate =
//                                                 entry.collDate ?? "";
//                                             String MemCode =
//                                                 entry.memCode ?? "";
//                                             String AutoID =
//                                                 "${entry.autoID ?? 0}";
//                                             String query =
//                                                 "SELECT * FROM MilkCollection "
//                                                 "WHERE CollSession = '$sessionName' "
//                                                 "AND Cattle = '$Cattle' "
//                                                 "AND CollDate = '$CollDate' "
//                                                 "AND MemCode = '$MemCode' "
//                                                 "AND Locked <> '1'";

//                                             var listMilkCollection =
//                                                 await DBHelper()
//                                                     .getMilkCollection(query);

//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: Text("Confirm Delete"),
//                                                   content: Text(
//                                                       "Are you sure you want to delete this entry?"),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop(); // Closes dialog
//                                                       },
//                                                       child: Text("No"),
//                                                     ),
//                                                     ElevatedButton(
//                                                       onPressed: () async {
//                                                         Navigator.of(context)
//                                                             .pop(); // Close dialog

//                                                         for (int i = 0;
//                                                             i <
//                                                                 listMilkCollection
//                                                                     .length;
//                                                             i++) {
//                                                           await DBHelper()
//                                                               .executeRawUpdateQuery(
//                                                                   "UPDATE MilkCollection SET Locked = '1' WHERE AutoID = '$AutoID'");
//                                                         }

//                                                         getData(date, session);
//                                                       },
//                                                       child: Text("Yes"),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Icon(Icons.delete)),
//                                       Utils.addHGap(10),
//                                     ],
//                                   ),
//                                   Utils.addGap(15),
//                                   _buildTextRow(
//                                       "Member Code : ", entry.memCode ?? ""),
//                                   _buildTextRow("Rate : ", entry.rate ?? ""),
//                                   _buildTextRow("Fat : ", entry.fat ?? ""),
//                                   _buildTextRow("Liter : ", entry.liters ?? ""),
//                                   _buildTextRow(
//                                       "Amount : ", entry.amount ?? ""),
//                                   _buildTextRow(
//                                     "Cattle : ",
//                                     entry.cattle == "C"
//                                         ? "Cow"
//                                         : entry.cattle == "B"
//                                             ? "Buffalo"
//                                             : "",
//                                   ),
//                                   _buildTextRow("Payment Type : ",
//                                       "${entry.paymentType}"),
//                                 ])));
//                   })*/
//             )),
//       );
//     });
//   }


//   Widget _buildHeaderCell(String title) {
//     return Container(
//       width: 90.sp,
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
//       width: 100.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }
//   Widget _buildDataCell(String value) {
//     return Container(
//       width: 90.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(value),
//     );
//   }

//   Widget syncStatusIcon(int isSynced) {
//     return  Container(
//       width: 90.sp,
//       height: 40.sp,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Icon(
//         isSynced ==1? Icons.check_circle : Icons.close,
//         color: isSynced == 1? Colors.green : Colors.red,
//       ),
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
