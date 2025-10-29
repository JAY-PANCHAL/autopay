// import 'package:aasaan_flutter/bluetooth/printer_service.dart';
// import 'package:flutter/material.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';

// import '../common/utils/utility.dart';

// class BluetoothPrinterScreen extends StatefulWidget {
//   @override
//   _BluetoothPrinterScreenState createState() => _BluetoothPrinterScreenState();
// }

// class _BluetoothPrinterScreenState extends State<BluetoothPrinterScreen> {
//   final BluetoothPrinterService _printerService = BluetoothPrinterService();
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _selectedDevice;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadDevices();
//   }

//   Future<void> _loadDevices() async {
//     bool isOn = await _printerService.isBluetoothOn();
//     if (!isOn) {
//       Utils.showToast("Please turn on Bluetooth");
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       List<BluetoothDevice> devices = await _printerService.getBondedDevices();
//       setState(() {
//         _devices = devices;
//         _isLoading = false;
//       });

//       if (devices.isEmpty) {
//         Utils.showToast("No bonded printers found");
//       }
//     } catch (e) {
//       Utils.showToast("Error loading printers: $e");
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _printNow() async {
//     if (_selectedDevice == null) {
//       Utils.showToast("Please select a printer");
//       return;
//     }

//     try {
//       await _printerService.connectToPrinter(_selectedDevice!);
//      /* await _printerService.printSampleData(
//         "AASAAN PRINT",
//         "🗓️ Date: ${DateTime.now()}\n🥛 Milk: 50L\n💰 Amount: ₹1500\n🙏 Thank you!",
//       );*/
//       Utils.showToast("Printed successfully ✅");
//     } catch (e) {
//       Utils.showToast("Failed to print: $e ❌");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bluetooth Printing"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _devices.isEmpty
//           ? Center(child: Text("No Bluetooth printers found."))
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (context, index) {
//                 final device = _devices[index];
//                 return ListTile(
//                   title: Text(device.name ?? "Unknown"),
//                   subtitle: Text(device.address ?? ""),
//                   trailing: Radio<BluetoothDevice>(
//                     value: device,
//                     groupValue: _selectedDevice,
//                     onChanged: (BluetoothDevice? value) {
//                       setState(() {
//                         _selectedDevice = value;
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton.icon(
//               onPressed: _printNow,
//               icon: Icon(Icons.print),
//               label: Text("Print Receipt"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 textStyle: TextStyle(fontSize: 18),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
