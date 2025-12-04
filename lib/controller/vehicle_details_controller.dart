import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../ui/screens/vehicles/vehile_details_screen.dart';

class VehicleMapController extends GetxController {
  GoogleMapController? mapController;

  var initialPosition = const CameraPosition(
    target: LatLng(25.0926, 85.3131), // Your initial coordinates
    zoom: 14.5,
  );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  late VehicleData data;

  void initSampleData() {
    data = VehicleData(
      vehicleNo: "BR01JF1231",
      speed: 70,
      todayKm: 45.57,
      location:
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      odometerDigits: ["0", "0", "0", "0", "2", "3", "8", "1", "5"],
    );
  }
}
