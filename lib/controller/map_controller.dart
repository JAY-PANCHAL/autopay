import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// --- CONTROLLER ---
class MapController extends BaseController {
  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  RxSet<Marker> markers = <Marker>{}.obs;

  // Default icon path
  RxString selectedIconPath = 'assets/icons/car.png'.obs;

  // List of available icons to pick
  final List<String> availableIcons = [
    'assets/icons/car.png',
    'assets/icons/truck.png',
    'assets/icons/satellite.png',
  ];

  // Called when user selects a new icon
  void changeMarkerIcon(String path) {
    selectedIconPath.value = path;
    _updateMarkersWithNewIcon();
  }

  // Initial map position
  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(22.9734, 78.6569), // Center of India
    zoom: 5.5,
  );

  // Initialize with static markers
  @override
  void onInit() {
    super.onInit();
    _loadStaticMarkers();
  }

  // Create some static markers
  Future<void> _loadStaticMarkers() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      selectedIconPath.value,
    );

    final staticPositions = [
      const LatLng(28.6139, 77.2090), // Delhi
      const LatLng(26.9124, 75.7873), // Jaipur
      const LatLng(19.0760, 72.8777), // Mumbai
      const LatLng(13.0827, 80.2707), // Chennai
    ];

    final newMarkers = staticPositions.asMap().entries.map(
          (entry) {
        int index = entry.key;
        LatLng pos = entry.value;
        return Marker(
          markerId: MarkerId('marker_$index'),
          position: pos,
          icon: icon,
          infoWindow: InfoWindow(title: "12345343.43434"),
        );
      },
    );

    markers.value = newMarkers.toSet();
  }

  // Rebuild all markers with new icon
  Future<void> _updateMarkersWithNewIcon() async {
    BitmapDescriptor newIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      selectedIconPath.value,
    );

    markers.value = markers.map((m) {
      return m.copyWith(iconParam: newIcon);
    }).toSet();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
  }
}
