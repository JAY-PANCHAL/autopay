import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_constants.dart';
import '../../../controller/map_controller.dart';



// --- VIEW ---
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => Stack(
          children: [
            // Google Map
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              markers: controller.markers.value,
              initialCameraPosition: controller.initialPosition,
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),

            // Icon selection column (like in your screenshot)
            Positioned(
              right: 12,
              top: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconButton(Icons.filter_alt, "Filter", AppColors.appblue),
                  _buildIconButton(Icons.gps_fixed, "Locate", AppColors.appblue),
                  _buildIconButton(Icons.settings, "Config", AppColors.appblue),
                  _buildIconButton(Icons.refresh, "Refresh", AppColors.appblue),
                ],
              ),
            ),

            // Bottom-right icon selector
            Positioned(
              bottom: 25,
              right: 12,
              child: FloatingActionButton(
                backgroundColor: AppColors.appblue,
                child: const Icon(Icons.directions_car),
                onPressed: () => _showIconSelection(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Small floating icon button
  Widget _buildIconButton(IconData icon, String tooltip, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: CircleAvatar(
        radius: 22.sp,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }

  // Show dialog to choose marker icon
  void _showIconSelection(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select Marker Icon",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 16.w,
              runSpacing: 12.h,
              children: controller.availableIcons.map((path) {
                return GestureDetector(
                  onTap: () {
                    controller.changeMarkerIcon(path);
                    Get.back();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50.sp,
                        height: 50.sp,
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedIconPath.value == path
                                ? AppColors.appblue
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Image.asset(path, fit: BoxFit.contain),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
