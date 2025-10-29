// import 'dart:io';
// import 'package:excel/excel.dart';
// import 'package:flutter/services.dart';

// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// import '../network/model/deduction_model.dart';
// import '../network/model/member_profile.dart';
// import '../network/model/milkCollectionModel.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:io';
// import 'package:printing/printing.dart';

// import '../network/model/odairy_register_model.dart';
// import '../network/model/share_register_model.dart';
// import '../network/model/session_time_model.dart';
// import 'file_share_service.dart';

// class ExcelService {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initNotifications() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initSettings =
//         InitializationSettings(android: androidSettings);
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }

//   static Future<void> _showDownloadNotification(String filePath) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails('download_channel', 'Downloads',
//             channelDescription: 'Shows notification when file is downloaded',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');

//     const NotificationDetails platformDetails =
//         NotificationDetails(android: androidDetails);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Download Complete',
//       'Milk Collection Excel saved to: $filePath',
//       platformDetails,
//     );
//   }

//   static Future<void> exportMilkCollectionToDownloadsFolder(
//       List<MilkCollection> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();
//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       // Create Excel
//       var excel = Excel.createExcel();
//       Sheet sheet = excel['MilkCollection'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('Session'),
//         TextCellValue('Member Code'),
//         TextCellValue('Cattle'),
//         TextCellValue('Liters'),
//         TextCellValue('FAT'),
//         TextCellValue('SNF'),
//         TextCellValue('Rate'),
//         TextCellValue('Amount'),
//         TextCellValue('IsSynced'),
//       ]);

//       for (var item in list) {
//         sheet.appendRow([
//           TextCellValue(item.collDate ?? ''),
//           TextCellValue(item.collSession ?? ''),
//           TextCellValue(item.memCode ?? ''),
//           TextCellValue(item.cattle == "C"
//               ? "Cow"
//               : item.cattle == "B"
//                   ? "Buffalo"
//                   : ''),
//           TextCellValue(item.liters?.toString() ?? ''),
//           TextCellValue(item.fat?.toString() ?? ''),
//           TextCellValue(item.snf?.toString() ?? ''),
//           TextCellValue(item.rate?.toString() ?? ''),
//           TextCellValue(item.amount?.toString() ?? ''),
//           TextCellValue(item.isSync == 1 ? "Yes" : "No"),
//         ]);
//       }

//       // Save to Downloads
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-${date}.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromMilkCollection(title, list, date,filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting to Downloads: $e ❌");
//     }
//   }

//   static Future<void> exportMilkCollectionToDownloadsFolderForLedger(
//       List<MilkCollection> list, String date, String title) async {
//     try {
//       // Permission handling
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();
//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       // Create Excel
//       var excel = Excel.createExcel();
//       Sheet sheet = excel['MilkCollection'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('Cattle'),
//         TextCellValue('Session'),
//         TextCellValue('Liters'),
//         TextCellValue('FAT'),
//         TextCellValue('SNF'),
//         TextCellValue('Amount'),
//       ]);

//       for (var item in list) {
//         sheet.appendRow([
//           TextCellValue(item.collDate ?? ''),
//           TextCellValue(item.cattle == "C"
//               ? "Cow"
//               : item.cattle == "B"
//               ? "Buffalo"
//               : item.cattle ?? ''),
//           TextCellValue(item.collSession ?? ''),
//           TextCellValue(item.liters?.toString() ?? ''),
//           TextCellValue(item.fat?.toString() ?? ''),
//           TextCellValue(item.snf?.toString() ?? ''),
//           TextCellValue(item.amount != null ? "₹${item.amount}" : ''),
//         ]);
//       }

//       // Save to Downloads
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromMilkCollectionForLedger(title, list, date, filePath);
//       Utils.showToast("Ledger Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting ledger: $e ❌");
//     }
//   }

//   static Future<void> exportDairyRegisterToDownloadsFolder(
//       List<Odairyregistermodel> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();
//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['DairyRegister'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('Cattle Type'),
//         TextCellValue('Session'),
//         TextCellValue('Member Count'),
//         TextCellValue('Liters'),
//         TextCellValue('Fat'),
//         TextCellValue('Amount'),
//         TextCellValue('Local Sale Liter'),
//         TextCellValue('Local Sale Amount'),
//         TextCellValue('Union Weight'),
//         TextCellValue('Union Fat'),
//         TextCellValue('Union SNF'),
//         TextCellValue('Union Rate'),
//         TextCellValue('Union Amount'),
//         TextCellValue('Profit Weight'),
//         TextCellValue('Profit Amount'),
//       ]);

//       for (var file in list) {
//         final profitWeight = ((file.saleGood1Weight ?? 0.0) -
//             (file.purchaseMilkWeight ?? 0.0) -
//             (file.localWeight ?? 0.0))
//             .abs();
//         final profitAmount = ((file.saleGood1Amount ?? 0.0) -
//             (file.purchaseMilkAmount ?? 0.0) -
//             (file.localAmount ?? 0.0))
//             .abs();

//         sheet.appendRow([
//           TextCellValue(file.entryDate ?? ''),
//           TextCellValue(file.category ?? ''),
//           TextCellValue(file.session ?? ''),
//           TextCellValue(file.purchaseMilkMembers?.toString() ?? ''),
//           TextCellValue(file.purchaseMilkWeight?.toString() ?? ''),
//           TextCellValue(file.purchaseMilkFat?.toString() ?? ''),
//           TextCellValue(file.purchaseMilkAmount?.toString() ?? ''),
//           TextCellValue(file.localWeight?.toString() ?? ''),
//           TextCellValue(file.localAmount?.toString() ?? ''),
//           TextCellValue(file.saleGood1Weight?.toString() ?? ''),
//           TextCellValue(file.saleGood1Fat?.toString() ?? ''),
//           TextCellValue(file.saleGood1SNF?.toString() ?? ''),
//           TextCellValue(file.saleGood1Rate?.toString() ?? ''),
//           TextCellValue(file.saleGood1Amount?.toString() ?? ''),
//           TextCellValue(profitWeight.toStringAsFixed(2)),
//           TextCellValue(profitAmount.toStringAsFixed(2)),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String filePath = '${downloadsDir.path}/$title-$date.xlsx';
//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromDairyRegister(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting: $e ❌");
//     }
//   }

//   static Future<void> exportShareRegisterToDownloadsFolder(
//       List<MShareRegister> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();

//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['ShareRegister'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('Mem Code'),
//         TextCellValue('Location Code'),
//         TextCellValue('Share Quality'),
//         TextCellValue('Share Amount'),
//         TextCellValue('Total'),
//         TextCellValue('Share'),
//         TextCellValue('Chiller Amount'),
//       ]);

//       for (var item in list) {
//         sheet.appendRow([
//           TextCellValue(item.date ?? ''),
//           TextCellValue(item.memCode ?? ''),
//           TextCellValue(item.locationCode?.toString() ?? ''),
//           TextCellValue(item.shareQuality.toString()),
//           TextCellValue(item.shareAmount.toString()),
//           TextCellValue(item.total.toString()),
//           TextCellValue(item.share.toString()),
//           TextCellValue(item.shareChillerAmount.toString()),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromShareRegister(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting Share Register: $e ❌");
//     }
//   }

//   static Future<void> exportKapatReportToDownloadsFolder(
//       List<Deduction> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();

//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['KapatReport'];
//       sheet.appendRow([
//         TextCellValue('SR No'),
//         TextCellValue('Member Code'),
//         TextCellValue('Voucher Date'),
//         TextCellValue('Deduction Type'),
//         TextCellValue('Qty'),
//         TextCellValue('Rate'),
//         TextCellValue('Amount'),
//       ]);

//       for (int i = 0; i < list.length; i++) {
//         final item = list[i];
//         sheet.appendRow([
//           TextCellValue((i + 1).toString()),
//           TextCellValue(item.memberCode ?? ''),
//           TextCellValue(item.voucherDate ?? ''),
//           TextCellValue(item.deductionType ?? ''),
//           TextCellValue(item.qty?.toString() ?? ''),
//           TextCellValue(item.rate?.toString() ?? ''),
//           TextCellValue(item.amount?.toString() ?? ''),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromKapatReport(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting Kapat Report: $e ❌");
//     }
//   }

//   static Future<void> exportElectionRegisterToDownloadsFolder(
//       List<MilkCollection> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();

//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['ElectionRegister'];
//       sheet.appendRow([
//         TextCellValue('SR No'),
//         TextCellValue('Member Code'),
//         TextCellValue('Member Name'),
//         TextCellValue('Date'),
//         TextCellValue('Liters'),
//         TextCellValue('FAT'),
//         TextCellValue('SNF'),
//         TextCellValue('Amount'),
//       ]);

//       for (int i = 0; i < list.length; i++) {
//         final item = list[i];
//         sheet.appendRow([
//           TextCellValue((i + 1).toString()),
//           TextCellValue(item.memCode ?? ''),
//           TextCellValue(item.memName ?? ''),
//           TextCellValue(item.collDate ?? ''),
//           TextCellValue(item.liters?.toString() ?? ''),
//           TextCellValue(item.fat?.toString() ?? ''),
//           TextCellValue(item.snf?.toString() ?? ''),
//           TextCellValue(item.amount?.toString() ?? ''),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromElectionRegister(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting Election Register: $e ❌");
//     }
//   }

//   static Future<void> exportMemberMasterToDownloadsFolder(
//       List<MMembersProfile> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();

//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['MemberMaster'];
//       sheet.appendRow([
//         TextCellValue('SR No'),
//         TextCellValue('Member Name'),
//         TextCellValue('Cattle Type'),
//         TextCellValue('Phone'),
//         TextCellValue('Bank Name'),
//         TextCellValue('Bank Account No'),
//       ]);

//       for (int i = 0; i < list.length; i++) {
//         final item = list[i];
//         sheet.appendRow([
//           TextCellValue((i + 1).toString()),
//           TextCellValue(item.memberName ?? ''),
//           TextCellValue(item.cattleTypeName ?? ''),
//           TextCellValue(item.mobileNumber ?? ''),
//           TextCellValue(item.bankName ?? ''),
//           TextCellValue(item.bankAccountNo ?? ''),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromMemberMaster(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting Member Master: $e ❌");
//     }
//   }

//   static Future<void> exportBonusReportToDownloadsFolder(
//       List<MilkCollection> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();

//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['BonusReport'];
//       sheet.appendRow([
//         TextCellValue('SR No'),
//         TextCellValue('Member Code'),
//         TextCellValue('Member Name'),
//         TextCellValue('Days'),
//         TextCellValue('Liters'),
//         TextCellValue('Amount'),
//         TextCellValue('Bonus'),
//       ]);

//       for (int i = 0; i < list.length; i++) {
//         final item = list[i];
//         sheet.appendRow([
//           TextCellValue((i + 1).toString()),
//           TextCellValue(item.memCode ?? ''),
//           TextCellValue(item.memName ?? ''),
//           TextCellValue(item.collDate ?? ''),
//           TextCellValue(item.liters ?? ''),
//           TextCellValue(item.amount?.toString() ?? ''),
//           TextCellValue(item.bonus?.toString() ?? ''),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       await generatePdfFromBonusReport(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting Bonus Report: $e ❌");
//     }
//   }

//   static Future<void> generatePdfFromBonusReport(
//       String title, List<MilkCollection> list, String date, String excelPath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'SR No',
//                   'Member Code',
//                   'Member Name',
//                   'Days',
//                   'Liters',
//                   'Amount',
//                   'Bonus',
//                 ],
//                 data: List.generate(list.length, (i) {
//                   final item = list[i];
//                   return [
//                     (i + 1).toString(),
//                     item.memCode ?? '',
//                     item.memName ?? '',
//                     item.collDate ?? '',
//                     item.liters ?? '',
//                     item.amount?.toString() ?? '',
//                     item.bonus?.toString() ?? '',
//                   ];
//                 }),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle: pw.TextStyle(
//                     fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelPath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }


//   static Future<void> generatePdfFromMemberMaster(
//       String title, List<MMembersProfile> list, String date, String excelPath) async {
//     final pdf = pw.Document();
//     final fontData = await rootBundle.load("assets/fonts/NotoSansDevanagari-Regular.ttf");
//     final ttf = pw.Font.ttf(fontData);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                     font: ttf,
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'SR No',
//                   'Member Name',
//                   'Cattle Type',
//                   'Phone',
//                   'Bank Name',
//                   'Bank Account No',
//                 ],
//                 data: List.generate(list.length, (i) {
//                   final item = list[i];
//                   return [
//                     (i + 1).toString(),
//                     item.memberName ?? '',
//                     item.cattleTypeName ?? '',
//                     item.mobileNumber ?? '',
//                     item.bankName ?? '',
//                     item.bankAccountNo ?? '',
//                   ];
//                 }),
//                 cellStyle: pw.TextStyle(font: ttf,fontSize: 10),
//                 headerStyle: pw.TextStyle(
//                     font: ttf,
//                     fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelPath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }


//   static Future<void> generatePdfFromElectionRegister(
//       String title, List<MilkCollection> list, String date, String excelPath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'SR No',
//                   'Member Code',
//                   'Member Name',
//                   'Date',
//                   'Liters',
//                   'FAT',
//                   'SNF',
//                   'Amount',
//                 ],
//                 data: List.generate(list.length, (i) {
//                   final item = list[i];
//                   return [
//                     (i + 1).toString(),
//                     item.memCode ?? '',
//                     item.memName ?? '',
//                     item.collDate ?? '',
//                     item.liters?.toString() ?? '',
//                     item.fat?.toString() ?? '',
//                     item.snf?.toString() ?? '',
//                     item.amount?.toString() ?? '',
//                   ];
//                 }),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle: pw.TextStyle(
//                     fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelPath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }


//   static Future<void> generatePdfFromKapatReport(
//       String title, List<Deduction> list, String date, String excelPath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'SR No',
//                   'Member Code',
//                   'Voucher Date',
//                   'Deduction Type',
//                   'Qty',
//                   'Rate',
//                   'Amount',
//                 ],
//                 data: List.generate(list.length, (i) {
//                   final item = list[i];
//                   return [
//                     (i + 1).toString(),
//                     item.memberCode ?? '',
//                     item.voucherDate ?? '',
//                     item.deductionType ?? '',
//                     item.qty?.toString() ?? '',
//                     item.rate?.toString() ?? '',
//                     item.amount?.toString() ?? '',
//                   ];
//                 }),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle: pw.TextStyle(
//                     fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelPath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }


//   static Future<void> generatePdfFromShareRegister(
//       String title, List<MShareRegister> list, String date, String excelPath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'Date',
//                   'Mem Code',
//                   'Location Code',
//                   'Share Quality',
//                   'Share Amount',
//                   'Total',
//                   'Share',
//                   'Chiller Amount',
//                 ],
//                 data: list.map((item) {
//                   return [
//                     item.date ?? '',
//                     item.memCode ?? '',
//                     item.locationCode?.toString() ?? '',
//                     item.shareQuality.toString(),
//                     item.shareAmount.toString(),
//                     item.total.toString(),
//                     item.share.toString(),
//                     item.shareChillerAmount.toString(),
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle: pw.TextStyle(
//                     fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelPath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }

//   static Future<void> generatePdfFromDairyRegister(
//       String title, List<Odairyregistermodel> list, String date, String exelfilepath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'Date',
//                   'Cattle Type',
//                   'Session',
//                   'Member Count',
//                   'Liters',
//                   'Fat',
//                   'Amount',
//                   'Local Sale Liter',
//                   'Local Sale Amount',
//                   'Union Weight',
//                   'Union Fat',
//                   'Union SNF',
//                   'Union Rate',
//                   'Union Amount',
//                   'Profit Weight',
//                   'Profit Amount',
//                 ],
//                 data: list.map((file) {
//                   final profitWeight = ((file.saleGood1Weight ?? 0.0) -
//                       (file.purchaseMilkWeight ?? 0.0) -
//                       (file.localWeight ?? 0.0))
//                       .abs();
//                   final profitAmount = ((file.saleGood1Amount ?? 0.0) -
//                       (file.purchaseMilkAmount ?? 0.0) -
//                       (file.localAmount ?? 0.0))
//                       .abs();

//                   return [
//                     file.entryDate ?? '',
//                     file.category ?? '',
//                     file.session ?? '',
//                     file.purchaseMilkMembers?.toString() ?? '',
//                     file.purchaseMilkWeight?.toString() ?? '',
//                     file.purchaseMilkFat?.toString() ?? '',
//                     file.purchaseMilkAmount?.toString() ?? '',
//                     file.localWeight?.toString() ?? '',
//                     file.localAmount?.toString() ?? '',
//                     file.saleGood1Weight?.toString() ?? '',
//                     file.saleGood1Fat?.toString() ?? '',
//                     file.saleGood1SNF?.toString() ?? '',
//                     file.saleGood1Rate?.toString() ?? '',
//                     file.saleGood1Amount?.toString() ?? '',
//                     profitWeight.toStringAsFixed(2),
//                     profitAmount.toStringAsFixed(2),
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle:
//                 pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: exelfilepath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }



//   static Future<void> generatePdfFromMilkCollectionForLedger(
//       String title, List<MilkCollection> list, String date, String exelfilepath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'Date',
//                   'Cattle',
//                   'Session',
//                   'Liters',
//                   'FAT',
//                   'SNF',
//                   'Amount',
//                 ],
//                 data: list.map((item) {
//                   return [
//                     item.collDate ?? '',
//                     item.cattle == 'C'
//                         ? 'Cow'
//                         : item.cattle == 'B'
//                         ? 'Buffalo'
//                         : item.cattle ?? '',
//                     item.collSession ?? '',
//                     item.liters?.toString() ?? '',
//                     item.fat?.toString() ?? '',
//                     item.snf?.toString() ?? '',
//                     item.amount != null ? '₹${item.amount}' : '',
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle:
//                 pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("Ledger PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: exelfilepath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating ledger PDF: $e ❌");
//     }
//   }
//   static Future<void> exportLocalMilkSaleToDownloadsFolder(
//       List<Odairyregistermodel> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();
//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       var excel = Excel.createExcel();
//       Sheet sheet = excel['LocalMilkSale'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('SSN'),
//         TextCellValue('Cattle'),
//         TextCellValue('Liters'),
//         TextCellValue('Rate'),
//         TextCellValue('Amount'),
//       ]);

//       for (var item in list) {
//         sheet.appendRow([
//           TextCellValue(item.entryDate ?? ''),
//           TextCellValue(item.session ?? ''),
//           TextCellValue(item.category ?? ''),
//           TextCellValue(item.localWeight?.toString() ?? ''),
//           TextCellValue(item.localRate?.toString() ?? ''),
//           TextCellValue(item.localAmount?.toString() ?? ''),
//         ]);
//       }

//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromLocalMilkSale(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting: $e ❌");
//     }
//   }

//   static Future<void> generatePdfFromLocalMilkSale(
//       String title, List<Odairyregistermodel> list, String date, String exelfilepath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'Date',
//                   'SSN',
//                   'Cattle',
//                   'Liters',
//                   'Rate',
//                   'Amount',
//                 ],
//                 data: list.map((file) {
//                   return [
//                     file.entryDate ?? '',
//                     file.session ?? '',
//                     file.category ?? '',
//                     file.localWeight?.toString() ?? '',
//                     file.localRate?.toString() ?? '',
//                     file.localAmount?.toString() ?? '',
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle:
//                 pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: exelfilepath,
//         pdfPath: file.path,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }


//   static Future<void> generatePdfFromMilkCollection(
//       String title, List<MilkCollection> list, String date,String exelfilepath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'Date',
//                   'Session',
//                   'Member Code',
//                   'Cattle',
//                   'Liters',
//                   'FAT',
//                   'SNF',
//                   'Rate',
//                   'Amount',
//                   'IsSynced',
//                 ],
//                 data: list.map((item) {
//                   return [
//                     item.collDate ?? '',
//                     item.collSession ?? '',
//                     item.memCode ?? '',
//                     item.cattle == 'C'
//                         ? 'Cow'
//                         : item.cattle == 'B'
//                             ? 'Buffalo'
//                             : '',
//                     item.liters?.toString() ?? '',
//                     item.fat?.toString() ?? '',
//                     item.snf?.toString() ?? '',
//                     item.rate?.toString() ?? '',
//                     item.amount?.toString() ?? '',
//                     item.isSync == 1 ? 'Yes' : 'No',
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle:
//                     pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final file = File('${downloadsDir.path}/$title-$date.pdf');
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(file.path);
//       Utils.showToast("PDF saved to ${file.path} ✅");

//       await FileShareService.shareFiles(
//         excelPath: exelfilepath,
//         pdfPath:file.path,
//       );

//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }

//   static Future<void> exportSessionReportToExcel(
//     List<MilkCollection> cowEntries,
//     List<MilkCollection> buffEntries,
//     Map<String, double> cowSummary,
//     Map<String, double> buffSummary,
//   ) async {
//     final deviceInfo = await DeviceInfoPlugin().androidInfo;
//     int sdkInt = deviceInfo.version.sdkInt;

//     var permission = sdkInt >= 33
//         ? await Permission.photos.request()
//         : await Permission.storage.request();
//     if (!permission.isGranted) {
//       Utils.showToast("Permission denied ❌");
//       return;
//     }
//     var excel = Excel.createExcel();
//     Sheet sheet = excel['Session_Summary'];

//     // === Cow List Header ===
//     sheet.appendRow([TextCellValue('Cow Milk Collection')]);
// /*    sheet.appendRow([
//       TextCellValue('Date'),
//       TextCellValue('Member ID'),
//       TextCellValue('Member Name'),
//       TextCellValue('Cow Milk (L)'),
//     ]);
//     for (var entry in cowEntries) {
//       sheet.appendRow([
//         TextCellValue(entry.collDate),
//         TextCellValue(entry.memCode),
//         TextCellValue(entry.memName),
//         TextCellValue(entry.cowMilk.toStringAsFixed(2)),
//       ]);
//     }*/

//     sheet.appendRow([
//       TextCellValue('Member Code'),
//       TextCellValue('Cattle'),
//       TextCellValue('Liters'),
//       TextCellValue('FAT'),
//       TextCellValue('SNF'),
//       TextCellValue('Rate'),
//       TextCellValue('Amount'),
//     ]);

//     for (var item in cowEntries) {
//       sheet.appendRow([
//         TextCellValue(item.memCode ?? ''),
//         TextCellValue(item.cattle == "C"
//             ? "Cow"
//             : item.cattle == "B"
//                 ? "Buffalo"
//                 : ''),
//         TextCellValue(item.liters?.toString() ?? ''),
//         TextCellValue(item.fat?.toString() ?? ''),
//         TextCellValue(item.snf?.toString() ?? ''),
//         TextCellValue(item.rate?.toString() ?? ''),
//         TextCellValue(item.amount?.toString() ?? ''),
//       ]);
//     }

//     // === Cow Summary ===
//     sheet.appendRow([]);
//     sheet.appendRow([TextCellValue('Summary (Cow)')]);
//     cowSummary.forEach((key, value) {
//       sheet.appendRow([
//         TextCellValue(key),
//         TextCellValue(value.toStringAsFixed(2)),
//       ]);
//     });

//     // === Separator ===
//     sheet.appendRow([]);
//     sheet.appendRow([]);

//     // === Buffalo List Header ===
//     sheet.appendRow([TextCellValue('Buffalo Milk Collection')]);
//     sheet.appendRow([
//       TextCellValue('Member Code'),
//       TextCellValue('Cattle'),
//       TextCellValue('Liters'),
//       TextCellValue('FAT'),
//       TextCellValue('SNF'),
//       TextCellValue('Rate'),
//       TextCellValue('Amount'),
//     ]);

//     for (var item in buffEntries) {
//       sheet.appendRow([
//         TextCellValue(item.memCode ?? ''),
//         TextCellValue(item.cattle == "C"
//             ? "Cow"
//             : item.cattle == "B"
//                 ? "Buffalo"
//                 : ''),
//         TextCellValue(item.liters?.toString() ?? ''),
//         TextCellValue(item.fat?.toString() ?? ''),
//         TextCellValue(item.snf?.toString() ?? ''),
//         TextCellValue(item.rate?.toString() ?? ''),
//         TextCellValue(item.amount?.toString() ?? ''),
//       ]);
//     }

//     // === Cow Summary ===
//     sheet.appendRow([]);
//     sheet.appendRow([TextCellValue('Summary (Cow)')]);
//     cowSummary.forEach((key, value) {
//       sheet.appendRow([
//         TextCellValue(key),
//         TextCellValue(value.toStringAsFixed(2)),
//       ]);
//     });

//     // === Buffalo Summary ===
//     sheet.appendRow([]);
//     sheet.appendRow([TextCellValue('Summary (Buffalo)')]);
//     buffSummary.forEach((key, value) {
//       sheet.appendRow([
//         TextCellValue(key),
//         TextCellValue(value.toStringAsFixed(2)),
//       ]);
//     });

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }
//       String fileName = 'SessionReport.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);

//       Utils.showToast("Excel saved to $filePath ✅");
//       exportSessionReportToPDF( cowEntries,buffEntries,cowSummary,buffSummary,filePath);

//     } catch (e) {
//       Utils.showToast("Error exporting to Downloads: $e ❌");
//     }
//   }

//   static Future<void> exportSessionReportToPDF(
//       List<MilkCollection> cowEntries,
//       List<MilkCollection> buffEntries,
//       Map<String, double> cowSummary,
//       Map<String, double> buffSummary,
//      String excelfilepath ) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Text('Cow Milk Collection', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 8),
//           _buildTable(cowEntries),
//           pw.SizedBox(height: 16),
//           pw.Text('Summary (Cow)', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//           _buildSummaryTable(cowSummary),
//           pw.SizedBox(height: 24),
//           pw.Text('Buffalo Milk Collection', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 8),
//           _buildTable(buffEntries),
//           pw.SizedBox(height: 16),
//           pw.Text('Summary (Buffalo)', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//           _buildSummaryTable(buffSummary),
//         ],
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }
//       String fileName = 'SessionReport.pdf';
//       String filePath = '${downloadsDir.path}/$fileName';

//       final file = File(filePath);
//       await file.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(filePath);
//       Utils.showToast("PDF saved to $filePath ✅");
//       await FileShareService.shareFiles(
//         excelPath: excelfilepath,
//         pdfPath: filePath,
//       );

//     } catch (e) {
//       Utils.showToast("Error exporting PDF: $e ❌");
//     }
//   }
//   static pw.Table _buildTable(List<MilkCollection> entries) {
//     return pw.Table.fromTextArray(
//       headers: ['Member Code', 'Cattle', 'Liters', 'FAT', 'SNF', 'Rate', 'Amount'],
//       data: entries.map((e) {
//         return [
//           e.memCode ?? '',
//           e.cattle == "C"
//               ? "Cow"
//               : e.cattle == "B"
//               ? "Buffalo"
//               : '',
//           e.liters != null ? double.tryParse(e.liters!)?.toStringAsFixed(2) ?? '' : '',
//           e.fat != null ? double.tryParse(e.fat!)?.toStringAsFixed(2) ?? '' : '',
//           e.snf != null ? double.tryParse(e.snf!)?.toStringAsFixed(2) ?? '' : '',
//           e.rate != null ? double.tryParse(e.rate!)?.toStringAsFixed(2) ?? '' : '',
//           e.amount != null ? double.tryParse(e.amount!)?.toStringAsFixed(2) ?? '' : '',
//         ];
//       }).toList(),
//       cellStyle: pw.TextStyle(fontSize: 10),
//       headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
//       border: pw.TableBorder.all(),
//     );
//   }

//   static pw.Widget _buildSummaryTable(Map<String, double> summary) {
//     return pw.Table.fromTextArray(
//       headers: ['Metric', 'Value'],
//       data: summary.entries.map((e) => [e.key, e.value.toStringAsFixed(2)]).toList(),
//       cellStyle: pw.TextStyle(fontSize: 10),
//       headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
//       border: pw.TableBorder.all(),
//     );
//   }



//   static Future<void> exportSessionTimeToDownloadsFolder(
//       List<MSessionTime> list, String date, String title) async {
//     try {
//       final deviceInfo = await DeviceInfoPlugin().androidInfo;
//       int sdkInt = deviceInfo.version.sdkInt;

//       var permission = sdkInt >= 33
//           ? await Permission.photos.request()
//           : await Permission.storage.request();
//       if (!permission.isGranted) {
//         Utils.showToast("Permission denied ❌");
//         return;
//       }

//       // Create Excel
//       var excel = Excel.createExcel();
//       Sheet sheet = excel['SessionTimeReport'];
//       sheet.appendRow([
//         TextCellValue('Date'),
//         TextCellValue('Start Time'),
//         TextCellValue('End Time'),
//         TextCellValue('Total Collection Time'),
//       ]);

//       for (var item in list) {
//         sheet.appendRow([
//           TextCellValue(item.date),
//           TextCellValue(item.startTime),
//           TextCellValue(item.endTime),
//           TextCellValue(item.totalCollTime),
//         ]);
//       }

//       // Save to Downloads
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       String fileName = '$title-$date.xlsx';
//       String filePath = '${downloadsDir.path}/$fileName';

//       File(filePath)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.save()!);

//       await _showDownloadNotification(filePath);
//       generatePdfFromSessionTime(title, list, date, filePath);
//       Utils.showToast("Excel saved to $filePath ✅");
//     } catch (e) {
//       Utils.showToast("Error exporting to Downloads: $e ❌");
//     }
//   }
//   static Future<void> generatePdfFromSessionTime(
//       String title, List<MSessionTime> list, String date, String excelFilePath) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('$title - $date',
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table.fromTextArray(
//                 headers: ['Date', 'Start Time', 'End Time', 'Total Coll Time'],
//                 data: list.map((item) {
//                   return [
//                     item.date,
//                     item.startTime,
//                     item.endTime,
//                     item.totalCollTime,
//                   ];
//                 }).toList(),
//                 cellStyle: pw.TextStyle(fontSize: 10),
//                 headerStyle:
//                 pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     try {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');
//       if (!await downloadsDir.exists()) {
//         Utils.showToast("Downloads folder not found");
//         return;
//       }

//       final pdfPath = '${downloadsDir.path}/$title-$date.pdf';
//       final pdfFile = File(pdfPath);
//       await pdfFile.writeAsBytes(await pdf.save());

//       await _showDownloadNotification(pdfPath);
//       Utils.showToast("PDF saved to $pdfPath ✅");

//       await FileShareService.shareFiles(
//         excelPath: excelFilePath,
//         pdfPath: pdfPath,
//       );
//     } catch (e) {
//       Utils.showToast("Error generating PDF: $e ❌");
//     }
//   }

// }
