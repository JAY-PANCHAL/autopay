import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class GeofenceFormScreen extends StatefulWidget {
  const GeofenceFormScreen({super.key});

  @override
  State<GeofenceFormScreen> createState() => _GeofenceFormScreenState();
}

class _GeofenceFormScreenState extends State<GeofenceFormScreen> {
  String type = "circular";
  final nameController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Geofence")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Fence Name"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Radio(
                  value: "circular",
                  groupValue: type,
                  onChanged: (v) {
                    setState(() => type = v!);
                  },
                ),
                const Text("Circular"),
                Radio(
                  value: "polygon",
                  groupValue: type,
                  onChanged: (v) {
                    setState(() => type = v!);
                  },
                ),
                const Text("Polygon"),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Search Location"),
              onSubmitted: (value) {
                Get.toNamed(
                  Routes.geofenceMapScreen,
                  arguments: {'fenceType': type, 'searchQuery': value},
                );

                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GeofenceMapScreen(fenceType: type, searchQuery: value),
                  ),
                );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
