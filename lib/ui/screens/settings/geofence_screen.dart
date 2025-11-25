// Flutter geofence screens implementation

import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import 'package:get/get.dart';

class GeofenceHomeScreen extends StatefulWidget {
  const GeofenceHomeScreen({super.key});

  @override
  State<GeofenceHomeScreen> createState() => _GeofenceHomeScreenState();
}

class _GeofenceHomeScreenState extends State<GeofenceHomeScreen> {
  final FenceTypeController controller = Get.put(FenceTypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightBlue1, // Start color (lighter)
              AppColors.lightBlue2, // Middle color
              AppColors.white, // End color (can be adjusted for more blue)
            ],
            stops: [0.1, 0.5, 0.9], // Adjust stops for gradient distribution
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: Column(
              children: [


                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'GeoFences',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                Container(
                  height: 260,
                  color: Colors.grey,
                  child: const Center(child: Text("MAP IMAGE PLACEHOLDER")),
                ),
                const SizedBox(height: 20),
                fenceToggleSwitch()
              /*  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("Circular")),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: () {}, child: const Text("Polygon")),
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget fenceToggleSwitch() {
    return Obx(() {
      return Container(
        height: 45,
        width: 260,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF7FB), // light gradient-like bg
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            // Sliding Background
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: controller.isCircular.value
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F89B3), // blue selected bg
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Buttons Layer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: controller.selectCircular,
                    child: Center(
                      child: Text(
                        "Circular",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: controller.isCircular.value
                              ? Colors.white
                              : const Color(0xFF2F89B3),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.selectPolygon,
                    child: Center(
                      child: Text(
                        "Polygon",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: controller.isCircular.value
                              ? const Color(0xFF2F89B3)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}



class FenceTypeController extends BaseController {
  var isCircular = true.obs;

  void selectCircular() => isCircular.value = true;
  void selectPolygon() => isCircular.value = false;
}





