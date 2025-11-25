import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';

class GeofenceMapScreen extends StatefulWidget {
  const GeofenceMapScreen({super.key});

  @override
  State<GeofenceMapScreen> createState() => _GeofenceMapScreenState();
}

class _GeofenceMapScreenState extends State<GeofenceMapScreen> {
  GoogleMapController? mapController;
  LatLng? markerPos;
  double radius = 200;
  final List<LatLng> polygonPoints = [];
  String fenceType ="";
      String searchQuery="";
  @override
  void initState() {
    final args = Get.arguments;

   fenceType = args['fenceType'];
   searchQuery = args['searchQuery'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(20.5937, 78.9629),
              zoom: 4,
            ),
            onMapCreated: (c) => mapController = c,
            onTap: (pos) {
              setState(() {
                if (fenceType == "circular") {
                  markerPos = pos;
                } else {
                  polygonPoints.add(pos);
                }
              });
            },
            markers: markerPos != null
                ? {Marker(markerId: MarkerId("m1"), position: markerPos!)}
                : {},
            circles:fenceType == "circular" && markerPos != null
                ? {
                    Circle(
                      circleId: const CircleId("c1"),
                      center: markerPos!,
                      radius: radius,
                      fillColor: Colors.blue.withOpacity(0.3),
                      strokeColor: Colors.blue,
                      strokeWidth: 2,
                    ),
                  }
                : {},
            polygons:fenceType == "polygon"
                ? {
                    Polygon(
                      polygonId: const PolygonId("p1"),
                      points: polygonPoints,
                      fillColor: Colors.green.withOpacity(0.3),
                      strokeColor: Colors.green,
                      strokeWidth: 3,
                    ),
                  }
                : {},
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (fenceType == "circular") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => radius -= 50);
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text("Radius: ${radius.toStringAsFixed(0)} m"),
                      IconButton(
                        onPressed: () {
                          setState(() => radius += 50);
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ],
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save Geofence"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
