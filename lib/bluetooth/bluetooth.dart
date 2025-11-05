/*
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothConnection? connection;
  List<BluetoothDevice> devicesList = [];
  bool isConnecting = true;
  bool isDisconnecting = false;
  String _messageBuffer = '';

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

 */
/* Future<void> _initBluetooth() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.locationWhenInUse.request();

    // Enable Bluetooth
    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (isEnabled == false) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    // Start discovering
    _discoverDevices();
  }*//*

  Future<void> _initBluetooth() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.locationWhenInUse,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      Fluttertoast.showToast(msg: "Permissions not granted");
      return;
    }

    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (isEnabled == false) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    _discoverDevices();
  }

  void _discoverDevices() async {
    devicesList.clear();
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devicesList.addAll(bondedDevices);
      });
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      print('Connected to ${device.name}');
      setState(() {
        isConnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to connect: $e");
    }
  }

  void _onDataReceived(Uint8List data) {
    String dataString = String.fromCharCodes(data);
    print("📥 Received Raw Data: $dataString");

   */
/* // Optional: Clean backspaces if needed (same logic)
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) backspacesCounter++;
    });

    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

   // String finalString = String.fromCharCodes(buffer);
    String finalString = String.fromCharCodes(data);
    _messageBuffer += finalString;
*//*

   // String finalString = String.fromCharCodes(buffer);
    String finalString = String.fromCharCodes(data);
    _messageBuffer += dataString;
    print("message buffer ---> $_messageBuffer");
    // Check if it ends with 'B' => Message complete
    if (_messageBuffer.endsWith('B')) {
      print("✅ Full Message Received: $_messageBuffer");

      // Optionally: Do something with the full message here

      // Clear buffer for next message
      _messageBuffer = '';
    }
  }


  @override
  void dispose() {
    if (connection != null && connection!.isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Devices"),
      ),
      body: devicesList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = devicesList[index];
          return ListTile(
            title: Text(device.name ?? "Unknown"),
            subtitle: Text(device.address),
            onTap: () => _connectToDevice(device),
          );
        },
      ),
    );
  }
}
*/
