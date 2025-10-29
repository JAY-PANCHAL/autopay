// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../main.dart';

// class BluetoothService {
//   BluetoothConnection? _connection;
//   final StreamController<String> _dataStreamController =
//       StreamController<String>.broadcast();
//   final StreamController<BluetoothDevice?> _connectionStatusController =
//       StreamController<BluetoothDevice?>.broadcast();
//   bool _isPaused = false;
//   Timer? _connectionMonitorTimer;

//   BluetoothDevice? connectedDevice;
//   String _messageBuffer = '';

//   Stream<String> get onDataReceived => _dataStreamController.stream;

//   Stream<BluetoothDevice?> get onConnectionStatusChanged =>
//       _connectionStatusController.stream;

//   Future<bool> initializeBluetooth() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.bluetooth,
//       Permission.bluetoothConnect,
//       Permission.bluetoothScan,
//       Permission.locationWhenInUse,
//     ].request();

//     if (!statuses.values.every((status) => status.isGranted)) {
//       bool permanentlyDenied =
//           statuses.values.any((status) => status.isPermanentlyDenied);

//       if (permanentlyDenied) {
//         _showPermissionDialog();
//       } else {
//         Fluttertoast.showToast(msg: "Permissions not granted");
//         await initializeBluetooth(); // Retry
//         startConnectionMonitor(); // 🔄 Begin monitoring

//       }
//       return false;
//     }

//     bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
//     if (!isEnabled!) {
//       await FlutterBluetoothSerial.instance.requestEnable();
//     }

//     return true;
//   }

//   Future<void> _saveLastConnectedDevice(String address) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('last_device_address', address);
//   }

//   void pauseData() {
//     _isPaused = true;
//     print("⏸ Data stream paused");
//   }

//   void resumeData() {
//     _isPaused = false;
//     print("▶️ Data stream resumed");
//   }

//   void _showPermissionDialog() {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       builder: (context) => AlertDialog(
//         title: const Text('Permissions Required'),
//         content: const Text(
//             'Bluetooth permissions are required to use this feature. Please enable them in settings.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               openAppSettings();
//               Navigator.pop(context);
//             },
//             child: const Text('Go to Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> tryReconnectToLastDevice() async {
//     // 🔄 Already connected? Skip reconnect
//     if (_connection != null && _connection!.isConnected) {
//       print("🔌 Already connected to a device, skipping reconnect.");
//       return;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     final lastAddress = prefs.getString('last_device_address');

//     if (lastAddress != null) {
//       List<BluetoothDevice> bonded = await getBondedDevices();
//       BluetoothDevice? device;

//       try {
//         device = bonded.firstWhere((d) => d.address == lastAddress);
//       } catch (_) {
//         device = null;
//       }

//       if (device != null) {
//         Fluttertoast.showToast(msg: "Connecting to ${device.name}...");
//         await connectToDevice(device);
//       } else {
//         print("⚠️ Previously connected device not found in bonded list.");
//       }
//     } else {
//       print("ℹ️ No saved device address to reconnect.");
//     }
//   }

//   Future<List<BluetoothDevice>> getBondedDevices() async {
//     return await FlutterBluetoothSerial.instance.getBondedDevices();
//   }

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       _connection = await BluetoothConnection.toAddress(device.address);
//       connectedDevice = device;
//       _connectionStatusController.add(device);
//       Fluttertoast.showToast(msg: "Connected to ${device.name}");
//       print("Connected to ${device.name}");
//       await _saveLastConnectedDevice(device.address);

//       _connection!.input!.listen((Uint8List data) {
//         _handleData(data);
//       }).onDone(() {
//         disconnect();
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Connection failed: $e");
//     }
//   }

// /*
//   void _handleData(Uint8List data) {
//     final incoming = String.fromCharCodes(data);
//    // print("📥 Received Raw: $incoming");

//     _messageBuffer += incoming;
//    // print("📥 Received _messageBuffer: $_messageBuffer");
//     if (_messageBuffer.endsWith('B')) {
//       print("✅ Full Message: $_messageBuffer");
//       _dataStreamController.add(_messageBuffer);
//       _messageBuffer = '';
//     }
//   }
// */

// /*
//   void _handleData(Uint8List data) {
//     final incoming = String.fromCharCodes(data);
//     _messageBuffer += incoming;


//   //  print("📥 Raw Buffer: $_messageBuffer");

//     final trimmedBuffer = _messageBuffer.trim();

//     if (trimmedBuffer.endsWith('B')) {
//       //print("✅ Full Message: $trimmedBuffer");

//       if (!_isPaused) {
//       //  print("✅ Full Message: $_messageBuffer");
//         _dataStreamController.add(trimmedBuffer);
//       } else {
//         print("⏸ Message received but paused: $_messageBuffer");
//       }
//       _messageBuffer = '';
//     }
//   }
// */

//   void _handleData(Uint8List data) {
//     final incoming = String.fromCharCodes(data);
//     print("------->${incoming}");
//     _messageBuffer += incoming;

//     final trimmedBuffer = _messageBuffer.trim();

//     if (trimmedBuffer.endsWith('B') ||
//         trimmedBuffer.endsWith('M') ||
//         trimmedBuffer.endsWith('C')) {
//       print("${_isPaused}");
//       if (!_isPaused) {
//         _dataStreamController.add(trimmedBuffer);
//       } else {
//         print("⏸ Message received but paused: $_messageBuffer");
//       }
//       _messageBuffer = '';
//     }
//   }

//   void disconnect() {
//     if (_connection != null && _connection!.isConnected) {
//       _connection!.dispose();
//       Fluttertoast.showToast(msg: "Disconnected from ${connectedDevice?.name}");
//     }
//     _connectionMonitorTimer?.cancel();

//     connectedDevice = null;
//     _connectionStatusController.add(null);
//   }

//   void dispose() {
//     _dataStreamController.close();
//     _connectionStatusController.close();
//     disconnect();
//   }

//   /// ✅ NEW METHOD TO SEND COMMAND TO BLE SYSTEM
// /*  void sendCommandToBLE({
//     required bool isCanSystem, // true = CAN (T), false = PAVALI (X)
//     required String memberId,  // e.g. "1234"
//     required bool isBuffalo,   // true = B, false = C
//     required String liter,     // e.g. "5678"
//     required String fat,       // e.g. "0650"
//     required String snf,       // e.g. "0890"
//   }) {
//     if (_connection == null || !_connection!.isConnected) {
//       Fluttertoast.showToast(msg: "❌ Not connected to any device");
//       return;
//     }

//     String startChar = isCanSystem ? 'T' : 'X';
//     String animalChar = isBuffalo ? 'B' : 'C';
//     String filler = '000123456123456'; // Reserved filler
//     String command = '$startChar\$\$%$memberId$animalChar$liter$fat$snf$filler#13';

//     _connection!.output.add(Uint8List.fromList(command.codeUnits));
//     _connection!.output.allSent;

//     print("📤 Sent Command: $command");
//     Fluttertoast.showToast(msg: "📤 Command sent to BLE");
//   }*/

//   void sendCommandToBLE({
//     required bool isCanSystem, // true = CAN (T), false = PAVALI (X)
//     required String memberId, // e.g. "1234"
//     required bool isBuffalo, // true = B, false = C
//     required String liter, // e.g. "5678"
//     required String fat, // e.g. "06.50" or "6.5"
//     required String snf, // e.g. "08.90" or "8.9"
//   }) {
//     if (_connection == null || !_connection!.isConnected) {
//       Fluttertoast.showToast(msg: "❌ Not connected to any device");
//       return;
//     }

//     // Remove dot from fat and snf
//     String fatCleaned = fat.replaceAll('.', '').padLeft(4, '0');
//     String snfCleaned = snf.replaceAll('.', '').padLeft(4, '0');
//     String literCleaned = liter.replaceAll('.', '').padLeft(5, '0');

//     // Construct the string
//     String systemChar = isCanSystem ? "T" : "X";
//     String animalChar = isBuffalo ? "B" : "C";

//     String command =
//         "$systemChar\$\$%$memberId$animalChar$literCleaned$fatCleaned$snfCleaned" +
//             "000123456123456#13";

//     // Send to BLE
//     _connection!.output.add(Uint8List.fromList(command.codeUnits));
//     _connection!.output.allSent;

//     print("✅✅✅✅✅✅ Sent Command: $command✅✅✅✅✅✅");
//   }




//   void startConnectionMonitor({Duration interval = const Duration(seconds: 2)}) {
//     _connectionMonitorTimer?.cancel(); // Prevent multiple timers

//     _connectionMonitorTimer = Timer.periodic(interval, (timer) {
//       if (_connection == null || !_connection!.isConnected) {
//         if (connectedDevice != null) {
//           Fluttertoast.showToast(
//             msg: "⚠️ Disconnected from ${connectedDevice?.name}",
//             toastLength: Toast.LENGTH_LONG,
//           );
//           _connectionStatusController.add(null);
//           connectedDevice = null;
//           tryReconnectToLastDevice();
//         }
//       }
//     });

//     print("📡 Bluetooth connection monitor started");
//   }
// }
