// import 'dart:async';
// import 'dart:ffi';

// import 'package:aasaan_flutter/common/utils/app_constants.dart';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/utility.dart';
// import 'package:aasaan_flutter/controller/milk_collection_entry_controller.dart';
// import 'package:aasaan_flutter/db/db_helper.dart';
// import 'package:aasaan_flutter/network/model/data_related_setting_model.dart';
// import 'package:aasaan_flutter/network/model/member_data_model.dart';
// import 'package:aasaan_flutter/network/model/member_profile.dart';
// import 'package:aasaan_flutter/network/model/milkCollectionModel.dart';
// import 'package:aasaan_flutter/network/model/rate_related_setting_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as serial;
// import 'package:blue_thermal_printer/blue_thermal_printer.dart' as thermal;
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../bluetooth/bluetooth_service.dart';
// import '../../../bluetooth/printer_class.dart';
// import '../../../bluetooth/printer_dialog.dart';
// import '../../../bluetooth/printer_service.dart';
// import '../../../common/utils/storage_service.dart';
// import '../../../main.dart';
// import '../../../network/model/fat_based_rate_chart.dart';
// import '../../../routes/app_pages.dart';

// class MilkCollectionEntryScreen extends StatefulWidget {
//   @override
//   State<MilkCollectionEntryScreen> createState() =>
//       _MilkCollectionEntryScreenState();
// }

// class _MilkCollectionEntryScreenState extends State<MilkCollectionEntryScreen> {
//   final formKey = GlobalKey<FormBuilderState>();

//   final MilkCollectionController controller =
//       Get.put(MilkCollectionController());

//   var istablet = Utils.checkTablet();

//   String date = "";
//   String session = "";
//   String capturedTime = "";

//   String strTime = "";
//   String strDate = "";
//   String strDateFor = "";
//   String strSession = "";
//   String strKgRate = "0.0";

//   String strCattleType = "B";
//   String? memCode;
//   String? memberName;
//   String? memberFName;
//   String strMemberCodeValue = "";

//   int intLitersEntryType = 2;
//   int intFAT_SNF_EntryType = 2;
//   int intAmount_Type = 1;

//   String strRate = "0";
//   String strLiter = "0";
//   String strSnf = "0.0";
//   String strFat = "0.0";
//   String strClr = "0";
//   String strAmount = "0";

//   var settings_datas = <MSettingsData>[];
//   var mSettingData = MSettingsData();
//   var isDataPaused=false.obs;
//   int code = 0,
//       intAllowZeroFat = 0,
//       intAllowZeroSNF = 0,
//       intSMSAlert = 0,
//       intMailAlert = 0,
//       intAllowLiterManual = 0,
//       intAllowFatSNFManual = 0;

//   String strFatDecimalPoint = "",
//       strSNFDecimalPoint = "",
//       strRateDecimalPoint = "",
//       rejectCowMinFat = "",
//       rejectCowMaxFat = "",
//       rejectCowMinSNF = "",
//       rejectCowMaxSNF = "",
//       rejectBuffMinFat = "",
//       rejectBuffMaxFat = "",
//       rejectBuffMinSNF = "",
//       rejectBuffMaxSNF = "";

//   final NumberFormat format_0_0 = NumberFormat("0.0");
//   final NumberFormat format_0_00 = NumberFormat("0.00");
//   final NumberFormat format_0_000 = NumberFormat("0.000");

//   var dfRate = NumberFormat("0.0").obs;
//   var dfFat = NumberFormat("0.0").obs;
//   var dfAmount = NumberFormat("0.0").obs;
//   var dfFatSnf = NumberFormat("0.0").obs;

//   var dfSnf = NumberFormat("0.0").obs;

//   int Entry = 0;
//   String autoID = "0";

//   MSettingsRate? mSettingsRate = MSettingsRate();

//   String cattleFullName = "Buf";
//   String totalMember = "0";

//   int displayLiterDecimal = 0;
//   int displayAmountDecimal = 0;
//   int displayAddedWaterDecimal = 1;
//   int isUpdate = 0;
//   int updateCode = 0;

//   String updatedAutoID = "";
//   String oldWeight = "";
//   String oldFat = "";
//   String oldSnf = "";
//   String oldAmount = "";
//   String updatedCodeID = "";

//   int wgtSlcFrom = 0;
//   int wgtSlcTill = 0;
//   int milkAnlSlcFrom = 0;
//   int milkAnlSlcTill = 0;

//   String strDisplayLiter = "";

//   int msgCounter = 0;

//   String channelName = "";
//   String channelNameOne = "";

//   int milkColEntryType = 1;
//   final FocusNode memberFocus = FocusNode();

//   final FocusNode literFocus = FocusNode();
//   final FocusNode fatFieldFocus = FocusNode();
//   final FocusNode snfFieldFocus = FocusNode();

//   final FocusNode keyboardListenerFocus =
//       FocusNode(); // Needed for RawKeyboardListener
//   final BluetoothService _bluetoothService = BluetoothService();
//   StreamSubscription<String>? _dataSubscription;
//   var latestData = ''.obs;
//   BluetoothPrinterService _printerService = BluetoothPrinterService();

//   @override
//   void initState() {
//     super.initState();
//     // Retrieve passed arguments
//     final arguments = Get.arguments;

//     date = arguments["date"] ?? "";
//     session = arguments["session"] ?? "";
//     capturedTime = arguments["capturedTime"] ?? "";
//     strTime = capturedTime;

//     if (session == "Morning") {
//       strSession = "M";
//       controller.session.value = "Morning";
//       controller.sessionIcon.value = "Morning";
//     } else if (session == "Evening") {
//       controller.session.value = "Evening";
//       controller.sessionIcon.value = "Evening";
//       strSession = "E";
//     }
//     //getting data from db
//     controller.memberName.value = "";

//     ///cpnverting dates in format

//     // Parse the date string into a DateTime object
//     DateTime datesFormat = DateFormat("dd/MM/yyyy").parse(date);

//     // Format the date into different formats
//     strDateFor = DateFormat("dd/MM/yyyy").format(datesFormat);
//     strDate = DateFormat("yyyy-MM-dd").format(datesFormat);

//     print("strDateFor: $strDateFor"); // Output: 15/02/2025
//     print("strDate: $strDate");
//     _bluetoothService.initializeBluetooth(); // Just initialize here
//     _bluetoothService.tryReconnectToLastDevice();
//     _listenToBluetoothData();
//     _initializePrinterConnection();

//     getData();
//     getPrefAndDBData();
//   }


//   Future<void> _initializePrinterConnection() async {
//     bool isOn = await _printerService.isBluetoothOn();
//     if (!isOn) {
//       Utils.showToast("Please turn on Bluetooth to auto-connect to printer 🔄");
//       return;
//     }

//     List<thermal.BluetoothDevice> devices = await _printerService.getBondedDevices();
//     if (devices.isEmpty) return;

//     String? lastDeviceAddress = await _printerService.getLastConnectedDeviceAddress();

//     if (lastDeviceAddress != null) {
//       final lastDevice = devices.firstWhere(
//             (d) => d.address == lastDeviceAddress,
//         orElse: () => thermal.BluetoothDevice( '',  ''),
//       );

//       if ((lastDevice.address??"").isNotEmpty) {
//         try {
//           await _printerService.connectToPrinter(lastDevice);
//          // await _printerService.printSampleData("sample Print", "body");
//           Utils.showToast("Connected to printer: ${lastDevice.name}");
//         } catch (e) {
//           Utils.showToast("Failed to auto-connect to printer ❌");
//         }
//       }
//     }
//   }
//   @override
//   void dispose() {
//     controller.dispose();
//     controller.memberName.value = "";
//     controller.memberNameController.text = "";
//     _dataSubscription?.cancel();
//     _bluetoothService.dispose();
//     super.dispose();
//   }

//   void _listenToBluetoothData() {
//     _dataSubscription = _bluetoothService.onDataReceived.listen((data) {
//       print("📥 New Data: $data");
//     //  Utils.showToast("$data");
//       if (mounted) {
//         setState(() {
//           latestData.value = data;
//         });
//       }

//       if (controller.memberCodeController.text != "") {
//         extractDataFromMessage(data);
//       }
//       // You can also call other methods here
//     });
//   }

//   /* void extractDataFromMessage(String message) {
//     try {
//       // Ensure the message is in expected format
//       if (!message.startsWith('W') || !message.endsWith('B')) {
//         print('Invalid message format');
//         return;
//       }

//       // Remove 'W' at start and 'B' at end
//       final cleaned = message.substring(1, message.length - 1);

//       // Liter: until first 'A'
//       final literEndIndex = cleaned.indexOf('A');
//       final liter = cleaned.substring(0, literEndIndex);

//       // Fat: 4 characters after 'A'
//       final fat = cleaned.substring(literEndIndex + 1, literEndIndex + 5);

//       // SNF: next 4 characters after fat
//       final snf = cleaned.substring(literEndIndex + 5, literEndIndex + 9);

//       print("📌 Liter: $liter");
//       print("📌 Fat: $fat");
//       print("📌 SNF: $snf");
//     } catch (e) {
//       print("❌ Error while extracting data: $e");
//     }
//   }*/
// /*
//   void extractDataFromMessage(String message) {
//     try {
//       // Ensure the message starts with 'W' and ends with 'B'
//       if (!message.startsWith('W') || !message.endsWith('B')) {
//         print('❌ Invalid message format');
//         return;
//       }

//       // Strip 'W' at the start and 'B' at the end
//       final cleaned = message.substring(1, message.length - 1);

//       // Liter: from after W until 'A'
//       final literEndIndex = cleaned.indexOf('A');
//       final liter = cleaned.substring(0, literEndIndex);

//       // Fat: 4 characters after A, format as xx.xx
//       final fatRaw = cleaned.substring(literEndIndex + 1, literEndIndex + 5);
//       final fat = "${fatRaw.substring(0, 2)}.${fatRaw.substring(2, 4)}";

//       // SNF: next 4 characters, format as xx.xx
//       final snfRaw = cleaned.substring(literEndIndex + 5, literEndIndex + 9);
//       final snf = "${snfRaw.substring(0, 2)}.${snfRaw.substring(2, 4)}";

//       print("📌 Liter: $liter");
//       print("📌 Fat: $fat");
//       print("📌 SNF: $snf");
//       formKey.currentState?.fields['liters']?.didChange(liter);
//       formKey.currentState?.fields['fat']?.didChange(fat);
//       formKey.currentState?.fields['snf']?.didChange(snf);


//     } catch (e) {
//       print("❌ Error while extracting data: $e");
//     }
//   }
// */

//   void extractDataFromMessage(String message) {
//     try {
//       if (!message.startsWith('W')/* || !message.endsWith('B')|| !message.endsWith('M') ||!message.endsWith('C')*/) {
//         print('❌ Invalid message format');
//         return;
//       }

//       final cleaned = message.substring(1, message.length - 1);

//       if (!cleaned.contains('A')) {
//         print("❌ Missing separator 'A' in message");
//         return;
//       }

//       final literEndIndex = cleaned.indexOf('A');
//      /* if (cleaned.length < literEndIndex + 9) {
//         print("❌ Message too short for Fat/SNF extraction");
//         return;
//       }*/

//       final liter = cleaned.substring(0, literEndIndex);
//       final fatRaw = cleaned.substring(literEndIndex + 1, literEndIndex + 5);
//       final fat = "${fatRaw.substring(0, 2)}.${fatRaw.substring(2)}";

//       final snfRaw = cleaned.substring(literEndIndex + 5, literEndIndex + 9);
//       final snf = "${snfRaw.substring(0, 2)}.${snfRaw.substring(2)}";

//       print("📌 Liter: $liter");
//       print("📌 Fat: $fat");
//       print("📌 SNF: $snf");
//       if(liter.contains("......")){

//         FocusScope.of(context).requestFocus(literFocus);

//       }else{
//         formKey.currentState?.fields['liters']?.didChange(liter);
//       }

//       if(fat.contains("....")){

//       FocusScope.of(context).requestFocus(fatFieldFocus);

//       }else{
//         formKey.currentState?.fields['fat']?.didChange(fat);
//       }

//       if(snf.contains("....")){
//         FocusScope.of(context).requestFocus(snfFieldFocus);
//       }else{
//         formKey.currentState?.fields['snf']?.didChange(snf);
//       }
//     } catch (e) {
//       print("❌ Error while extracting data: $e");
//     }
//   }

//   getData() async {
//     var locationCodeInt =
//         await StorageService().getInt(AppConstants.locationCodePr);
//     controller.locationcode.value = locationCodeInt.toString();
//     controller.locationName.value =
//         await StorageService().getString(AppConstants.locationNamePr);
//     controller.unionName.value =
//         await StorageService().getString(AppConstants.unionCodePr);

//     print(controller.locationcode.value);
//     print(controller.locationName.value);
//   }

//   getPrefAndDBData() async {
//     controller.listMembers.value.clear();
//     controller.listMembers.value = await controller.dbHelper
//         .getMembersProfile("Select * FROM MembersProfile");

//     //controller.totalMembers.value=controller.listMembers.value.length;

//     String memValue =
//         "${await controller.dbHelper.getCount("SELECT DISTINCT MemCode FROM MilkCollection WHERE CollDate = '$strDate' "
//             "AND CollSession = '$strSession' AND Locked <> '1'")}"
//         "/${controller.listMembers.value.length}";

//     controller.totalMembers.value = memValue;

//     controller.totalLiters.value = await controller.dbHelper
//         .getScalarQueryStringFromDB(
//             "SELECT SUM(Liters) FROM MilkCollection WHERE CollDate='$strDate' AND CollSession='$strSession' AND Locked <> '1'");

//     wgtSlcFrom =
//         await controller.storageService.getInt(AppConstants.wgtSlcFromPR);
//     wgtSlcTill =
//         await controller.storageService.getInt(AppConstants.wgtSlcTillPR);

//     milkAnlSlcFrom =
//         await controller.storageService.getInt(AppConstants.milkAnlSlcFromPR);
//     milkAnlSlcTill =
//         await controller.storageService.getInt(AppConstants.milkAnlSlcTillPR);

//     /// need to enable fo future purpose
//     settings_datas = await controller.dbHelper
//         .getSettingsData("SELECT * FROM Settings_Data");

//     mSettingsRate = await controller.dbHelper
//         .getSettingsRate("SELECT * FROM Settings_Rate");

//     milkColEntryType = await controller.storageService
//         .getInt(AppConstants.milkCollectionTypePR);
//     //671

//     if (mSettingsRate?.rateDecimalPoints == null) {
//       Utils.showToast("Set values in Rate/Amount Setting");
//       return;
//     }
//     if (settings_datas.length == 0) {
//       Utils.showToast("Set values in Data Setting");
//       return;
//     } else {
//       mSettingData = settings_datas[0];
//       print(mSettingData.allowedCowMaximumSNF);

//       intAllowLiterManual =
//           (mSettingData.litreEntryManual ?? false) == true ? 1 : 0;
//       intAllowFatSNFManual =
//           (mSettingData.milkAnalyzerManual ?? false) == true ? 1 : 0;

//       intAllowZeroFat = mSettingData.allowZeroFat ?? 0;
//       intAllowZeroSNF = mSettingData.allowZeroSNF ?? 0;

//       if (intAllowLiterManual == 1) {
//         intLitersEntryType = 2;
//       } else {
//         intLitersEntryType = 1;
//       }

//       if (intAllowFatSNFManual == 1) {
//         intFAT_SNF_EntryType = 2;
//       } else {
//         intFAT_SNF_EntryType = 1;
//       }

//       strFatDecimalPoint = "${mSettingData.fATDecPoints ?? 0}";
//       strSNFDecimalPoint = "${mSettingData.sNFDecPoints ?? 0}";
//       strRateDecimalPoint = "${mSettingsRate?.rateDecimalPoints ?? 0}";

//       if (mSettingsRate?.paymentOn == 0) {
//         intAmount_Type = 0;
//       } else if (mSettingsRate?.paymentOn == 1) {
//         intAmount_Type = 1;
//       }

//       if (mSettingsRate?.paymentType == 0) {
//         controller.clrVisible.value = false;
//       } else if (mSettingsRate?.paymentType == 1) {
//         controller.clrVisible.value = false;
//       } else if (mSettingsRate?.paymentType == 2) {
//         controller.clrVisible.value = true;
//       }

//       dfAmount = NumberFormat("0.00").obs;
//       dfFatSnf = NumberFormat("0.0").obs;

//       if (strRateDecimalPoint == "1") {
//         dfRate.value = NumberFormat("0.0");
//       } else if (strRateDecimalPoint == "2") {
//         dfRate.value = NumberFormat("0.00");
//       } else if (strRateDecimalPoint == "3") {
//         dfRate.value = NumberFormat("0.000");
//       } else {
//         dfRate.value = NumberFormat("0.00");
//       }

//       if (strFatDecimalPoint == "1") {
//         dfFat.value = NumberFormat("0.0");
//       } else if (strFatDecimalPoint == "2") {
//         dfFat.value = NumberFormat("0.00");
//       } else if (strFatDecimalPoint == "3") {
//         dfFat.value = NumberFormat("0.000");
//       } else {
//         dfFat.value = NumberFormat("0.00");
//       }

//       if (strSNFDecimalPoint == "1") {
//         dfSnf.value = NumberFormat("0.0");
//       } else if (strSNFDecimalPoint == "2") {
//         dfSnf.value = NumberFormat("0.00");
//       } else if (strSNFDecimalPoint == "3") {
//         dfSnf.value = NumberFormat("0.000");
//       } else {
//         dfSnf.value = NumberFormat("0.00");
//       }

//       rejectCowMinFat = "${mSettingData.rejectionCowMinimumFat ?? 0.0}";
//       rejectCowMaxFat = "${mSettingData.rejectionCowMaximumFat ?? 0.0}";
//       rejectCowMinSNF = "${mSettingData.rejectionCowMinimumSNF ?? 0.0}";
//       rejectCowMaxSNF = "${mSettingData.rejectionCowMaximumSNF ?? 0.0}";

//       rejectBuffMinFat = "${mSettingData.rejectionBuffaloMinimumFat ?? 0.0}";
//       rejectBuffMaxFat = "${mSettingData.rejectionBuffaloMaximumFat ?? 0.0}";
//       rejectBuffMinSNF = "${mSettingData.rejectionBuffaloMinimumSNF ?? 0.0}";
//       rejectBuffMaxSNF = "${mSettingData.rejectionBuffaloMaximumSNF ?? 0.0}";
//     }
//   }

//   var isBLEconnected = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return WillPopScope(
//         onWillPop: () async {
//           updateOdairyRegister();
//           print("Back button pressed");
//           return true;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appColor,
//             title: Utils.normalText("Milk Collection Entry",
//                 size: istablet ? 4.sp : 15.sp, color: Colors.white),
//             centerTitle: true,
//             actions: [
//               GestureDetector(
//                   onTap: () async {
//                     bool isConnected = await showBluetoothPrinterDialog(
//                       context,
//                       BluetoothPrinterService(),
//                     );

//                     if (isConnected) {
//                       // You can now trigger your print logic here if needed
//                       print("Printer is ready ✅");
//                     } else {
//                       print("No printer connected ❌");
//                     }
//                   },
//                   child: Icon(Icons.print)),
//               GestureDetector(
//                   onTap: () async {
//                     bool isEnabled =
//                         await serial.FlutterBluetoothSerial.instance.isEnabled ??
//                             false;

//                     if (!isEnabled) {
//                       Utils.showToast("Please turn on Bluetooth first ❌");
//                       return;
//                     }

//                     bool connected = await showBluetoothDeviceDialog(
//                         context, _bluetoothService);
//                     isBLEconnected.value = connected;
//                     print("showBluetoothDeviceDialog----------------->");
//                     print(connected);
//                     if (connected) {
//                       _listenToBluetoothData(); // Start listening now
//                     }
//                   },
//                   child: Icon(
//                     isBLEconnected.value
//                         ? Icons.bluetooth_audio
//                         : Icons.bluetooth,
//                     color: AppColors.white,
//                   )),
//               Utils.addHGap(20),
//               GestureDetector(
//                   onTap: () {
//                     var arguments = {
//                       "date": strDate,
//                       "session": strSession,
//                     };
//                     Get.toNamed(Routes.milkCollectionListScreen,
//                             arguments: arguments)
//                         ?.then((value) async {
//                       print(
//                           "coming back from milk collection list screen ---------------->");

//                       ///go to 3181 line in java for submit
//                       ///go to 4732 in java for get the value from edit click

//                       if (value == null) {
//                         return;
//                       }

//                       if (value != null) {
//                         MilkCollection updatedMilkCollection = value;
//                         isUpdate = 1;
//                         updatedAutoID = "${updatedMilkCollection.autoID ?? 0}";
//                         updatedCodeID = "${updatedMilkCollection.code ?? 0}";
//                         formKey.currentState?.fields['liters']
//                             ?.didChange(updatedMilkCollection.liters);
//                         formKey.currentState?.fields['rate']
//                             ?.didChange(updatedMilkCollection.rate);
//                         formKey.currentState?.fields['fat']
//                             ?.didChange(updatedMilkCollection.fat);
//                         formKey.currentState?.fields['snf']
//                             ?.didChange(updatedMilkCollection.snf);
//                         formKey.currentState?.fields['amount']
//                             ?.didChange(updatedMilkCollection.amount);
//                         formKey.currentState?.fields['memberCode']
//                             ?.didChange(updatedMilkCollection.memCode);

//                         //   formKey.currentState?.fields['clr']?.didChange(updatedMilkCollection.clr);
//                         oldWeight = updatedMilkCollection.liters ?? "";
//                         oldFat = updatedMilkCollection.fat ?? "";
//                         oldSnf = updatedMilkCollection.snf ?? "";
//                         oldAmount = updatedMilkCollection.amount ?? "";
//                         controller.memberCodeController.text =
//                             updatedMilkCollection.memCode ??
//                                 ""; // Show selected value
//                         // strMemberCodeValue = updatedMilkCollection.memCode ?? "";

//                         updateCode = updatedMilkCollection.code ?? 0;
//                         controller.selectedAnimal.value =
//                             updatedMilkCollection.cattle == "C"
//                                 ? "Cow"
//                                 : "Buffalo";

//                         ///4764 milkcollectionetnry
//                         String queryM = """
//                                 SELECT * FROM MembersProfile 
//                                 WHERE MemCode = '${Formatter.m4d(updatedMilkCollection.memCode ?? "")}'
//                               """;
//                         List<MMembersProfile> listMember =
//                             await DBHelper().getMembersProfile(queryM);
//                         if (listMember.length > 0) {
//                           memCode = listMember[0].memCode;
//                           strMemberCodeValue = listMember[0].memCode ?? "";
//                           controller.memberName.value =
//                               listMember[0].memberName ?? "";
//                           memberFName = listMember[0].memberName;
//                         }
//                       }

//                       print(value);
//                     });
//                   },
//                   child: Icon(Icons.list)),
//               Utils.addHGap(20),
//             ],
//           ),
//           body: SingleChildScrollView(
//             // 👈 Prevents keyboard overflow
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Utils.addGap(5),
//                       /*  Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Loc Code: ${controller.locationcode.value}",
//                                 style: TextStyle(fontSize: istablet ? 20 : 16)),
//                           ],
//                         ),*/
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("${controller.unionName.value}",
//                               style: TextStyle(
//                                   fontSize: istablet ? 20 : 16,
//                                   fontWeight: FontWeight.w600)),
//                         ],
//                       ),
//                       Utils.addGap(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                               "${controller.locationName.value} ( ${controller.locationcode.value} )",
//                               style: TextStyle(
//                                   fontSize: istablet ? 20 : 16,
//                                   fontWeight: FontWeight.w600)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Utils.addGap(10),

//                   // **Session Row**
//                   Obx(() => Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text("Date: ${strDateFor}",
//                                   style: TextStyle(
//                                       fontSize: istablet ? 20 : 16,
//                                       fontWeight: FontWeight.w600)),
//                               Utils.addGap(5),
//                               Text(" ${controller.currentTime.value}",
//                                   style: TextStyle(
//                                       fontSize: istablet ? 20 : 16,
//                                       fontWeight: FontWeight.w600)),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 controller.sessionIcon.value == "Morning"
//                                     ? Icons.wb_sunny
//                                     : Icons.nightlight_round,
//                                 color: Colors.orange,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 controller.session.value,
//                                 style: TextStyle(
//                                     fontSize: istablet ? 20 : 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                   Utils.addGap(10),
//                   Obx(() {
//                     return Row(
//                       children: [
//                         Text("Effective Date: ${controller.effetiveDate.value}",
//                             style: TextStyle(
//                                 fontSize: istablet ? 20 : 16,
//                                 fontWeight: FontWeight.w600)),
//                       ],
//                     );
//                   }),

//                   Utils.addGap(10),

//                   // **Total Liters & Total Members Row**
//                   Obx(() => Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total Liters: ${controller.totalLiters.value == "null" ? "0" : double.tryParse(controller.totalLiters.value)?.toStringAsFixed(2)}",
//                             style: TextStyle(
//                                 fontSize: istablet ? 18 : 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "Total Members: ${controller.totalMembers.value}",
//                             style: TextStyle(
//                                 fontSize: istablet ? 18 : 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       )),

//                   SizedBox(height: 16),

//                   // **Form Inputs**
//                   FormBuilder(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         _buildMemberCodeField(),
//                         //buildTextField("memberCode", "Enter Member Code", true),
//                         SizedBox(height: 16),

//                         // **Animal Selection**
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildAnimalOption("Buffalo"),
//                             _buildAnimalOption("Cow"),
//                           ],
//                         ),

//                         Utils.addGap(16),
//                         Row(
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: _buildTextField(
//                                     "liters", "Liters", true, true, (value) {},
//                                     focusNode: literFocus,
//                                     nextFocusNode: fatFieldFocus)),
//                             Utils.addHGap(8),
//                             Expanded(
//                                 flex: 1,
//                                 child: _buildTextField(
//                                     "fat", "Fat %", true, true, (value) {},
//                                     focusNode: fatFieldFocus,
//                                     nextFocusNode: snfFieldFocus)),
//                             Utils.addHGap(8),
//                             Expanded(
//                                 flex: 1,
//                                 child: _buildTextField(
//                                     "snf", "SNF %", true, true, snfOnChanged,
//                                     focusNode: snfFieldFocus,
//                                     nextFocusNode: memberFocus)),
//                           ],
//                         ),

//                         Utils.addGap(8),
//                         Row(
//                           children: [
//                             Visibility(
//                               visible: controller.clrVisible.value,
//                               child: Expanded(
//                                   flex: 1,
//                                   child: _buildTextField(
//                                       "clr", "CLR", false, true, (value) {})),
//                             ),
//                             Utils.addHGap(8),
//                             Expanded(
//                                 flex: 1,
//                                 child: _buildTextField(
//                                     "rate", "Rate", false, false, (value) {})),
//                             Utils.addHGap(8),
//                             Expanded(
//                                 flex: 1,
//                                 child: _buildTextField("amount", "Amount",
//                                     false, false, (value) {})),
//                           ],
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
//                   onPressed: () {
//                     if (formKey.currentState!.saveAndValidate()) {
//                       final formData = formKey.currentState!.value;
//                       print("Form Data: $formData");
//                       // Handle form submission logic here
//                       //submitData();

//                       submitDataJAVA();
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

//   void snfOnChanged(String? value) {
//     submitDataJAVA();
//   }

// //old one
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
//                 print("Search value is called------------<$search");
//                 return controller.listMembers.value
//                     .where((member) => (member.memCode ?? "")
//                         .toLowerCase()
//                         .contains(search.toLowerCase()))
//                     .toList();
//               },
//               builder: (context, textController, focusNode) {
//                 return TextField(
//                   controller: controller.memberCodeController,
//                   // Use our custom controller
//                   keyboardType: TextInputType.number,
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
//                   title: Text("${member.memberName ?? " "} ${member.memCode}"),
//                 );
//               },
//               onSelected: (member) async {
//                 String query = "SELECT Code FROM MilkCollection "
//                     "WHERE CollSession = '$strSession' "
//                     "AND MemCode = '$strMemberCodeValue' "
//                     "AND CollDate = '$strDate'";

//                 String code = await DBHelper().getScalarQueryStringFromDB(query);

//               if(Utils.replaceNullZero(code)=="0"){




//               }else{
//                 showDialog(
//                   context: context,
//                   barrierDismissible: false, // same as setCancelable(false)
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Text("This member already poured milk this session. Would you like to add more?"),
//                       actions: <Widget>[
//                         TextButton(
//                           child: Text("Add"),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         TextButton(
//                           child: Text("No"),
//                           onPressed: () {
//                             Navigator.of(context).pop(); // dismiss dialog
//                             return;
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//                 controller.memberCodeController.text =
//                     "${member.memberName} ${member.memCode ?? " "}";
//                 field.didChange(member.memCode);
//                 strMemberCodeValue = member.memCode ?? "";
//                 memberFName = member.memberName;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// */
// //dropdpown
// /*  Widget _buildMemberCodeField() {
//    return FormBuilderSearchableDropdown<MMembersProfile>(
//      name: 'memberCode',
//      decoration: InputDecoration(
//        labelText: 'Select Member',
//        border: OutlineInputBorder(),
//      ),
//      items: controller.listMembers.value,
//      compareFn: (a, b) => a?.memCode == b?.memCode, // 👈 required for custom types

//      itemAsString: (member) => "${member.memberName ?? ""} (${member.memCode})",
//      validator: FormBuilderValidators.required(errorText: 'Member Code is required'),
//      onChanged: (selectedMember) async {
//        if (selectedMember == null) return;

//        strMemberCodeValue = selectedMember.memCode ?? "";
//        memberFName = selectedMember.memberName;

//        // Query to check if already poured
//        String query = "SELECT Code FROM MilkCollection "
//            "WHERE CollSession = '$strSession' "
//            "AND MemCode = '$strMemberCodeValue' "
//            "AND CollDate = '$strDate'";

//        String code = await DBHelper().getScalarQueryStringFromDB(query);

//        if (Utils.replaceNullZero(code) != "0") {
//          showDialog(
//            context: context,
//            barrierDismissible: false,
//            builder: (BuildContext context) {
//              return AlertDialog(
//                content: Text("This member already poured milk this session. Would you like to add more?"),
//                actions: <Widget>[
//                  TextButton(
//                    child: Text("Add"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                      // Call displayDataFirst() or similar
//                    },
//                  ),
//                  TextButton(
//                    child: Text("No"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                     // clearAllFields(); // your custom reset function
//                    },
//                  ),
//                ],
//              );
//            },
//          );
//        }
//      },
//    );
//   }*/

//   Widget _buildMemberCodeField() {
//     return Obx(() {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: FormBuilderField<String>(
//               name: 'memberCode',
//               validator: FormBuilderValidators.compose([
//                 FormBuilderValidators.required(
//                     errorText: 'Member Code is required'),
//                 FormBuilderValidators.minLength(4,
//                     errorText: 'Minimum 4 characters required'),
//               ]),
//               builder: (FormFieldState<String> field) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TypeAheadField<MMembersProfile>(
//                       builder: (context, textEditingController, focusNode) {
//                         controller.memberCodeController = textEditingController;
//                         return TextField(
//                           controller: textEditingController,
//                           focusNode: memberFocus,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Enter Member Code',
//                             errorText: field.errorText,
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(RegExp(r'^\d*$'))
//                           ],
//                           onSubmitted: (search) async {
//                             if (search == "") {
//                               /* Get.snackbar("Member Code!", "Please select member Code",
//                                     backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//                               */
//                               FocusScope.of(context).requestFocus(memberFocus);
//                               return;
//                             }

//                             String query = search.toLowerCase().trim();
//                             // Adjust query with leading zeros
//                             String adjustedQuery = query;
//                             if (int.tryParse(query) != null) {
//                               if (query.length == 1) {
//                                 adjustedQuery = "000$query";
//                               } else if (query.length == 2) {
//                                 adjustedQuery = "00$query";
//                               }
//                             }

//                             // Find the first matching member (same logic as suggestionsCallback)
//                             final matchedMember =
//                                 controller.listMembers.value.firstWhere(
//                               (member) => (member.memCode ?? "")
//                                   .toLowerCase()
//                                   .contains(adjustedQuery),
//                               orElse: () => MMembersProfile(),
//                             );

//                             if ((matchedMember.memCode ?? "").isNotEmpty) {
//                               _bluetoothService.resumeData();
//                               String sql = "SELECT Code FROM MilkCollection "
//                                   "WHERE CollSession = '$strSession' "
//                                   "AND MemCode = '${matchedMember.memCode}' "
//                                   "AND CollDate = '$strDate' and Locked=0";

//                               String code = await DBHelper()
//                                   .getScalarQueryStringFromDB(sql);

//                               if (Utils.replaceNullZero(code) != "0") {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       content: Text(
//                                           "This member already poured milk this session. Would you like to add more?"),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           child: Text("Add"),
//                                           onPressed: () =>
//                                               Navigator.of(context).pop(),
//                                         ),
//                                         TextButton(
//                                           child: Text("No"),
//                                           onPressed: () =>
//                                               Navigator.of(context).pop(),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               }
//                               clearForm();
//                               _bluetoothService.resumeData();
//                               // Set member data
//                               controller.memberCodeController.text =
//                                   "${matchedMember.memCode}";
//                               controller.memberName.value =
//                                   matchedMember.memberName ?? "";
//                               field.didChange(matchedMember.memCode);
//                               strMemberCodeValue = matchedMember.memCode ?? "";
//                               memberFName = matchedMember.memberName;
//                               print("selected members animal type ---------------->${matchedMember.cattleTypeName }");
//                               controller.selectedAnimal.value =
//                                   (matchedMember.cattleTypeName ?? "")
//                                           .toLowerCase().contains("buff") || (matchedMember.cattleTypeName ?? "")
//                                       .toLowerCase().contains("m")
//                                       ? "Buffalo"
//                                       : "Cow";
//                               print(matchedMember.cattleTypeName);
//                               FocusScope.of(context).requestFocus(literFocus);
//                             } else {
//                               // Optionally show error or do nothing
//                               Utils.showToast("No member found for $search");
//                             }
//                           },
//                           onChanged: (val) {
//                             if (val.length < 4) {
//                               controller.memberName.value = "";
//                             }
//                             focusNode
//                                 .requestFocus(); // Keep focus so suggestions keep updating
//                           },
//                         );
//                       },
//                       /*
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

//                       suggestionsCallback: (search) {
//                         print("Search value is called: <$search>");
//                         final query = search.toLowerCase().trim();

//                         // Adjust query with leading zeros if it's numeric and length <= 2
//                         String adjustedQuery = query;
//                         if (int.tryParse(query) != null) {
//                           if (query.length == 1) {
//                             adjustedQuery = "000$query";
//                             print(adjustedQuery);
//                           } else if (query.length == 2) {
//                             adjustedQuery = "00$query";
//                             print(adjustedQuery);
//                           }
//                         }

//                         return controller.listMembers.value.where((member) {
//                           final memCode = (member.memCode ?? "").toLowerCase();
//                           // final name = (member.memberName ?? "").toLowerCase();

//                           return memCode.contains(adjustedQuery) ||
//                               /*   name.contains(query) ||*/
//                               /*$name*/ " $memCode".contains(query);
//                         }).toList();
//                       },
//                       itemBuilder: (context, member) {
//                         return ListTile(
//                           title: Text(/*${member.memberName ?? " "}*/
//                               " ${member.memCode}"),
//                         );
//                       },
//                       onSelected: (member) async {
//                         String query = "SELECT Code FROM MilkCollection "
//                             "WHERE CollSession = '$strSession' "
//                             "AND MemCode = '${member.memCode}' "
//                             "AND CollDate = '$strDate'";

//                         String code =
//                             await DBHelper().getScalarQueryStringFromDB(query);

//                         if (Utils.replaceNullZero(code) != "0") {
//                           showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 content: Text(
//                                     "This member already poured milk this session. Would you like to add more?"),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: Text("Add"),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       _bluetoothService.resumeData();
//                               }

//                                   ),
//                                   TextButton(
//                                     child: Text("No"),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       return;
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                         _bluetoothService.resumeData();

//                         controller.memberCodeController.text =
//                             /*${member.memberName}*/ "${member.memCode ?? " "}";
//                         controller.memberName.value = "${member.memberName}";
//                         field.didChange(
//                             member.memCode); // updates FormBuilder field value
//                         strMemberCodeValue = member.memCode ?? "";
//                         memberFName = member.memberName;
//                         print(controller.memberName.value);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Utils.addHGap(10),
//           Expanded(flex: 2, child: _buildSelectedMemberNameField())
//         ],
//       );
//     });
//   }

//   Widget _buildSelectedMemberNameField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         controller.memberName.value.isEmpty
//             ? 'Member Name'
//             : controller.memberName.value,
//         style: TextStyle(
//           fontSize: 16,
//           color:
//               controller.memberName.value.isEmpty ? Colors.grey : Colors.black,
//         ),
//       ),
//     );
//   }

//   /// **Builds the Animal Selection UI**
//   Widget _buildAnimalOption(String animal) {
//     return GestureDetector(
//       onTap: () => controller.updateAnimal(animal),
//       child: Obx(() => Container(
//             width: istablet ? 160 : 120,
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
//   /* Widget _buildTextField(String name, String label, bool isRequired,bool readOnly,
//       void Function(String?) onChanged) {
//     return FormBuilderTextField(
//       name: name,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       validator: isRequired
//           ? FormBuilderValidators.required(errorText: "This field is required")
//           : null,
//       readOnly: readOnly,
//       keyboardType: TextInputType.number,
//       textInputAction: TextInputAction.next,
//       // <-- This sets the keyboard action
//       decoration:
//           InputDecoration(labelText: label, border: OutlineInputBorder()),
//       onSubmitted: onChanged,
//     );
//   }*/

//   ///old one above

// //old
//   /* Widget _buildTextField(
//       String name,
//       String label,
//       bool isRequired,
//       bool readOnly,
//       void Function(String?) onChanged, {
//         FocusNode? focusNode,
//         FocusNode? nextFocusNode,
//       }) {
//     return FormBuilderTextField(
//       name: name,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       validator: isRequired
//           ? FormBuilderValidators.required(errorText: "This field is required")
//           : null,
//       readOnly: readOnly,
//       keyboardType: TextInputType.number,
//       textInputAction: TextInputAction.next,
//       focusNode: focusNode,
//       decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//       onSubmitted: (val) {
//         onChanged(val);
//         // Move focus to next field if provided
//         if (nextFocusNode != null) {
//           FocusScope.of(context).requestFocus(nextFocusNode);
//         }
//       },
//     );
//   }*/

//   Widget _buildTextField(
//     String name,
//     String label,
//     bool isRequired,
//     bool readOnly,
//     void Function(String?) onChanged, {
//     FocusNode? focusNode,
//     FocusNode? nextFocusNode,
//   }) {
//     // Regex for allowed input patterns
//     RegExp regex;
//     if (name.toLowerCase() == "liters") {
//       regex = RegExp(r'^\d{0,3}(\.\d{0,2})?$'); // max 999.99
//     } else if (name.toLowerCase() == "fat" || name.toLowerCase() == "snf") {
//       regex = RegExp(r'^\d{0,2}(\.\d{0,1})?$'); // max 99.9
//     } else {
//       regex = RegExp(r'^\d*\.?\d*$'); // fallback
//     }
//     return FormBuilderTextField(
//       name: name,
//       style: TextStyle(fontSize: istablet ? 9.sp : 16.sp, color: Colors.black),
//       validator: (value) {
//         if (isRequired && (value == null || value.isEmpty)) {
//           return "This field is required";
//         }
//         if (isRequired) {
//           final doubleVal = double.tryParse(value ?? "");
//           if (doubleVal == null) return "Enter a valid number";

//           // Additional logical check
//           if (name.toLowerCase() == "liters" && doubleVal > 999.99) {
//             return "Max allowed is 999.99";
//           } else if ((name.toLowerCase() == "fat" ||
//                   name.toLowerCase() == "snf") &&
//               doubleVal > 99.9) {
//             return "Max allowed is 99.9";
//           }
//         }

//         return null;
//       },
//       //  readOnly: readOnly,
//       enabled: readOnly,
//       keyboardType: TextInputType.numberWithOptions(decimal: true),
//       textInputAction: TextInputAction.next,
//       focusNode: focusNode,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(regex),
//       ],
//       onSubmitted: (val) {
//         onChanged(val);
//         formKey.currentState!.save(); // Save the current form state first

//         if (formKey.currentState!.saveAndValidate()) {
//           var formdata = formKey.currentState!.value;
//           print(formdata);
//           if (formdata['memberCode'] == null) {
//             /*  Get.snackbar("Member Code!", "Please select member Code",
//                 backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//        */
//             FocusScope.of(context).requestFocus(memberFocus);
//             return;
//           }
//           if (formdata['liters'] == null) {
//             /* Get.snackbar("Liters !", "Please enter Liters",
//                 backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//         */
//             FocusScope.of(context).requestFocus(literFocus);
//             return;
//           }
//           if (formdata['fat'] == null) {
//             /* Get.snackbar("Fat !", "Please enter Fat",
//                 backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//         */
//             FocusScope.of(context).requestFocus(fatFieldFocus);
//             return;
//           }

//           if (formdata['snf'] == null) {
//             /*  Get.snackbar("Snf !", "Please enter Snf",
//                 backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//          */
//             FocusScope.of(context).requestFocus(snfFieldFocus);
//             return;
//           }
//         } else {
//           if (nextFocusNode != null) {
//             if (val != null && val != "") {
//               print(val);
//               FocusScope.of(context).requestFocus(nextFocusNode);
//             }
//           }
//         }
//       },
//     );
//   }

//   submitDataJAVA() async {
//     milkColEntryType = await controller.storageService
//         .getInt(AppConstants.milkCollectionTypePR);
//     formKey.currentState!.save(); // Save the current form state first

//     var formdata = formKey.currentState!.value;

//     print(formdata);
//     if (formdata['memberCode'] == null) {
//       /*    Get.snackbar("Member Code!", "Please select member Code",
//             backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//     */
//       FocusScope.of(context).requestFocus(memberFocus);
//       return;
//     }
//     if (formdata['memberCode'].length < 4) {
//       FocusScope.of(context).requestFocus(memberFocus);
//       return;
//     }
//     if (formdata['liters'] == null) {
//       /* Get.snackbar("Liters !", "Please enter Liters",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//   */
//       FocusScope.of(context).requestFocus(literFocus);
//       return;
//     }
//     if (formdata['fat'] == null) {
//       /* Get.snackbar("Fat !", "Please enter Fat",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//   */
//       FocusScope.of(context).requestFocus(fatFieldFocus);
//       return;
//     }

//     if (formdata['snf'] == null) {
//       /*  Get.snackbar("Snf !", "Please enter Snf",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
//   */
//       FocusScope.of(context).requestFocus(snfFieldFocus);
//       return;
//     }

//     if (formdata['liters'] != null) {
//       double liters = double.tryParse(formdata['liters'].toString()) ?? 0.0;
//       if (liters > 99.99) {
//         Utils.showToast("Please enter valid value for Liters");
//         return;
//       }
//     } if (formdata['liters'] != null) {
//       double liters = double.tryParse(formdata['liters'].toString()) ?? 0.0;
//       if (liters > 99.99) {
//         Utils.showToast("Please enter valid value for Liters");
//         return;
//       }
//     }

//     _bluetoothService.pauseData();
//     strLiter = formdata['liters'] ?? "0";
//     strSnf =
//         ((double.tryParse(formdata['snf'] ?? "0")) ?? 0).toStringAsFixed(1);
//     strFat =
//         ((double.tryParse(formdata['fat'] ?? "0")) ?? 0).toStringAsFixed(1);

//     //strAmount = formdata['amount'];

// //parsing using numberformat
//     double parsedValueStrLiter = double.tryParse(strLiter) ?? 0.0;

//     strLiter = dfRate.value.format(parsedValueStrLiter);

//     double parsedValueStrfat = double.tryParse(strFat) ?? 0.0;

//     strFat = dfFat.value.format(parsedValueStrfat);

//     if (mSettingsRate?.paymentType == 1) {
//       ///check for milkcollectiontype when you do
//       double parsedValueStrSnf = double.tryParse(strSnf) ?? 0.0;
//       strSnf = dfSnf.value.format(parsedValueStrSnf);
//     }

//     if (milkColEntryType != 1) {
//       double parsedValueStrfat = double.tryParse(strFat) ?? 0.0;

//       strFat = dfFat.value.format(parsedValueStrfat);

//       double parsedValueStrSnf = double.tryParse(strSnf) ?? 0.0;

//       strSnf = dfSnf.value.format(parsedValueStrSnf);

//       if (controller.selectedAnimal.value.toLowerCase().contains("cow")) {
//         if (intAllowZeroFat == 0) {
//           /*if (double.parse(strFat) <
//               double.parse(dfFat.value.format(rejectCowMinFat))) {
//             Utils.showToast(
//                 " FAT is less than Minimum FAT required (${rejectCowMinFat}). Can not submit.");
//           }*/

//           double fatValue = double.tryParse(strFat) ?? 0.0;

// // First parse rejectBuffMinFat into double, then format it
//           double rejectCowMinFatDouble =
//               double.tryParse(rejectCowMinFat == "" ? "0" : rejectCowMinFat) ??
//                   0.0;
//           double minFat =
//               double.tryParse(dfFat.value.format(rejectCowMinFatDouble)) ?? 0.0;

//           if (fatValue < minFat) {
//             Utils.showToast(
//                 "FAT is less than Minimum FAT required ($rejectCowMinFat). Cannot submit.");
//           }
//         }

//         if (mSettingsRate?.paymentType == 1) {
//           if (intAllowZeroSNF == 0) {
//             /*      if (double.parse(strSnf) <
//                 double.parse(dfSnf.value.format(rejectCowMinSNF))) {
//               Utils.showToast(
//                   " SNF is less than Minimum SNF required (${rejectCowMinSNF}). Can not submit.");
//             }*/

//             double enteredSNF = double.tryParse(strSnf) ?? 0.0;

//             double minSNF = double.parse(
//               dfSnf.value.format(double.tryParse(rejectCowMinSNF ?? "0") ?? 0),
//             );
//             if (enteredSNF < minSNF) {
//               Utils.showToast(
//                   "SNF is less than Minimum SNF required (${rejectCowMinSNF}). Cannot submit.");
//             }
//           }
//         }
//       } else if (controller.selectedAnimal.value
//           .toLowerCase()
//           .contains("buffalo")) {
//         if (intAllowZeroFat == 0) {
//           /*   if (double.parse(strFat) <
//               double.parse(dfFat.value.format(rejectBuffMinFat==""?"0":rejectBuffMinFat))) {
//             Utils.showToast(
//                 " FAT is less than Minimum FAT required (${rejectBuffMinFat}). Can not submit.");
//           }*/ //old code causing problem

//           double fatValue = double.tryParse(strFat) ?? 0.0;

// // First parse rejectBuffMinFat into double, then format it
//           double rejectBuffMinFatDouble = double.tryParse(
//                   rejectBuffMinFat == "" ? "0" : rejectBuffMinFat) ??
//               0.0;
//           double minFat =
//               double.tryParse(dfFat.value.format(rejectBuffMinFatDouble)) ??
//                   0.0;

//           if (fatValue < minFat) {
//             Utils.showToast(
//                 "FAT is less than Minimum FAT required ($rejectBuffMinFat). Cannot submit.");
//           }
//         }

//         if (mSettingsRate?.paymentType == 1) {
//           if (intAllowZeroSNF == 0) {
//             /* if (double.parse(strSnf) <
//                 double.parse(dfSnf.value.format(rejectBuffMinSNF))) {
//               Utils.showToast(
//                   " SNF is less than Minimum SNF required (${rejectBuffMinSNF}). Can not submit.");
//             }*/ //old code giving probelm
//             ///jay panchal changed code her efor isnegative
//             double enteredSNF = double.tryParse(strSnf) ?? 0.0;

//             double minSNF = double.parse(
//               dfSnf.value.format(double.tryParse(rejectBuffMinSNF ?? "0") ?? 0),
//             );
//             if (enteredSNF < minSNF) {
//               Utils.showToast(
//                   "SNF is less than Minimum SNF required (${rejectBuffMinSNF}). Cannot submit.");
//             }
//           }
//         }
//       }
//     }
//     // ---------Now Calculate Rate Chart---------------------------------------------------------------

//     if (mSettingsRate != null) {
//       // calculation fat base Rate of buffalo.
//       if (mSettingsRate?.paymentType == 0 && mSettingsRate?.paymentOn == 1) {
//         if (controller.selectedAnimal.value.toLowerCase().contains("buffalo")) {
//           FatBasedRateChartModel? mfatBasedRateChart = FatBasedRateChartModel();

//           String QueryRate = "SELECT * FROM FATBasedRateChartManual " +
//               "WHERE ((ToFat >= '" +
//               strFat +
//               "' AND FromFat <= '" +
//               strFat +
//               "')" +
//               " OR (ToFat <= '" +
//               strFat +
//               "')) AND CattleType = '1' " +
//               "AND IFNULL(Locked, '0') != '1' ORDER BY ToFat DESC LIMIT 1";

//           mfatBasedRateChart =
//               await controller.dbHelper.getFATBasedRateChart(QueryRate);

//           if (mfatBasedRateChart?.data?[0].rate != null &&
//               milkColEntryType != 1) {
//             Utils.showToast("Fat below permissible limit - Buff.");
//             return;
//           }

//           double rateBuffVal = 0;
//           if ((double.tryParse(strFat))! >
//               (double.tryParse(
//                       "${mfatBasedRateChart?.data?[0].toFat ?? 0.0}") ??
//                   0.0)) {
//             rateBuffVal = ((((double.tryParse(
//                                 "${mfatBasedRateChart?.data?[0].rate ?? 0.0}") ??
//                             0.0) -
//                         (double.tryParse(
//                                 "${mSettingsRate?.buffCommissionRate ?? 0.0}") ??
//                             0.0)) *
//                     (double.tryParse(
//                             "${mfatBasedRateChart?.data?[0].toFat ?? 0.0}") ??
//                         0.0)) /
//                 100);
//           } else {
//             String buffCommissionRate = "${mSettingsRate?.buffCommissionRate}";
//             if (buffCommissionRate == "" || buffCommissionRate.isEmpty) {
//               buffCommissionRate = "0.0";
//             }
//             rateBuffVal = ((((double.tryParse(
//                                 "${mfatBasedRateChart?.data?[0].rate ?? 0.0}") ??
//                             0.0) -
//                         (double.tryParse("${buffCommissionRate}") ?? 0.0)) *
//                     (double.tryParse(strFat) ?? 0.0)) /
//                 100);
//           }

//           strRate = dfAmount.value.format(rateBuffVal);
//           strKgRate = "${mfatBasedRateChart?.data?[0].rate ?? 0.0}";
//         } else if (controller.selectedAnimal.value
//             .toLowerCase()
//             .contains("cow")) {
//           String QueryRate = "SELECT * from FATBasedRateChartManual " +
//               "WHERE ((ToFat >= '" +
//               strFat +
//               "' AND FromFat <= '" +
//               strFat +
//               "')" +
//               " OR (ToFat <='" +
//               strFat +
//               "') ) " +
//               "AND CattleType='0' AND IFNULL(Locked, '0') != '1' " +
//               "ORDER BY ToFat DESC LIMIT 1";

//           FatBasedRateChartModel? mFatBasedRateChartModel =
//               await controller.dbHelper.getFATBasedRateChart(QueryRate);

//           if (mFatBasedRateChartModel?.data?[0].rate == null &&
//               milkColEntryType != 1) {
//             Utils.showToast("Fat below permissible limit - Cow.");
//             return false;
//           }

//           double rateCowVal = 0.0;
//           strKgRate = "${mFatBasedRateChartModel?.data?[0].rate}";

//           ///----------------- Now three Different condition for  rate kg for Cow . based on grade system

//           int gradeNo = mFatBasedRateChartModel?.data?[0].grade ?? 0;

//           if (((double.tryParse(strFat) ?? 0.0) >
//               (double.tryParse(
//                       "${mFatBasedRateChartModel?.data?[0].toFat ?? 0.0}") ??
//                   0.0))) {
//             if (gradeNo == 1) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade1Factor ?? 0.0) +
//                           (mFatBasedRateChartModel?.data?[0].toFat ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 2) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade2Factor ?? 0.0) +
//                           (mFatBasedRateChartModel?.data?[0].toFat ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 3) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade3Factor ?? 0.0) +
//                           (mFatBasedRateChartModel?.data?[0].toFat ?? 0.0))) /
//                   100);
//             }
//           } else {
//             if (gradeNo == 1) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade1Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 2) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade2Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 3) {
//               rateCowVal = ((((mFatBasedRateChartModel?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade3Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             }
//           }
//           strRate = dfAmount.value.format(rateCowVal);
//           strAmount = dfAmount.value.format((double.tryParse(strLiter) ?? 0.0) *
//               (double.tryParse(strRate) ?? 0.0));

//           ///set values here...
//           formKey.currentState?.fields['amount']?.didChange(strAmount);
//           formKey.currentState?.fields['rate']?.didChange(strRate);
//         }
//       } else if (mSettingsRate?.paymentType == 0 &&
//           mSettingsRate?.paymentOn == 0) {
//         if (controller.selectedAnimal.value.toLowerCase().contains("buffalo")) {
//           String QueryRate = "SELECT * FROM FATBasedRateChart " +
//               "WHERE IFNULL(Locked,'0') != '1' AND " +
//               "FromFat <= '" +
//               strFat +
//               "' AND " +
//               "ToFat  >= '" +
//               strFat +
//               "'  AND " +
//               "CattleType = '1' ORDER BY EffectiveDate";

//           FatBasedRateChartModel? mfatBasedRateChart = FatBasedRateChartModel();

//           if (mfatBasedRateChart.data?[0].rate != null) {
//             String? maxFat = await controller.dbHelper.getScalarQueryStringFromDB(
//                 "SELECT MAX(ToFat) FROM FATBasedRateChart WHERE CattleType='1' AND ifnull(Locked,'0')!='1'");
//             print("Max FAT: $maxFat");

//             if (maxFat != "" && maxFat != "0") {
//               if ((double.tryParse(strFat) ?? 0.0) >
//                   (double.tryParse(maxFat) ?? 0.0)) {
//                 String QueryRat = "SELECT * FROM FATBasedRateChart " +
//                     "WHERE (ToFat = (select Max(ToFat) FROM FATBasedRateChart)) " +
//                     "AND CattleType = '1' AND IFNULL(Locked,'0') != '1' " +
//                     "ORDER BY ToFat DESC LIMIT 1";

//                 mfatBasedRateChart =
//                     await controller.dbHelper.getFATBasedRateChart(QueryRat);
//               }
//             }
//           }

//           if (mfatBasedRateChart?.data?[0].rate == null) {
//             Utils.showToast("Fat below permissible limit -Buff");
//           }

//           double rateBuffVal = 0;

//           if ((double.tryParse(strFat) ?? 0.0) >
//               (double.tryParse(
//                       "${mfatBasedRateChart?.data?[0].toFat ?? 0.0}") ??
//                   0.0)) {
//             rateBuffVal = ((((double.tryParse(
//                                 "${mfatBasedRateChart?.data?[0].rate ?? 0.0}") ??
//                             0.0) -
//                         (double.tryParse(
//                                 "${mSettingsRate?.buffCommissionRate ?? 0.0}") ??
//                             0.0)) *
//                     (double.tryParse(
//                             "${mfatBasedRateChart?.data?[0].toFat ?? 0.0}") ??
//                         0.0)) /
//                 100);
//           } else {
//             rateBuffVal = ((((double.tryParse(
//                                 "${mfatBasedRateChart?.data?[0].rate ?? 0.0}") ??
//                             0.0) -
//                         (double.tryParse(
//                                 "${mSettingsRate?.buffCommissionRate ?? 0.0}") ??
//                             0.0)) *
//                     (double.tryParse(strFat) ?? 0.0)) /
//                 100);
//           }

//           strRate = dfAmount.value.format(rateBuffVal);
//           strKgRate = "${mfatBasedRateChart?.data?[0].rate}";
//         } else if (controller.selectedAnimal.value
//             .toLowerCase()
//             .contains("cow")) {
//           String QueryRate = "SELECT * FROM FATBasedRateChart " +
//               "WHERE IFNULL(Locked,'0') != '1' AND " +
//               "FromFat <= '" +
//               strFat +
//               "' AND " +
//               "ToFat >= '" +
//               strFat +
//               "' AND " +
//               "CattleType = '0' ORDER BY EffectiveDate";

//           FatBasedRateChartModel? mfatBasedRateChart =
//               await controller.dbHelper.getFATBasedRateChart(QueryRate);

//           if (mfatBasedRateChart?.data?[0].rate != null) {
//             String? maxFat = await controller.dbHelper.getScalarQueryStringFromDB(
//                 "Select Max(ToFat) From FATBasedRateChart Where CattleType='0' AND ifnull(Locked,'0')!='1'");
//             print("Max FAT: $maxFat");

//             if (maxFat != "" && maxFat != "0") {
//               if ((double.tryParse(strFat) ?? 0.0) >
//                   (double.tryParse(maxFat) ?? 0.0)) {
//                 String QueryRat = "SELECT * FROM FATBasedRateChart " +
//                     "WHERE (ToFat = (SELECT Max(ToFat) FROM FATBasedRateChart)) " +
//                     "AND CattleType = '0' AND " +
//                     "IFNULL(Locked,'0') != '1' " +
//                     "ORDER BY ToFat DESC LIMIT 1";

//                 mfatBasedRateChart =
//                     await controller.dbHelper.getFATBasedRateChart(QueryRat);
//               }
//             }
//           }

//           if (mfatBasedRateChart?.data?[0].rate == null) {
//             Utils.showToast("Fat below permissible limit - Cow.");
//             return false;
//           }
//           double rateCowVal = 0.0;
//           strKgRate = "${mfatBasedRateChart?.data?[0].rate}";

//           ///----------------- Now three Different condition for  rate kg for Cow . based on grade system

//           int gradeNo = mfatBasedRateChart?.data?[0].grade ?? 0;

//           if (((double.tryParse(strFat) ?? 0.0) >
//               (double.tryParse(
//                       "${mfatBasedRateChart?.data?[0].toFat ?? 0.0}") ??
//                   0.0))) {
//             if (gradeNo == 1) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade1Factor ?? 0.0) +
//                           (mfatBasedRateChart?.data?[0].toFat ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 2) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade2Factor ?? 0.0) +
//                           (mfatBasedRateChart?.data?[0].toFat ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 3) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade3Factor ?? 0.0) +
//                           (mfatBasedRateChart?.data?[0].toFat ?? 0.0))) /
//                   100);
//             }
//           } else {
//             if (gradeNo == 1) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade1Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 2) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade2Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             } else if (gradeNo == 3) {
//               rateCowVal = ((((mfatBasedRateChart?.data?[0].rate ?? 0.0) -
//                           (mSettingsRate?.cowCommissionRate ?? 0.0)) *
//                       ((mSettingsRate?.cowGrade3Factor ?? 0.0) +
//                           (double.tryParse(strFat) ?? 0.0))) /
//                   100);
//             }
//           }

//           ///set values here...
//           strRate = dfAmount.value.format(rateCowVal);
//         }
//         strAmount = dfAmount.value.format(((double.tryParse(strLiter) ?? 0.0) *
//             (double.tryParse("${strRate}") ?? 0.0)));
//         formKey.currentState?.fields['amount']?.didChange(strAmount);
//         formKey.currentState?.fields['rate']?.didChange(strRate);
//       }

//       ///2347 line in java
//       else if (mSettingsRate?.paymentType == 0 &&
//           mSettingsRate?.paymentOn == 2) {
//         if (controller.selectedAnimal.value.toLowerCase().contains("buffalo")) {
//           String queryRate = """
//                   SELECT Rate 
//                   FROM FATBaseRateChartForOnlyFat 
//                   WHERE FatValue = '${Formatter.m21d(strFat)}' 
//                   AND CattleType = 'B' 
//                   ORDER BY EffectiveDate
//               """;

//           strRate =
//               await controller.dbHelper.getScalarQueryStringFromDB(queryRate);
//           if (strRate == "0") {
//             String queryFat =
//                 "SELECT MAX(FatValue) FROM FATBaseRateChartForOnlyFat WHERE CattleType = 'B' ORDER BY EffectiveDate";

//             String maxFat =
//                 await controller.dbHelper.getScalarQueryStringFromDB(queryFat);

//             if ((double.tryParse(strFat) ?? 0.0) >
//                 (double.tryParse(maxFat) ?? 0.0)) {
//               String maxRate = "SELECT Rate FROM FATBaseRateChartForOnlyFat "
//                   "WHERE FatValue = '$maxFat' AND CattleType = 'B' ORDER BY EffectiveDate";

//               strRate =
//                   await controller.dbHelper.getScalarQueryStringFromDB(maxRate);
//             } else {
//               strRate = "0";
//             }
//           }
//           strRate = dfAmount.value.format(double.tryParse(strRate));
//         } else if (controller.selectedAnimal.value
//             .toLowerCase()
//             .contains("cow")) {
//           String queryRate = "SELECT Rate FROM FATBaseRateChartForOnlyFat "
//               "WHERE FatValue = '${Formatter.m21d(strFat)}' AND CattleType = 'C' ORDER BY EffectiveDate";

//           strRate =
//               await controller.dbHelper.getScalarQueryStringFromDB(queryRate);

//           if (strRate == "0") {
//             String queryFat =
//                 "SELECT Max(FatValue) FROM FATBaseRateChartForOnlyFat "
//                 "WHERE CattleType = 'C' ORDER BY EffectiveDate";

//             String maxFat =
//                 await controller.dbHelper.getScalarQueryStringFromDB(queryFat);

//             if ((double.tryParse(strFat) ?? 0.0) >
//                 (double.tryParse(maxFat) ?? 0.0)) {
// //2415
//               String maxRate = """
//                   SELECT Rate FROM FATBaseRateChartForOnlyFat 
//                   WHERE FatValue = '$maxFat' AND CattleType = 'C' 
//                   ORDER BY EffectiveDate
//                 """;
//               strRate = await DBHelper().getScalarQueryStringFromDB(maxRate);
//             } else {
//               strRate = "0";
//             }
//           }
//           strRate = dfAmount.value.format(double.tryParse(strRate));
//         }

//         strAmount = dfAmount.value.format((double.tryParse(strLiter) ?? 0.0) *
//             (double.tryParse(strRate) ?? 0.0));
//         formKey.currentState?.fields['amount']?.didChange(strAmount);
//         formKey.currentState?.fields['rate']?.didChange(strRate);
//       }

//       ///2443 line in java
//       else if (mSettingsRate?.paymentType == 1) {
//         // SNF based Rate calculation
//         if (controller.selectedAnimal.value.toLowerCase().contains("buffalo")) {
//           strFat = dfFatSnf.value.format(double.tryParse(strFat));
//           String columnName = "FAT_${strFat.replaceAll('.', '_')}";

//           /* String queryRate = """
//               SELECT $columnName FROM FATBasedRateChartManualExcel
//               WHERE SNF = '${double.parse(strSnf).toStringAsFixed(2)}'
//               AND CattleType = 'B'
//               AND DATE(substr(EffectiveDate,7,4) || '-' || substr(EffectiveDate,4,2) || '-' || substr(EffectiveDate,1,2)) <=
//               DATE(substr('$strDateFor',7,4) || '-' || substr('$strDateFor',4,2) || '-' || substr('$strDateFor',1,2))
//               ORDER BY EffectiveDate
//             """;*/

//           String queryRate = """
//               SELECT $columnName FROM FATBasedRateChartManualExcel 
//               WHERE SNF = '${double.parse(strSnf).toStringAsFixed(2)}' 
//               AND CattleType = 'B' 
//               ORDER BY EffectiveDate
//             """;

//           String price = await DBHelper().getScalarQueryStringFromDB(queryRate);
//           if (price == null || price == "null" || price == "") {
//             Utils.showToast("NO Rate found using this criteria. - Buff.");
//             return;
//           }

//           double rateBuffVal =
//               (double.tryParse(Utils.replaceNullZero(price)) ?? 0.0);
//           strRate = dfAmount.value.format(rateBuffVal);
//         } else if (controller.selectedAnimal.value
//             .toLowerCase()
//             .contains("cow")) {
//           strFat = dfFatSnf.value.format(double.tryParse(strFat));

//           String columnName = "FAT_${strFat.replaceAll('.', '_')}";

//           /* String queryRate = """
//                 SELECT $columnName FROM FATBasedRateChartManualExcel
//                 WHERE SNF = '${double.parse(strSnf).toStringAsFixed(2)}'
//                 AND CattleType = 'C'
//                 AND DATE(substr(EffectiveDate,7,4) || '-' || substr(EffectiveDate,4,2) || '-' || substr(EffectiveDate,1,2)) <=
//                 DATE(substr('$strDateFor',7,4) || '-' || substr('$strDateFor',4,2) || '-' || substr('$strDateFor',1,2))
//                 ORDER BY EffectiveDate
//               """;*/

//           String queryRate = """
//                 SELECT $columnName FROM FATBasedRateChartManualExcel 
//                 WHERE SNF = '${double.parse(strSnf).toStringAsFixed(2)}' 
//                 AND CattleType = 'C' 
//                 ORDER BY EffectiveDate
//               """;
//           String price = await DBHelper().getScalarQueryStringFromDB(queryRate);

//           if (price == null || price == "null" || price == "") {
//             Utils.showToast("NO Rate found using this criteria. - Cow.");
//             return;
//           }
//           double rateBuffVal =
//               (double.tryParse(Utils.replaceNullZero(price)) ?? 0.0);
//           strRate = dfAmount.value.format(rateBuffVal);
//         }

//         strAmount = dfAmount.value.format((double.tryParse(strLiter) ?? 0.0) *
//             (double.tryParse(strRate) ?? 0.0));
//         formKey.currentState?.fields['amount']?.didChange(strAmount);
//       }
//     } else {
//       Utils.showToast("No values set for Rate Chart Calculation");
//     }

//     if (double.tryParse(strRate) == 0 && milkColEntryType != 1) {
//       showRateDialog(context, callPriceAndPrint);
//     } else {
//       //showRateDialog(context,callPriceAndPrint);
//       callPriceAndPrint();
//     }
//   }

//   updateOdairyRegister() async {
//     int locationCodeint =
//         await StorageService().getInt(AppConstants.locationCodePr);
//     String locationCode = locationCodeint.toString();

//     String userLoginCode =
//         await StorageService().getString(AppConstants.userIDPr);

//     print(locationCode);
//     String queryCow = """
//         SELECT 
//           count(MemCode) as MemCode,
//           printf('%.2f', (SUM(KgFat)/SUM(Liters))) as FAT,
//           printf('%.2f', SUM(Amount)) as Amount,
//           printf('%.2f', SUM(Liters)) as Liters,
//           printf('%.2f', (SUM(KgSnf)/SUM(Liters))) as SNF
//         FROM MilkCollection 
//         WHERE CollDate = '$strDate' 
//           AND CollSession = '$strSession' 
//           AND Cattle = 'C' 
//           AND Locked <> '1'
//       """;

//     MilkCollection? milkCollectionCow =
//         await DBHelper().getMilkCollSessSum(queryCow);

//     String code = Utils.replaceNullZero(await DBHelper()
//         .getScalarQueryStringFromDB(
//             "Select Code From ODairyRegister WHERE LocationCode='" +
//                 locationCode +
//                 "'" +
//                 " AND EntryDate='" +
//                 strDate +
//                 "' AND Session='" +
//                 strSession +
//                 "' AND Category='C'"));

//     if (code != "0") {
//       String query = """
//             UPDATE ODairyRegister 
//             SET 
//               PurchaseMilkMembers = '${milkCollectionCow?.memCode}',
//               PurchaseMilkWeight = '${milkCollectionCow?.liters}',
//               PurchaseMilkFat = '${milkCollectionCow?.fat}',
//               PurchaseMilkSNF = '${milkCollectionCow?.snf}',
//               PurchaseMilkAmount = '${milkCollectionCow?.amount}',
//               isSync = '0' 
//             WHERE Code = '$code'
//           """;
//       await DBHelper().executeRawQuery(query);
//     } else {
//       String maxautostr =
//           await StorageService().getString(AppConstants.maxAutoCodeODairyPr);
//       int? maxAutoCode = int.tryParse(Utils.replaceNullZero(maxautostr));
//       String maxAutoCodeLocalStr = Utils.replaceNullZero(await DBHelper()
//           .getScalarQueryStringFromDB(
//               "Select Max(AutoId) From ODairyRegister"));
//       int? maxAutoCodeLocal = int.tryParse(maxAutoCodeLocalStr);
//       int maxCode = 0;

//       if ((maxAutoCodeLocal ?? 0) > (maxAutoCode ?? 0)) {
//         maxCode = (maxAutoCodeLocal ?? 0) + 1;
//       } else {
//         maxCode = (maxAutoCode ?? 0) + 1;
//       }

//       String query = """
//           INSERT INTO ODairyRegister (
//             AutoId, LocationCode, LastCanNo, LastCanLiter, CompanyCode, EntryDate,
//             Session, Category, PurchaseMilkMembers, PurchaseMilkWeight, 
//             PurchaseMilkFat, PurchaseMilkSNF, PurchaseMilkAmount, isSync
//           ) VALUES (
//             '$maxCode', '$locationCode', '1', '10', '1', '$strDate', '$strSession', 'C',
//             '${milkCollectionCow?.memCode}', '${milkCollectionCow?.liters}',
//             '${milkCollectionCow?.fat}', '${milkCollectionCow?.snf}',
//             '${milkCollectionCow?.amount}', '0'
//           )
//         """;
//       await DBHelper().executeRawQuery(query);
//     }

//     // Same session for buffalo entry.

//     String queryBuff = """
//           SELECT 
//             count(MemCode) as MemCode,
//             printf('%.2f',(SUM(KgFat)/SUM(Liters))) as FAT,
//             printf('%.2f', SUM(Amount)) as Amount,
//             printf('%.2f', SUM(Liters)) as Liters,
//             printf('%.2f',(SUM(KgSnf)/SUM(Liters))) as SNF 
//           FROM MilkCollection 
//           WHERE 
//             CollDate = '$strDate' AND 
//             CollSession = '$strSession' AND 
//             Cattle = 'B' AND 
//             Locked <> '1'
//         """;

//     MilkCollection? milkCollectionBuff =
//         await DBHelper().getMilkCollSessSum(queryBuff);

//     String queryCodeBuff = """
//   SELECT Code 
//   FROM ODairyRegister 
//   WHERE 
//     LocationCode = '$locationCode' AND 
//     EntryDate = '$strDate' AND 
//     Session = '$strSession' AND 
//     Category = 'B'
// """;

// // Call your database helper method to fetch scalar value
//     String? codeBuff = Utils.replaceNullZero(
//         await DBHelper().getScalarQueryStringFromDB(queryCodeBuff));

//     if (codeBuff != "0" /*|| codeBuff != "null"*/) {
//       String query = """
//   UPDATE ODairyRegister SET 
//     PurchaseMilkMembers = '${milkCollectionBuff?.memCode}',
//     PurchaseMilkWeight = '${milkCollectionBuff?.liters}',
//     PurchaseMilkFat = '${milkCollectionBuff?.fat}',
//     PurchaseMilkSNF = '${milkCollectionBuff?.snf}',
//     PurchaseMilkAmount = '${milkCollectionBuff?.amount}',
//     isSync = '0' 
//   WHERE Code = '$codeBuff'
// """;

// // Execute the query using your db helper
//       await DBHelper().executeRawQuery(query);
//     } else {
//       String maxautostr =
//           await StorageService().getString(AppConstants.maxAutoCodeODairyPr);
//       int? maxAutoCode = int.tryParse(Utils.replaceNullZero(maxautostr));
//       String maxAutoCodeLocalStr = Utils.replaceNullZero(await DBHelper()
//           .getScalarQueryStringFromDB(
//               "Select Max(AutoId) From ODairyRegister"));
//       int? maxAutoCodeLocal = int.tryParse(maxAutoCodeLocalStr);
//       int maxCode = 0;

//       if ((maxAutoCodeLocal ?? 0) > (maxAutoCode ?? 0)) {
//         maxCode = (maxAutoCodeLocal ?? 0) + 1;
//       } else {
//         maxCode = (maxAutoCode ?? 0) + 1;
//       }

//       String query = """
//   INSERT INTO ODairyRegister (
//     AutoId, LocationCode, LastCanNo, LastCanLiter, CompanyCode, EntryDate, Session, Category,
//     PurchaseMilkMembers, PurchaseMilkWeight, PurchaseMilkFat, PurchaseMilkSNF, PurchaseMilkAmount, isSync
//   ) VALUES (
//     '$maxCode', '$locationCode', '1', '10', '1', '$strDate', '$strSession', 'B',
//     '${milkCollectionBuff?.memCode}', '${milkCollectionBuff?.liters}',
//     '${milkCollectionBuff?.fat}', '${milkCollectionBuff?.snf}',
//     '${milkCollectionBuff?.amount}', '0'
//   )
// """;
//       await DBHelper().executeRawQuery(query);
//     }
//   }

//   callPriceAndPrint() async {
//     int? maxAutoID =
//         await StorageService().getInt(AppConstants.autoIDMilkCollectionPR);

//     if (maxAutoID == 0) {
//       await controller.getLastCollectionID(context);
//     }
//     maxAutoID =
//     await StorageService().getInt(AppConstants.autoIDMilkCollectionPR);

//     String maxautoIDLocaldb = Utils.replaceNullZero(await controller.dbHelper
//         .getScalarQueryStringFromDB("SELECT Max(AutoID) FROM MilkCollection"));
//     print("maxautoIDLocaldb ------> $maxautoIDLocaldb");

//     int maxAutoIDLocal = int.parse("${maxautoIDLocaldb ?? "0"}");

//     if (maxAutoIDLocal > maxAutoID) {
//       autoID = "${maxAutoIDLocal + 1}";
//     } else {
//       autoID = "${maxAutoID + 1}";
//     }
//     if (session == "Morning") {
//       strSession = "M";
//     } else if (session == "Evening") {
//       strSession = "E";
//     }

//     if (strSession.toLowerCase() == "m") {
//       /*String query = "SELECT Max() FROM MilkCollection "
//           "WHERE CollSession = 'M' AND CollDate = '$strDate' "
//           "AND Locked <> '1'";*/
//       String query = '''
//   SELECT IFNULL(count(SampleNo), 0) + 1 AS NextSampleNo
//   FROM MilkCollection
//   WHERE CollSession = 'M' AND CollDate = '$strDate'
// ''';



//       Entry = int.tryParse(Utils.replaceNullZero(
//           await DBHelper().getScalarQueryStringFromDB(query)))!;

//       print("-------------> Sample no entry Morning");
//       print(Entry);
//     } else if (strSession.toLowerCase() == "e") {
//      /* String query = "SELECT Max() FROM MilkCollection "
//           "WHERE CollSession = 'E' AND CollDate = '$strDate' "
//           "AND Locked <> '1'";*/
//       String query = '''
//   SELECT IFNULL(count(SampleNo), 0) + 1 AS NextSampleNo
//   FROM MilkCollection
//   WHERE CollSession = 'E' AND CollDate = '$strDate'
// ''';


//       Entry = int.tryParse(Utils.replaceNullZero(
//           await DBHelper().getScalarQueryStringFromDB(query)))!;
//       print("-------------> Sample no entry Evening");
//       print(Entry);
//     }

//    // Entry = Entry + 1;
//     print("-------------> Sample no entry");
//     print(Entry);

//     code = int.parse(Utils.replaceNullZero(await controller.dbHelper
//         .getScalarQueryStringFromDB("SELECT Max(Code) FROM MilkCollection")));
//     strCattleType = controller.selectedAnimal.value.contains("Cow") ? "C" : "B";
//     String query = "";

//     ///check here for isupdate
//     if (isUpdate == 0) {
//       query =
//           "INSERT INTO MilkCollection (AutoID,CollDate, CollTime, CollSession, MemCode, Cattle, "
//           "Liters, LitersEntryType, FAT, SNF, CLR, FAT_SNF_EntryType, "
//           "Rate, Amount, Amount_Type, ReceiptPrinted, SentStatus, "
//           "SentOn, UploadStatus, UploadOn, IsSync,SampleNo , VoucherNo, "
//           "IsUpdate, MemName, KgFatRate, Payment_Type, Locked, KgFat, "
//           "KgSnf, OldWeight, OldFat, OldSNF, OldAmount,transactiontype) VALUES ('"
//           "$autoID','$strDate', '$strTime', '$strSession', '${Formatter.m4d(strMemberCodeValue)}', '$strCattleType', '$strLiter', "
//           "$intLitersEntryType, '$strFat', '${Formatter.m1d(strSnf)}', '$strClr', $intFAT_SNF_EntryType, "
//           "'$strRate', '$strAmount', $intAmount_Type, '0', '0', "
//           "'0', '0', '0', '0','$Entry', '${strSession + strCattleType}', "
//           "'0', '$memberFName', '$strKgRate', '${mSettingsRate?.paymentType}', '0', "
//           "'${Formatter.multi(strFat, strLiter)}', '${Formatter.multi(strSnf, strLiter)}', '0', '0', '0', '0','PURM')";
//     } else if (isUpdate == 1) {
//       String query2 =
//           "UPDATE MilkCollection SET Locked = '1' WHERE Code = '$updatedCodeID'";
//       await DBHelper().executeRawQuery(query2);
//       autoID = updatedAutoID;
//       query = """
// INSERT INTO MilkCollection (
//   AutoID, CollDate, CollTime, CollSession, MemCode, Cattle,
//   Liters, LitersEntryType, FAT, SNF, CLR, FAT_SNF_EntryType,
//   Rate, Amount, Amount_Type, ReceiptPrinted, SentStatus,
//   SentOn, UploadStatus, UploadOn, IsSync,SampleNo, VoucherNo, IsUpdate, MemName,
//   KgFatRate, Payment_Type, Locked, IsUpdate,
//   KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount,transactiontype
// ) VALUES (
//   '$autoID', '$strDate', '$strTime', '$strSession', '${Formatter.m4d(strMemberCodeValue)}', '$strCattleType',
//   '$strLiter', '$intLitersEntryType', '$strFat', '${Formatter.m1d(strSnf)}', '$strClr', $intFAT_SNF_EntryType,
//   '$strRate', '$strAmount', $intAmount_Type, '0', '0',
//   '0', '0', '0', '0', '$Entry', '${strSession + strCattleType}', '$isUpdate', '$memberFName',
//   '$strKgRate', '${mSettingsRate?.paymentType}', '0', '1',
//   '${Formatter.multi(strFat, strLiter)}', '${Formatter.multi(strSnf, strLiter)}', 
//   '$oldWeight', '$oldFat', '$oldSnf', '$oldAmount','PURM'
// )
// """;
//     }

//     await controller.dbHelper.executeRawQuery(query);
//     // controller.isLoading.value=true;
//     // controller.isLoading.value=false;
//     showAutoDismissDialog(context,
//         locName: await controller.storageService
//             .getString(AppConstants.locationNamePr),
//         selectedCattle: controller.selectedAnimal.value,
//         fat: strFat,
//         amount: strAmount,
//         liters: strLiter,
//         memberName: "${memberFName}",
//         memberCode: "${strMemberCodeValue}",
//         rate: strRate,
//         snf: strSnf);

//     getPrefAndDBData();
//     clearForm();
//     _bluetoothService.resumeData();
//     await commonController.callPostMilkCollection(false);

//     //come here after
//   }

//   void showRateDialog(BuildContext context, VoidCallback callPriceAndPrint) {
//     Get.defaultDialog(
//       title: "Alert!!",
//       content: Text("Fat or SNF is low"),
//       barrierDismissible: false,
//       actions: [
//         /*    TextButton(
//           onPressed: () {
//             Navigator.of(Get.overlayContext!, rootNavigator: true)
//                 .pop(); //  Get.back();
//             callPriceAndPrint(); // Call function after accepting
//           },
//           child: Text("Accept"),
//         ),*/
//         TextButton(
//           onPressed: () {
//             Navigator.of(Get.overlayContext!, rootNavigator: true)
//                 .pop(); //  Get.back();
//             _bluetoothService.resumeData();
//           },
//           child: Text("Ok"),
//         ),
//       ],
//     );
//   }


//   void showAutoDismissDialog(
//     BuildContext context, {
//     required String locName,
//     required String memberName,
//     required String memberCode,
//     required String selectedCattle,
//     required String liters,
//     required String fat,
//     required String snf,
//     required String rate,
//     required String amount,
//   }) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         // Automatically dismiss the dialog after 3 seconds
//         /* Future.delayed(Duration(seconds: 3), () {
//           if (Navigator.canPop(context)) {
//             Navigator.pop(context);
//           }
//         });*/

//         return AlertDialog(

//           title: Text("Milk Collection Details"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("📍 Location: $locName"),
//               SizedBox(height: 8),
//               Text("👤 Member: $memberName ($memberCode)"),
//               SizedBox(height: 8),
//               Text("🐄 Cattle Type: $selectedCattle"),
//               SizedBox(height: 8),
//               Text("🥛 Liters: $liters"),
//               SizedBox(height: 8),
//               Text("💧 Fat: $fat%"),
//               SizedBox(height: 8),
//               Text("🔬 SNF: $snf%"),
//               SizedBox(height: 8),
//               Text("💰 Rate: ₹$rate"),
//               SizedBox(height: 8),
//               Text("🧾 Amount: ₹$amount",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 _bluetoothService.sendCommandToBLE(isCanSystem: true, memberId: memberCode, isBuffalo: selectedCattle=="Cow"?false:true, liter: liters, fat: fat, snf: snf);

//              /*   await _printerService.printMilkCollection(
//                    context: context,
//                   locName: locName,
//                   memberName: memberName,
//                   memberCode: memberCode,
//                   selectedCattle: selectedCattle,
//                   liters: liters,
//                   fat: fat,
//                   snf: snf,
//                   rate: rate,
//                   amount: amount,
//                 );*/



//                 await _printerService.printMilkCollectionText(
//                   locName: locName,
//                   memberName: memberName,
//                   memberCode: memberCode,
//                   selectedCattle: selectedCattle,
//                   liters: liters,
//                   fat: fat,
//                   snf: snf,
//                   rate: rate,
//                   amount: amount,
//                 );
//                 _bluetoothService.tryReconnectToLastDevice();

//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   FocusScope.of(context).requestFocus(memberFocus);
//                 });
//               },
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void clearForm() {
//     formKey.currentState?.reset();
//     controller.memberCodeController.text = "";
//     controller.memberName.value = "";
//     strMemberCodeValue = "";
//     memberFName = "";
//     controller.selectedAnimal.value = "Buffalo";
//   }

// /*  Future<bool> showBluetoothDeviceDialog(BuildContext context, BluetoothService service) async {
//     List<BluetoothDevice> devices = await service.getBondedDevices();

//     return await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Select Device"),
//           content: SizedBox(
//             height: 300,
//             width: double.maxFinite,
//             child: ListView.builder(
//               itemCount: devices.length,
//               itemBuilder: (context, index) {
//                 final device = devices[index];
//                 bool isConnected = service.connectedDevice?.address == device.address;

//                 return ListTile(
//                   title: Text(device.name ?? 'Unknown'),
//                   subtitle: Text(device.address),
//                   trailing: ElevatedButton(
//                     child: Text(isConnected ? "Disconnect" : "Connect"),
//                     onPressed: () async {
//                       if (isConnected) {
//                         service.disconnect();
//                         Navigator.pop(context, false);
//                       } else {
//                         await service.connectToDevice(device);
//                         Navigator.pop(context, true);
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     ).then((value) => value ?? false);
//   }*/
//   Future<bool> showBluetoothDeviceDialog(
//       BuildContext context, BluetoothService service) async {
//     List<serial.BluetoothDevice> devices = await service.getBondedDevices();
//     ValueNotifier<String?> connectingDevice = ValueNotifier(null);

//     return await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Select Bluetooth Device"),
//           content: SizedBox(
//             height: 350.sp,
//             width: double.maxFinite,
//             child: ValueListenableBuilder<String?>(
//               valueListenable: connectingDevice,
//               builder: (context, connectingAddress, _) {
//                 return ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: devices.length,
//                   itemBuilder: (context, index) {
//                     final device = devices[index];
//                     final isConnected =
//                         service.connectedDevice?.address == device.address;
//                     final isConnecting = connectingAddress == device.address;

//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: isConnected
//                             ? Colors.green.shade50
//                             : Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color:
//                               isConnected ? Colors.green : Colors.grey.shade400,
//                           width: 1.2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Device Info
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   device.name ?? 'Unknown',
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   softWrap: true,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   device.address,
//                                   style: const TextStyle(
//                                       fontSize: 12, color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Action Button
//                           isConnecting
//                               ? const SizedBox(
//                                   height: 28,
//                                   width: 28,
//                                   child:
//                                       CircularProgressIndicator(strokeWidth: 2),
//                                 )
//                               : ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: isConnected
//                                         ? Colors.redAccent
//                                         : Colors.blue,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 8),
//                                     textStyle: const TextStyle(fontSize: 12),
//                                   ),
//                                   child: Text(
//                                       isConnected ? "Disconnect" : "Connect"),
//                                   onPressed: () async {
//                                     if (isConnected) {
//                                       service.disconnect();
//                                       Navigator.pop(context, false);
//                                     } else {
//                                       connectingDevice.value = device.address;
//                                       await service.connectToDevice(device);
//                                       connectingDevice.value = null;
//                                       Navigator.pop(context, true);
//                                     }
//                                   },
//                                 ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     ).then((value) => value ?? false);
//   }



//   Future<bool> showBluetoothPrinterDialog(BuildContext context, BluetoothPrinterService printerService) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return BluetoothPrinterDialog(printerService: printerService);
//       },
//     ).then((value) => value ?? false);
//   }



// }

// class Formatter {
//   // M2S: Converts int to String, adding a leading space if less than 10
//   static String m2s(int value) {
//     return value < 10 ? " $value" : value.toString();
//   }

//   static String m1d(String str) {
//     if (str.startsWith(".")) {
//       str = "0$str";
//     }
//     return str;
//   }

//   static String m4d(String str) {
//     if (str.length == 1) {
//       str = "000$str";
//     } else if (str.length == 2) {
//       str = "00$str";
//     } else if (str.length == 3) {
//       str = "0$str";
//     } else if (str.length > 4) {
//       str = str.substring(0, 4);
//     }
//     return str;
//   }

//   // M2D: Formats a string number to two decimal places (rounding down)
//   static String m2d(String str) {
//     final number = double.tryParse(str) ?? 0.0;
//     final format = NumberFormat("#.00");
//     return format.format(number);
//   }

//   // M21D: Formats a string number to one decimal place (rounding down)
//   static String m21d(String str) {
//     final number = double.tryParse(str) ?? 0.0;
//     final format = NumberFormat("#.0");
//     return format.format(number);
//   }

//   static String multi(String? str1, String? str2) {
//     String data = "0";

//     try {
//       str1 = (str1 == null ||
//               str1.trim().isEmpty ||
//               str1.trim().toLowerCase() == "null")
//           ? "0"
//           : str1;
//       str2 = (str2 == null ||
//               str2.trim().isEmpty ||
//               str2.trim().toLowerCase() == "null")
//           ? "0"
//           : str2;

//       double result = double.parse(str1) * double.parse(str2);
//       NumberFormat formatter = NumberFormat("#.000");
//       data = formatter.format(result);
//     } catch (e) {
//       // Handle error if needed
//     }

//     return data;
//   }
// }

// class _SingleDecimalPointFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Allow only one '.' in the input
//     if (newValue.text.contains('.') &&
//         newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
//       return oldValue;
//     }
//     return newValue;
//   }
// }
