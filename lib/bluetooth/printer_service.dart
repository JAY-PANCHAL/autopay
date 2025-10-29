import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class BluetoothPrinterService {
  final BlueThermalPrinter _printer = BlueThermalPrinter.instance;
  static const String _lastDeviceKey = 'last_connected_printer';
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<bool> isBluetoothOn() async {
    return await _printer.isOn ?? false;
  }

  Future<List<BluetoothDevice>> getBondedDevices() async {
    return await _printer.getBondedDevices();
  }

  Future<void> connectToPrinter(BluetoothDevice device) async {
    if ((await _printer.isConnected) ?? false) return;
    await _printer.connect(device);
    print("Connected to printer ${device.name}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastDeviceKey, device.address!);
  }

  Future<void> disconnect() async {
    if ((await _printer.isConnected) ?? false) {
      await _printer.disconnect();
    }
  }

  Future<String?> getLastConnectedDeviceAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastDeviceKey);
  }

  /*Future<void> printMilkCollection({
    required BuildContext context,
    required String locName,
    required String memberName,
    required String memberCode,
    required String selectedCattle,
    required String liters,
    required String fat,
    required String snf,
    required String rate,
    required String amount,
  }) async {
    bool? isConnected = await _printer.isConnected;
    if (isConnected != true) {
      throw Exception("Printer not connected");
    }

    final receiptWidget = _buildReceiptWidget(
      locName: locName,
      memberName: memberName,
      memberCode: memberCode,
      selectedCattle: selectedCattle,
      liters: liters,
      fat: fat,
      snf: snf,
      rate: rate,
      amount: amount,
    );

    final imageBytes = await _captureReceiptAsImage(context, receiptWidget);

    if (imageBytes != null) {
      // Prevent infinite printing by ensuring only one print job runs at a time
      try {
        // Start printing
        await _printer.printImageBytes(imageBytes);
        // Disconnect after printing to prevent multiple feeds
        await disconnect();
      } catch (e) {
        // Handle errors and avoid any retries
        print("Error while printing: $e");
      }
    }
  }

  Widget _buildReceiptWidget({
    required String locName,
    required String memberName,
    required String memberCode,
    required String selectedCattle,
    required String liters,
    required String fat,
    required String snf,
    required String rate,
    required String amount,
  }) {
    return Material(
      color: Colors.white,
      child: Container(
        width: 220, // width suitable for 2.2" printer (~384px at 1x)
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // tightly wrap content height
          children: [
            Center(
              child: Text(
                "MILK RECEIPT",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
            _textLine("Location", locName),
            _textLine("Member", "$memberName ($memberCode)"),
            _textLine("Cattle", selectedCattle),
            _textLine("Liters", liters),
            _textLine("Fat", "$fat%"),
            _textLine("SNF", "$snf%"),
            _textLine("Rate", "Rs. $rate"),
            Divider(height: 8),
            Center(
              child: Text(
                "Amount: Rs. $amount",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        "$label: $value",
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Future<Uint8List?> _captureReceiptAsImage(
      BuildContext context,
      Widget receiptWidget,
      ) async {
    // This version avoids extra padding or center alignment
    return await _screenshotController.captureFromWidget(
      receiptWidget,
      pixelRatio: 2.0,
    );
  }*/




  Future<void> printMilkCollection({
    required BuildContext context,
    required String locName,
    required String memberName,
    required String memberCode,
    required String selectedCattle,
    required String liters,
    required String fat,
    required String snf,
    required String rate,
    required String amount,
  }) async {
    bool? isConnected = await _printer.isConnected;
    if (isConnected != true) {
      throw Exception("Printer not connected");
    }

    final receiptWidget = _buildReceiptWidget(
      locName: locName,
      memberName: memberName,
      memberCode: memberCode,
      selectedCattle: selectedCattle,
      liters: liters,
      fat: fat,
      snf: snf,
      rate: rate,
      amount: amount,
    );

    final rawImage = await _captureReceiptAsImage(context, receiptWidget);

    if (rawImage != null) {
      final croppedImage = await _trimWhiteBottom(rawImage);

      try {
       await _printer.printImageBytes(croppedImage);
       await Future.delayed(Duration(milliseconds: 300));
       // Try reset & feed lines
       await _printer.writeBytes(Uint8List.fromList([
         27, 64, // ESC @ – Initialize
         27, 100, 3, // ESC d 3 – Feed 3 lines
         29, 86, 1, // GS V 1 – Partial cut
       ]));
      /*  await _printer.writeBytes(Uint8List.fromList([
          27, 64,        // Reset printer
          72, 101, 108, 108, 111, 10, // Print "Hello" and LF
        ]));*/

        // Short delay before disconnect
     //   await Future.delayed(Duration(milliseconds: 300));
        //await _printer.disconnect();
      } catch (e) {
        print("Printing error: $e");
      }
    }
  }

  Widget _buildReceiptWidget({
    required String locName,
    required String memberName,
    required String memberCode,
    required String selectedCattle,
    required String liters,
    required String fat,
    required String snf,
    required String rate,
    required String amount,
  }) {
    return Material(
      color: Colors.white,
      child: Container(
        width: 220, // 2.2" printer width (~384px at 1x)
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Wraps height to content
          children: [
            Center(
              child: Text(
                "MILK RECEIPT",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
            _textLine("Location", locName),
            _textLine("Member", "$memberName ($memberCode)"),
            _textLine("Cattle", selectedCattle),
            _textLine("Liters", liters),
            _textLine("Fat", "$fat%"),
            _textLine("SNF", "$snf%"),
            _textLine("Rate", "Rs. $rate"),
            Divider(height: 8),
            Center(
              child: Text(
                "Amount: Rs. $amount",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _textLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        "$label: $value",
        style: TextStyle(fontSize: 10),
      ),
    );
  }
  Future<Uint8List?> _captureReceiptAsImage(
      BuildContext context,
      Widget receiptWidget,
      ) async {
    return await _screenshotController.captureFromWidget(
      receiptWidget,
      pixelRatio: 1.4,
    );
  }

  Uint8List _trimWhiteBottom(Uint8List imageBytes) {
    final original = img.decodeImage(imageBytes);
    if (original == null) return imageBytes;

    final width = original.width;
    final height = original.height;

    int cropHeight = height;
    const threshold = 245;
    const maxHeight = 500; // force cutoff to 500px

    for (int y = height - 1; y >= 0; y--) {
      bool isWhiteRow = true;

      for (int x = 0; x < width; x++) {
        final pixel = original.getPixelSafe(x, y);

        if (pixel.a > 10 && (pixel.r < threshold || pixel.g < threshold || pixel.b < threshold)) {
          isWhiteRow = false;
          break;
        }
      }

      if (!isWhiteRow) {
        cropHeight = y + 1;
        break;
      }
    }

    // Enforce max height cap
    cropHeight = cropHeight.clamp(0, maxHeight);

    final cropped = img.copyCrop(
      original,
      x: 0,
      y: 0,
      width: width,
      height: cropHeight,
    );
    print("Image size: ${cropped.width}x${cropped.height}");

    return Uint8List.fromList(img.encodePng(cropped));
  }


  Future<void> printMilkCollectionText({
    required String locName,
    required String memberName,
    required String memberCode,
    required String selectedCattle,
    required String liters,
    required String fat,
    required String snf,
    required String rate,
    required String amount,
  }) async {
    bool? isConnected = await _printer.isConnected;
    if (isConnected != true) {
      throw Exception("Printer not connected");
    }

    try {
      List<int> bytes = [];

      // Initialize printer
      bytes += [27, 64]; // ESC @

      // Centered title
      bytes += [27, 97, 1]; // ESC a 1 (center)
      bytes += utf8.encode("MILK RECEIPT\n");

      // Left alignment
      bytes += [27, 97, 0]; // ESC a 0 (left)
      bytes += utf8.encode("Location : $locName\n");
      bytes += utf8.encode("Member   : $memberName ($memberCode)\n");
      bytes += utf8.encode("Cattle   : $selectedCattle\n");
      bytes += utf8.encode("Liters   : $liters\n");
      bytes += utf8.encode("Fat      : $fat%\n");
      bytes += utf8.encode("SNF      : $snf%\n");
      bytes += utf8.encode("Rate     : Rs. $rate\n");

      // Divider
      bytes += utf8.encode("-----------------------------\n");

      // Bold + centered total amount
      bytes += [27, 97, 1]; // ESC a 1 (center)
      bytes += [27, 69, 1]; // ESC E 1 (bold on)
      bytes += utf8.encode("Amount: Rs. $amount\n");
      bytes += [27, 69, 0]; // ESC E 0 (bold off)

      // Feed 3 lines
      bytes += [27, 100, 3]; // ESC d n

      // Partial cut (if supported)
      bytes += [29, 86, 1]; // GS V 1 (cut paper)

      await _printer.writeBytes(Uint8List.fromList(bytes));
    } catch (e) {
      print("Text mode printing error: $e");
    }
  }

}
