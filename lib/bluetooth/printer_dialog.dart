// import 'package:aasaan_flutter/bluetooth/printer_service.dart';
// import 'package:flutter/material.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BluetoothPrinterDialog extends StatefulWidget {
//   final BluetoothPrinterService printerService;

//   const BluetoothPrinterDialog({required this.printerService, super.key});

//   @override
//   State<BluetoothPrinterDialog> createState() => _BluetoothPrinterDialogState();
// }

// class _BluetoothPrinterDialogState extends State<BluetoothPrinterDialog> {
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _selectedDevice;
//   bool _isConnected = false;
//   bool _loading = true;
//   String? _connectingAddress;

//   @override
//   void initState() {
//     super.initState();
//     _initializePrinter();
//   }

//   Future<void> _initializePrinter() async {
//     bool isOn = await widget.printerService.isBluetoothOn();
//     if (!isOn) {
//       Navigator.of(context).pop(false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("⚠️ Please turn on Bluetooth")),
//       );
//       return;
//     }

//     _devices = await widget.printerService.getBondedDevices();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? lastMac = prefs.getString('lastPrinterMac');

//     if (lastMac != null) {
//       BluetoothDevice? device = _devices.firstWhere(
//             (d) => d.address == lastMac,
//         orElse: () => BluetoothDevice('', ''),
//       );

//       if (device.address != '') {
//         _selectedDevice = device;
//         await widget.printerService.connectToPrinter(device);
//         _isConnected = true;
//       }
//     }

//     setState(() {
//       _loading = false;
//     });
//   }

//   Future<void> _toggleConnection(BluetoothDevice device) async {
//     setState(() {
//       _connectingAddress = device.address;
//     });

//     if (_isConnected && _selectedDevice?.address == device.address) {
//       await widget.printerService.disconnect();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.remove('lastPrinterMac');
//       _selectedDevice = null;
//       _isConnected = false;
//     } else {
//       await widget.printerService.connectToPrinter(device);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('lastPrinterMac', device.address ?? '');
//       _selectedDevice = device;
//       _isConnected = true;
//     }

//     setState(() {
//       _connectingAddress = null;
//     });

//     Navigator.pop(context, _isConnected);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Select Bluetooth Printer"),
//       content: _loading
//           ? const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()))
//           : SizedBox(
//         height: 350,
//         width: double.maxFinite,
//         child: _devices.isEmpty
//             ? const Center(child: Text("No paired devices found"))
//             : ListView.builder(
//           itemCount: _devices.length,
//           itemBuilder: (context, index) {
//             final device = _devices[index];
//             final isConnected = _selectedDevice?.address == device.address;
//             final isConnecting = _connectingAddress == device.address;

//             return Container(
//               margin: const EdgeInsets.symmetric(vertical: 6),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isConnected
//                     ? Colors.green.shade50
//                     : Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: isConnected ? Colors.green : Colors.grey.shade400,
//                   width: 1.2,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Device Info
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           device.name ?? 'Unknown',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           softWrap: true,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           device.address ?? '',
//                           style: const TextStyle(
//                               fontSize: 12, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Connect/Disconnect Button
//                   isConnecting
//                       ? const SizedBox(
//                     height: 28,
//                     width: 28,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                       : ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isConnected
//                           ? Colors.redAccent
//                           : Colors.blue,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 8),
//                       textStyle: const TextStyle(fontSize: 12),
//                     ),
//                     child: Text(isConnected ? "Disconnect" : "Connect"),
//                     onPressed: () => _toggleConnection(device),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
