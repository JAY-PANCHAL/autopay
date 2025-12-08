import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../controller/vehicle_details_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// VehicleMapScreen.dart
///
/// Full screen with draggable bottom sheet and a Syncfusion gauge.
/// Replace placeholder map and icons with your real map widget and icons.

class VehicleMapScreen extends StatefulWidget {
  const VehicleMapScreen({super.key});

  @override
  State<VehicleMapScreen> createState() => _VehicleMapScreenState();
}

class _VehicleMapScreenState extends State<VehicleMapScreen> {
  final VehicleMapController controller = VehicleMapController();

  /// sheet controller is provided by draggable sheet via notification
  double sheetExtent = 0.25; // current extent (0..1) approximate

  @override
  void initState() {
    super.initState();
    controller.initSampleData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // top-right quick action buttons
  Widget _buildRightQuickActions() {
    final icons = <IconData>[
      Icons.map, // placeholder
      Icons.lock,
      Icons.camera_alt,
      Icons.person,
      Icons.add,
      Icons.remove,
    ];

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: icons
              .map(
                (ic) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        // replace with your action
                        debugPrint('Tapped quick action $ic');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(ic, color: Colors.brown, size: 22),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // compact card (shown when sheet is collapsed)
  Widget _buildCompactCard() {
    final v = controller.data;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          // vehicle icon and no
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_car, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.vehicleNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(v.location, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),

          // Gauge (small)
          SizedBox(
            width: 80,
            height: 80,
            child: _buildGauge(v.speed, small: true),
          ),
          const SizedBox(width: 8),

          // KM
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.speed, color: Colors.brown),
              const SizedBox(height: 4),
              Text(
                "${v.todayKm.toStringAsFixed(2)} km",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // big content when expanded
  Widget _buildExpandedContent(double maxHeight) {
    final v = controller.data;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        children: [
          // small handle
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 12),

          // top row: vehicle + gauge + km
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.directions_car, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      v.vehicleNo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      v.location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(width: 120, height: 120, child: _buildGauge(v.speed)),
            ],
          ),

          const SizedBox(height: 12),
          // Odometer / icons row
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                children: [
                  // odometer & small icons
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Odometer",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: v.odometerDigits
                                .map(
                                  (d) => Container(
                                    margin: const EdgeInsets.only(right: 6.0),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      d,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Today KM",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${v.todayKm.toStringAsFixed(2)} km",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // location row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.brown),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          v.location,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // stats tiles
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _smallInfoTile("Battery", "100%"),
                _smallInfoTile("Engine", "00:00"),
                _smallInfoTile("Car Battery", "0V"),
                _smallInfoTile("Satellite", "N/A"),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // timeline and summary - example simplified
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // small chart placeholder
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Center(child: Icon(Icons.bar_chart)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "36.32 km",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Running 01:19:07 hrs • Stop 01:19:07 hrs",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // action icons grid (simplified)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(8, (i) {
              return _actionTile("Action ${i + 1}");
            }),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _smallInfoTile(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(String title) {
    return SizedBox(
      width: 84,
      child: Column(
        children: [
          Material(
            color: Colors.brown.shade100,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                debugPrint('Action $title');
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.touch_app, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // gauge builder using syncfusion package
  Widget _buildGauge(double speed, {bool small = false}) {
    final needleSize = small ? 0.5 : 0.8;
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 140,
          showTicks: false,
          showLabels: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.12,
            cornerStyle: CornerStyle.bothFlat,
          ),
          pointers: <GaugePointer>[
            NeedlePointer(
              value: speed,
              needleLength: 0.7 * needleSize,
              needleStartWidth: 1,
              needleEndWidth: 4,
              knobStyle: const KnobStyle(knobRadius: 0.04),
            ),
          ],
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.green.withOpacity(0.7),
            ),
            GaugeRange(
              startValue: 50,
              endValue: 90,
              color: Colors.orange.withOpacity(0.8),
            ),
            GaugeRange(
              startValue: 90,
              endValue: 140,
              color: Colors.red.withOpacity(0.9),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // full screen overlay
      body: Stack(
        children: [
          // map placeholder - replace with GoogleMap or your Map widget
          Positioned.fill(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: controller.initialPosition,
              onMapCreated: controller.onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),

          // rightside quick actions
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 0.18,
            child: _buildRightQuickActions(),
          ),

          // Draggable bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.12,
            maxChildSize: 0.86,
            builder: (context, scrollController) {
              // We'll use sheetExtent approximated by scrollController positions, for UI adjustments
              // But for simplicity we avoid direct listening; design handles both states
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  // update sheetExtent if needed
                  // ignore: avoid_print
                  //print('notif ${notification.metrics.pixels}');
                  return false;
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        // When sheet is collapsed we show compact card-ish header (mimics screenshot)
                        const SizedBox(height: 8),
                        _buildCompactCard(),
                        const SizedBox(height: 12),
                        // Expanded area content - put inside a container so it appears white and rounded
                        _buildExpandedContent(
                          MediaQuery.of(context).size.height * 0.7,
                        ),
                        // add some bottom padding to allow full expansion space
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Simple data model for demo
class VehicleData {
  final String vehicleNo;
  final double speed;
  final double todayKm;
  final String location;
  final List<String> odometerDigits;

  VehicleData({
    required this.vehicleNo,
    required this.speed,
    required this.todayKm,
    required this.location,
    required this.odometerDigits,
  });
}
