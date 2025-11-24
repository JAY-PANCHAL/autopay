// Flutter geofence screens implementation

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class GeofenceHomeScreen extends StatelessWidget {
  const GeofenceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text('Geofences'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GeofenceFormScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            color: Colors.grey,
            child: const Center(child: Text("MAP IMAGE PLACEHOLDER")),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Circular")),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: () {}, child: const Text("Polygon")),
            ],
          )
        ],
      ),
    );
  }
}

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
                    }),
                const Text("Circular"),
                Radio(
                    value: "polygon",
                    groupValue: type,
                    onChanged: (v) {
                      setState(() => type = v!);
                    }),
                const Text("Polygon"),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Search Location"),
              onSubmitted: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GeofenceMapScreen(
                          fenceType: type,
                          searchQuery: value,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GeofenceMapScreen extends StatefulWidget {
  final String fenceType;
  final String searchQuery;
  const GeofenceMapScreen(
      {super.key, required this.fenceType, required this.searchQuery});

  @override
  State<GeofenceMapScreen> createState() => _GeofenceMapScreenState();
}

class _GeofenceMapScreenState extends State<GeofenceMapScreen> {
  GoogleMapController? mapController;
  LatLng? markerPos;
  double radius = 200;
  final List<LatLng> polygonPoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 4),
            onMapCreated: (c) => mapController = c,
            onTap: (pos) {
              setState(() {
                if (widget.fenceType == "circular") {
                  markerPos = pos;
                } else {
                  polygonPoints.add(pos);
                }
              });
            },
            markers: markerPos != null
                ? {Marker(markerId: MarkerId("m1"), position: markerPos!)}
                : {},
            circles: widget.fenceType == "circular" && markerPos != null
                ? {
              Circle(
                  circleId: const CircleId("c1"),
                  center: markerPos!,
                  radius: radius,
                  fillColor: Colors.blue.withOpacity(0.3),
                  strokeColor: Colors.blue,
                  strokeWidth: 2)
            }
                : {},
            polygons: widget.fenceType == "polygon"
                ? {
              Polygon(
                  polygonId: const PolygonId("p1"),
                  points: polygonPoints,
                  fillColor: Colors.green.withOpacity(0.3),
                  strokeColor: Colors.green,
                  strokeWidth: 3)
            }
                : {},
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (widget.fenceType == "circular") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() => radius -= 50);
                          },
                          icon: const Icon(Icons.remove_circle)),
                      Text("Radius: ${radius.toStringAsFixed(0)} m"),
                      IconButton(
                          onPressed: () {
                            setState(() => radius += 50);
                          },
                          icon: const Icon(Icons.add_circle)),
                    ],
                  ),
                ],
                ElevatedButton(
                    onPressed: () {}, child: const Text("Save Geofence"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
