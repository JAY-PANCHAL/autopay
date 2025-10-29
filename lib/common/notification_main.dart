// import 'dart:convert';
// import 'dart:io';

// import 'package:aasaan_flutter/common/utils/app_constants.dart';
// import 'package:aasaan_flutter/common/utils/storage_service.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/notification_model.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:excel/excel.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NotificationHelper {
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//   GlobalKey<NavigatorState>? navigatorKey;
//   bool initialized = false;
//   var globalContext;
//   AndroidNotificationChannel? channel;
//   final storageService = StorageService();
//   DBHelper dbHelper = DBHelper();

//   //final repo = getIt.get<AasanRepository>();

//   Future<void> initNotification(key) async {
//     try {
//       if (!initialized) {
//         print('notifiction helper initialized*');

//         navigatorKey = key;
//         flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//         await flutterLocalNotificationsPlugin
//             ?.resolvePlatformSpecificImplementation<
//                 IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions(
//               alert: true,
//               badge: true,
//               sound: true,
//             );
//         await requestStoragePermission();
//         channel = const AndroidNotificationChannel(
//             'high_importance_channel', // id
//             'High Importance Notifications', // title
//             description:
//                 'This channel is used for important notifications.', // description
//             importance: Importance.high,
//             showBadge: true);

//         await flutterLocalNotificationsPlugin
//             ?.resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.createNotificationChannel(channel!);

//         await flutterLocalNotificationsPlugin
//             ?.resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.requestNotificationsPermission();

//         configLocalNotification();
//         NotificationSettings settings =
//             await firebaseMessaging.requestPermission(
//           alert: true,
//           announcement: false,
//           badge: true,
//           carPlay: false,
//           criticalAlert: false,
//           provisional: true,
//           sound: true,
//         );
//         if (Platform.isIOS) {
//           await firebaseMessaging.setForegroundNotificationPresentationOptions(
//             alert: true, // Required to display a heads up notification
//             badge: true,
//             sound: true,
//           );
//         }
//         String? token = await firebaseMessaging.getToken();
//         assert(token != null);

//         await storageService.setString(AppConstants.googleTokenPR, token);
//         print("Firebase token :---------------------------------->" + token!);

//         setupInteractedMessage();

//         FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//           print('Got a message whilst in the foreground!');
//           if (!Platform.isIOS) {
//             if (message.notification != null) {
//               showNotification(message.notification, message.data);
//             } else {
//               showNotification1(message.data, message.data);
//               print(
//                   'Message also contained a notification: ${message.notification}');
//             }
//           }
//         });

//         //When App is in background
//         FirebaseMessaging.onMessageOpenedApp.listen((event) {
//           onSelectNotification(event.data);
//         });

//         initialized = true;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   //When App is Closed/Killed
//   Future<void> setupInteractedMessage() async {
//     await FirebaseMessaging.instance.getInitialMessage().then((value) =>
//         _handleMessage(value != null ? value.data : Map(), isKill: true));
//   }

//   Future<void> requestStoragePermission() async {
//     if (Platform.isAndroid) {
//       await Permission.photos.request();
//       await Permission.storage.request();

//       await Permission.manageExternalStorage.request();
//     } else if (Platform.isIOS) {
//       await Permission.photos.request();
//     }
//   }

// /*
//   Future<void> readExcelAndInsertIntoDB(String filePath) async {
//     try {
//       DBHelper dbHelper=DBHelper();

//       var file = File(filePath);

//       // Check if file exists
//       if (!await file.exists()) {
//         print("❌ File not found: $filePath");
//         return;
//       }

//       // Delete existing data before inserting new data
//       await dbHelper.executeRawQuery("DELETE FROM FATBasedRateChartManualExcel");



//       var bytes = await file.readAsBytes();
//       var excel = Excel.decodeBytes(bytes);

//       for (var table in excel.tables.keys) {
//         var sheet = excel.tables[table]!;
//         List<String> columnNames = [];

//         for (var i = 0; i < sheet.rows.length; i++) {
//           var row = sheet.rows[i];

//           // ✅ Extract column names from the first row
//           if (i == 0) {
//             columnNames = row.map((cell) => cell?.value.toString() ?? "").toList();
//             continue; // Skip to next row
//           }

//           // ✅ Prepare data dynamically for each column
//           Map<String, dynamic> rowData = {};
//           for (var j = 0; j < row.length; j++) {
//             if (j < columnNames.length) {
//               rowData[columnNames[j]] = row[j]?.value.toString() ?? "";
//             }
//           }

// print(rowData);
//           // ✅ Insert row into database
//        //   await dbHelper.executeRawQuery("FATBasedRateChartManualExcel", rowData);
//         }
//       }

//       print("✅ All Data Inserted into Database");
//     } catch (e) {
//       print("❌ Error Reading Excel File: $e");
//     }
//   }
// */
// // ✅ Helper function to normalize column names
//   String normalizeColumnName(String col) {
//     if (col.toLowerCase() == "type") return "CattleType"; // Fix column mismatch
//     if (RegExp(r'^\d+$').hasMatch(col))
//       return "FAT_${col}_0"; // Convert "1" to "FAT_1_0"
//     if (RegExp(r'^\d+\.\d+$').hasMatch(col))
//       return "FAT_${col.replaceAll('.', '_')}"; // Convert "0.5" to "FAT_0_5"
//     return col;
//   }

//   Future<void> readExcelAndInsertIntoDB(String filePath) async {
//     try {
//       DBHelper dbHelper = DBHelper();
//       var file = File(filePath);

//       // ✅ Check if file exists
//       if (!await file.exists()) {
//         print("❌ File not found: $filePath");
//         return;
//       }

//       // ✅ Delete existing data before inserting new data
//       await dbHelper
//           .executeRawQuery("DELETE FROM FATBasedRateChartManualExcel");

//       // ✅ Read Excel file
//       var bytes = await file.readAsBytes();
//       var excel = Excel.decodeBytes(bytes);

//       for (var table in excel.tables.keys) {
//         var sheet = excel.tables[table]!;
//         List<String> columnNames = [];

//         for (var i = 0; i < sheet.rows.length; i++) {
//           var row = sheet.rows[i];

//           // ✅ Extract column names from the first row
//           if (i == 0) {
//             columnNames = row
//                 .map(
//                     (cell) => normalizeColumnName(cell?.value.toString() ?? ""))
//                 .toList();
//             continue; // Skip to next row
//           }

//           // ✅ Prepare data dynamically for each column
//           Map<String, dynamic> rowData = {};
//           for (var j = 0; j < row.length; j++) {
//             if (j < columnNames.length) {
//               String columnName = columnNames[j];
//               var cellValue = row[j]?.value;

//               // ✅ Handle NULLs and empty values properly
//               if (cellValue == null || cellValue.toString().trim().isEmpty) {
//                 rowData[columnName] = "NULL"; // Set NULL for empty values
//               } else if (RegExp(r'^-?\d+(\.\d+)?$')
//                   .hasMatch(cellValue.toString())) {
//                 rowData[columnName] =
//                     cellValue.toString(); // Keep numbers as numbers
//               } else {
//                 rowData[columnName] =
//                     "'${cellValue.toString().replaceAll("'", "''")}'"; // Escape quotes for text values
//               }
//             }
//           }

//           // ✅ Convert Map to SQL Insert Statement
//           String tableName = "FATBasedRateChartManualExcel";
//           List<String> columns = rowData.keys.map((col) => '"$col"').toList();
//           List values = rowData.values.toList(); // Already formatted

//           String query =
//               "INSERT INTO $tableName (${columns.join(',')}) VALUES (${values.join(',')})";

//           // ✅ Insert row into database
//           await dbHelper.executeRawQuery(query);
//         }
//       }
//       Utils.showToast(" All Rate Chart Data Inserted into Database ✅");
//     } catch (e) {
//       //Utils.showToast(" Error Reading Excel File: $e ❌");
//     }
//   }

//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult[0] == ConnectivityResult.none) {
//       Utils.showToast("No internet connection");
//       return false;
//     }
//     return true;
//   }

//   Future<Directory?> getSafeStorageDirectory() async {
//     try {
//       if (Platform.isAndroid) {
//         // Get Android version
//         final deviceInfo = await DeviceInfoPlugin().androidInfo;
//         int sdkInt = deviceInfo.version.sdkInt;

//         // Ask for permissions based on Android version
//         if (sdkInt >= 33) {
//           // Android 13+ (Tiramisu)
//           var photos = await Permission.photos.request();
//           if (!photos.isGranted) {
//             Utils.showToast("Photos permission denied ❌");
//             return null;
//           }
//         } else if (sdkInt >= 30) {
//           // Android 11+ (Scoped Storage enforced)
//           var storage = await Permission.storage.request();
//           if (!storage.isGranted) {
//             Utils.showToast("Storage permission denied ❌");
//             return null;
//           }
//         } else {
//           // Below Android 11
//           var storage = await Permission.storage.request();
//           if (!storage.isGranted) {
//             Utils.showToast("Storage permission denied ❌");
//             return null;
//           }
//         }

//         // Return app-specific external storage directory
//         Directory? dir = await getExternalStorageDirectory();
//         if (dir == null) {
//           return null;
//         }

//         // Optional: create subfolder if needed
//         Directory aasaanDir = Directory("${dir.path}/AASAN");
//         if (!await aasaanDir.exists()) {
//           await aasaanDir.create(recursive: true);
//         }

//         return aasaanDir;
//       } else {
//         // iOS or other platforms
//         return await getApplicationDocumentsDirectory();
//       }
//     } catch (e) {
//       Utils.showToast("Error getting storage directory: $e ❌");
//       return null;
//     }
//   }

// /*
//   Future<String?> downloadExcelFile(String url) async {
//     bool isInternetAvailable = await checkInternetConnection();
//     if (!isInternetAvailable) {
//       return null;
//     }

//     try {
//       // Extract file name from URL
//       String fileName = url.split('/').last;
//       await Permission.storage.request();
//       // Request storage permission
//       if (await Permission.photos.request().isGranted) {
//         Directory directory = Directory("/storage/emulated/0/AASAN");

//         if (!await directory.exists()) {
//           await directory.create(recursive: true);
//         }

//         // Set file path
//         String filePath = "${directory.path}/$fileName";

//         // Download file
//         await Dio().download(url, filePath);

//         Utils.showToast(" File Downloaded at: $filePath ✅");
//         readExcelAndInsertIntoDB(filePath);

//         return filePath;
//       } else {
//         Utils.showToast("Storage Permission Denied ❌");
//         return null;
//       }
//     } catch (e) {
//       Utils.showToast(" Error Downloading File: $e ❌");
//       return null;
//     }
//   }
// */



//   Future<String?> downloadExcelFile(String url) async {
//     bool isInternetAvailable = await checkInternetConnection();
//     if (!isInternetAvailable) return null;

//     try {
//       Directory? directory = await getSafeStorageDirectory();
//       if (directory == null) return null;

//       String fileName = url.split('/').last;
//       String filePath = "${directory.path}/$fileName";

//       await Dio().download(url, filePath);
//       Utils.showToast("File Downloaded at: $filePath ✅");

//       readExcelAndInsertIntoDB(filePath);
//       return filePath;
//     } catch (e) {
//       Utils.showToast("Error Downloading File: $e ❌");
//       return null;
//     }
//   }

//   Future<void> _handleMessage(Map<String, dynamic> data,
//       {isKill = false}) async {
//     print(
//         "data  From  Notification is in handle message ----------------->${data}");

//     if (data.isNotEmpty) {
//       var map = jsonDecode(data["body"]);
//       String? fileUrl = map["File1"];

//       if (fileUrl != null) {
//         String? filePath = await downloadExcelFile(fileUrl);

//         print(filePath);
//       } else {
//         if (map['SettingData'] != null) {
//           var jsonString = jsonEncode(map);
//           print(jsonString);
//           NotificationModel model = NotificationModel.fromJson(map);
//           print(model);
//           setprefsForSettings(model);
//         }
//       }
//     }
//   }

//   void configLocalNotification() async {
//     try {
//       // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//       final DarwinInitializationSettings initializationSettingsDarwin =
//           DarwinInitializationSettings();
//       final LinuxInitializationSettings initializationSettingsLinux =
//           LinuxInitializationSettings(defaultActionName: 'Open notification');

//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin,
//       );

//       flutterLocalNotificationsPlugin?.initialize(initializationSettings,
//           onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     //Utils.showToast(payload);
// if(payload!="") {
//   var json = jsonDecode(notificationResponse.payload ?? "");

//   var map = jsonDecode(json["body"]);
//   String? fileUrl = map["File1"];

//   if (fileUrl != null) {
//     String? filePath = await downloadExcelFile(fileUrl);

//     print(filePath);
//   } else {
//     if (map['SettingData'] != null) {
//       var jsonString = jsonEncode(map);
//       print(jsonString);
//       NotificationModel model = NotificationModel.fromJson(map);
//       print(model);
//       setprefsForSettings(model);
//     }
//   }
// }
//   }

//   ondidRec(id, title, body, payload) {}

//   Future<dynamic> onSelectNotification(json) async {
//     if (json != null) {
//       print("on select notification ${json}");

//       //var json = jsonDecode(message);
//       print(json["body"]);

//       var map = jsonDecode(json["body"]);
//       String? fileUrl = map["File1"];

//       if (fileUrl != null) {
//         String? filePath = await downloadExcelFile(fileUrl);
//         print(filePath);
//       } else {
//         if (map['SettingData'] != null) {
//           var jsonString = jsonEncode(map);
//           print(jsonString);
//           NotificationModel model = NotificationModel.fromJson(map);
//           print(model);
//           setprefsForSettings(model);
//         }
//       }
//     }
//   }

//   setprefsForSettings(NotificationModel model) async {
//     String settingConfig = "";

//     if (model.settingData?.configCode != null) {
//       settingConfig = "${model.settingData?.configCode}";
//     }

//     if (model.settingData?.generalSettings?.code != null) {
//       if (model.settingData?.generalSettings?.weighingScaleStringSliceFrom !=
//           null) {
//         await storageService.setInt(AppConstants.wgtSlcFromPR,
//             model.settingData?.generalSettings?.weighingScaleStringSliceFrom);
//       }

//       if (model.settingData?.generalSettings?.weighingScaleStringSliceTill !=
//           null) {
//         await storageService.setInt(AppConstants.wgtSlcTillPR,
//             model.settingData?.generalSettings?.weighingScaleStringSliceTill);
//       }
//       if (model.settingData?.generalSettings?.milkAnalyzerStringSliceFrom !=
//           null) {
//         await storageService.setInt(AppConstants.milkAnlSlcFromPR,
//             model.settingData?.generalSettings?.milkAnalyzerStringSliceFrom);
//       }
//       if (model.settingData?.generalSettings?.milkAnalyzerStringSliceTill !=
//           null) {
//         await storageService.setInt(AppConstants.milkAnlSlcTillPR,
//             model.settingData?.generalSettings?.milkAnalyzerStringSliceTill);
//       }

//       if (model.settingData?.generalSettings?.code != null) {
//         await storageService.setInt(AppConstants.generalSettingsVerCodePR,
//             model.settingData?.generalSettings?.code);
//       }

//       if (model.settingData?.generalSettings?.reportPaymentCycle != null) {
//         await storageService.setInt(AppConstants.reportPaymentCyclePR,
//             model.settingData?.generalSettings?.reportPaymentCycle);
//       }

//       if (model.settingData?.generalSettings?.milkCollectionType != null) {
//         await storageService.setInt(AppConstants.milkCollectionTypePR,
//             model.settingData?.generalSettings?.milkCollectionType);
//       }

//       if (model.settingData?.generalSettings?.milkCollectionTypeDisplay !=
//           null) {
//         await storageService.setString(AppConstants.milkCollectionTypeDisplayPR,
//             model.settingData?.generalSettings?.milkCollectionTypeDisplay);
//       }

//       if (model.settingData?.generalSettings?.rcptDisplayTime?.toLowerCase() ==
//           "false") {
//         await storageService.setString(AppConstants.tearValuesPR, "N");
//       } else {
//         await storageService.setString(AppConstants.tearValuesPR, "Y");
//       }

//       if (model.settingData?.generalSettings?.rcptDisplayTime != null) {
//         await storageService.setString(AppConstants.timerCountPR,
//             model.settingData?.generalSettings?.rcptDisplayTime);
//       }
//     }

//     if (model.settingData?.sessionSettings != null) {
//       if (model.settingData?.sessionSettings?.code != null) {
//         String MSessStartTime =
//             model.settingData?.sessionSettings?.mSessStartTime ?? "";
//         String MSessEndTime =
//             model.settingData?.sessionSettings?.mSessEndTime ?? "";
//         String ESessStartTime =
//             model.settingData?.sessionSettings?.eSessStartTime ?? "";
//         String ESessEndTime =
//             model.settingData?.sessionSettings?.eSessEndTime ?? "";
//         String SessGraceTime =
//             model.settingData?.sessionSettings?.sessGraceTime ?? "";

//         if (model.settingData?.sessionSettings?.sessGraceTime != null) {
//           storageService.setString(AppConstants.sessionSettingsVerCodePR,
//               model.settingData?.sessionSettings?.sessGraceTime ?? "0");
//         }
//         await dbHelper.executeRawQuery("DELETE FROM Settings_Session");

//         String query =
//             "INSERT INTO Settings_Session (MSessStartTime, MSessEndTime, ESessStartTime, ESessEndTime, "
//             "IsSync, SessGraceTime) VALUES ('$MSessStartTime', '$MSessEndTime', '$ESessStartTime', '$ESessEndTime', '1', '$SessGraceTime')";
//         await dbHelper.executeRawQuery(query);
//       }
//     }

//     //line number 382  rate related settings
//     if (model.settingData?.rateSettings != null) {
//       if (model.settingData?.rateSettings?.rateDecimalPoints != null) {
//         String intRateDecimalPoints =
//             "${model.settingData?.rateSettings?.rateDecimalPoints ?? 0.0}";
//         String intPaymentType =
//             "${model.settingData?.rateSettings?.paymentType ?? 0}";
//         String intPaymentOn =
//             "${model.settingData?.rateSettings?.paymentOn ?? 0}";
//         String PrintSNFFATRate =
//             "${model.settingData?.rateSettings?.printSNFFATRate ?? false}";

//         if (PrintSNFFATRate.toLowerCase() == "true") {
//           PrintSNFFATRate = "1";
//         } else {
//           PrintSNFFATRate = "0";
//         }
//         String PrintKGFATRate =
//             "${model.settingData?.rateSettings?.printKGFATRate ?? 0.0}";
//         if (PrintKGFATRate.toLowerCase() == "true") {
//           PrintKGFATRate = "1";
//         } else {
//           PrintKGFATRate = "0";
//         }

//         String strFATDensityValues =
//             "${model.settingData?.rateSettings?.fATDensity ?? 0.0}";
//         String strIncentiveValues =
//             "${model.settingData?.rateSettings?.incentive ?? 0.0}";
//         String strIncentiveMinFATValues =
//             "${model.settingData?.rateSettings?.incentiveMinFAT ?? 0.0}";
//         String strbuffCommissionRateValues =
//             "${model.settingData?.rateSettings?.buffCommissionRate ?? 0.0}";
//         String strCowCommissionRateValues =
//             "${model.settingData?.rateSettings?.cowCommissionRate ?? 0.0}";
//         String strCowGrade1Factor =
//             "${model.settingData?.rateSettings?.cowGrade1Factor ?? 0.0}";
//         String strCowGrade2Factor =
//             "${model.settingData?.rateSettings?.cowGrade2Factor ?? 0.0}";
//         String strCowGrade3Factor =
//             "${model.settingData?.rateSettings?.cowGrade3Factor ?? 0.0}";

//         storageService.setInt(AppConstants.rateSettingsVerCodePR,
//             model.settingData?.rateSettings?.code ?? 0);

//         String queryRate = "";
//         if (await dbHelper.getScalarQueryStringFromDB(
//                 "SELECT COUNT(*) FROM Settings_Rate") ==
//             "0") {
//           queryRate =
//               "INSERT INTO Settings_Rate (RateDecimalPoints, PaymentType, PaymentOn, BuffCommissionRate, CowCommissionRate, "
//               "CowGrade1Factor, CowGrade2Factor, CowGrade3Factor, PrintSNF_FATRate, PrintKG_FATRate, FATDensity, Incentive, IncentiveMinFAT, IsSync) "
//               "VALUES ('$intRateDecimalPoints', '$intPaymentType', '$intPaymentOn', '$strbuffCommissionRateValues', '$strCowCommissionRateValues', "
//               "'$strCowGrade1Factor', '$strCowGrade2Factor', '$strCowGrade3Factor', '$PrintSNFFATRate', '$PrintKGFATRate', '$strFATDensityValues', "
//               "'$strIncentiveValues', '$strIncentiveMinFATValues', '1')";
//           await dbHelper.executeRawQuery(queryRate);
//         } else {
//           queryRate = "UPDATE Settings_Rate SET "
//               "IsSync = '1', "
//               "RateDecimalPoints = '$intRateDecimalPoints', "
//               "PaymentType = '$intPaymentType', "
//               "PaymentOn = '$intPaymentOn', "
//               "BuffCommissionRate = '$strbuffCommissionRateValues', "
//               "CowCommissionRate = '$strCowCommissionRateValues', "
//               "CowGrade1Factor = '$strCowGrade1Factor', "
//               "CowGrade2Factor = '$strCowGrade2Factor', "
//               "CowGrade3Factor = '$strCowGrade3Factor', "
//               "PrintSNF_FATRate = '$PrintSNFFATRate', "
//               "PrintKG_FATRate = '$PrintKGFATRate', "
//               "FATDensity = '$strFATDensityValues', "
//               "Incentive = '$strIncentiveValues', "
//               "IncentiveMinFAT = '$strIncentiveMinFATValues' "
//               "WHERE Code = '1'";

//           await dbHelper.executeRawQuery(queryRate);
//         }
//       }
//     }

// //line 466 data setting
//     if (model.settingData?.dataSettings != null) {
//       if (model.settingData?.dataSettings?.allowZeroFat != null) {
//         String intAllowZeroFat =
//             "${model.settingData?.dataSettings?.allowZeroFat}";

//         if (intAllowZeroFat == "true") {
//           intAllowZeroFat = "1";
//         } else {
//           intAllowZeroFat = "0";
//         }
//         String intAllowZeroSNF =
//             "${model.settingData?.dataSettings?.allowZeroSNF}";
//         if (intAllowZeroSNF == "true") {
//           intAllowZeroSNF = "1";
//         } else {
//           intAllowZeroSNF = "0";
//         }

//         String strFatDecimalPoint =
//             "${model.settingData?.dataSettings?.fATDecPoints}";
//         String strSNFDecimalPoint =
//             "${model.settingData?.dataSettings?.sNFDecPoints}";
//         String RejectCowMinFat =
//             "${model.settingData?.dataSettings?.rejectionCowMinimumFat}";
//         String RejectCowMaxFat =
//             "${model.settingData?.dataSettings?.allowedCowMaximumFat}";
//         String RejectCowMinSNF =
//             "${model.settingData?.dataSettings?.rejectionCowMinimumSNF}";
//         String RejectCowMaxSNF =
//             "${model.settingData?.dataSettings?.allowedCowMaximumSNF}";
//         String RejectBuffMinFat =
//             "${model.settingData?.dataSettings?.rejectionBuffaloMinimumFat}";
//         String RejectBuffMaxFat =
//             "${model.settingData?.dataSettings?.allowedBuffaloMaximumFat}";
//         String RejectBuffMinSNF =
//             "${model.settingData?.dataSettings?.rejectionBuffaloMinimumSNF}";
//         String RejectBuffMaxSNF =
//             "${model.settingData?.dataSettings?.allowedBuffaloMaximumSNF}";

//         String intSMSAlert = "${model.settingData?.dataSettings?.sendAlerSMS}";

//         if (intSMSAlert == "true") {
//           intSMSAlert = "1";
//         } else {
//           intSMSAlert = "0";
//         }

//         String intMailAlert =
//             "${model.settingData?.dataSettings?.sendAlertMail}";

//         if (intMailAlert == "true") {
//           intMailAlert = "1";
//         } else {
//           intMailAlert = "0";
//         }

//         String intAllowLiterManual =
//             "${model.settingData?.dataSettings?.litreEntryManual}";

//         if (intAllowLiterManual == "true") {
//           intAllowLiterManual = "1";
//         } else {
//           intAllowLiterManual = "0";
//         }

//         String intAllowFatSNFManual =
//             "${model.settingData?.dataSettings?.milkAnalyzerManual}";

//         if (intAllowFatSNFManual == "true") {
//           intAllowFatSNFManual = "1";
//         } else {
//           intAllowFatSNFManual = "0";
//         }

//         storageService.setInt(AppConstants.dataSettingsVerCodePR,
//             model.settingData?.dataSettings?.code ?? 0);

//         String query = "";

//         if (dbHelper.getScalarQueryStringFromDB(
//                 "Select Count(*) From Settings_Data") ==
//             0) {
//           query = """
//     INSERT INTO Settings_Data (
//         AllowZeroFAT, AllowZeroSNF, FATDecPoints, SNFDecPoints, 
//         RejectionCowMinFAT, RejectionCowMaxFAT, RejectionCowMinSNF, RejectionCowMaxSNF, 
//         RejectionBuffMinFAT, RejectionBuffMaxFAT, RejectionBuffMinSNF, RejectionBuffMaxSNF, 
//         SendAlertSMS, SendAlertMail, AllowLiterManual, AllowSNFFATManual, IsSync
//     ) VALUES (
//         '$intAllowZeroFat', '$intAllowZeroSNF', '$strFatDecimalPoint', '$strSNFDecimalPoint', 
//         '$RejectCowMinFat', '$RejectCowMaxFat', '$RejectCowMinSNF', '$RejectCowMaxSNF', 
//         '$RejectBuffMinFat', '$RejectBuffMaxFat', '$RejectBuffMinSNF', '$RejectBuffMaxSNF', 
//         '$intSMSAlert', '$intMailAlert', '$intAllowLiterManual', '$intAllowFatSNFManual', '1'
//     )
// """;
//           dbHelper.executeRawQuery(query);
//         } else {
//           query = """
//     UPDATE Settings_Data 
//     SET 
//         IsSync = '1',
//         AllowZeroFAT = '$intAllowZeroFat', 
//         AllowZeroSNF = '$intAllowZeroSNF', 
//         FATDecPoints = '$strFatDecimalPoint', 
//         SNFDecPoints = '$strSNFDecimalPoint', 
//         RejectionCowMinFAT = '$RejectCowMinFat', 
//         RejectionCowMaxFAT = '$RejectCowMaxFat', 
//         RejectionCowMinSNF = '$RejectCowMinSNF', 
//         RejectionCowMaxSNF = '$RejectCowMaxSNF', 
//         RejectionBuffMinFAT = '$RejectBuffMinFat', 
//         RejectionBuffMaxFAT = '$RejectBuffMaxFat', 
//         RejectionBuffMinSNF = '$RejectBuffMinSNF', 
//         RejectionBuffMaxSNF = '$RejectBuffMaxSNF', 
//         SendAlertSMS = '$intSMSAlert', 
//         SendAlertMail = '$intMailAlert', 
//         AllowLiterManual = '$intAllowLiterManual', 
//         AllowSNFFATManual = '$intAllowFatSNFManual' 
//     WHERE Code = '1'
// """;
//           dbHelper.executeRawQuery(query);
//         }
//       }
//     }

//     var token = await storageService.getString(AppConstants.tokenPr);

//     /* await repo.getConfirmNotificaion(token,Endpoints.confirmNotification+settingConfig+"&Type=1").then((value) async {

//     */ /*  if ((value.data?.length ?? 0) > 0) {
//         var item=value.data?[0];
//       }
// */ /*
//     }).onError((error, stackTrace) {

//       Utils.showToast(error.toString());
//     });*/
//   }

//   void showNotification(RemoteNotification? message, data) async {
//     try {
//       print(message);

//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         Platform.isAndroid
//             ? 'high_importance_channel'
//             : 'high_importance_channel',
//         'High Importance Notifications',
//         playSound: true,
//         enableVibration: true,
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
//       var platformChannelSpecifics = NotificationDetails(
//           android: androidPlatformChannelSpecifics,
//           iOS: iOSPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin
//           ?.show(0, message?.title, message?.body, platformChannelSpecifics,
//               payload: jsonEncode(data))
//           .catchError((error, stackTrace) => {print(error)})
//           .onError((error, stackTrace) => {print(error)});
//     } catch (e) {
//       print(e);
//     }
//   }

//   void showNotification1(message, data) async {
//     print(message);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       Platform.isAndroid
//           ? 'high_importance_channel'
//           : 'high_importance_channel',
//       'High Importance Notifications',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin?.show(0, message["title"].toString(),
//         message["message"].toString(), platformChannelSpecifics,
//         payload: jsonEncode(data));
//   }
// }
