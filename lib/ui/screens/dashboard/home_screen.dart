import 'package:autopay/common/utils/Styles.dart';
import 'package:autopay/common/utils/image_paths.dart';
import 'package:autopay/common/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../common/utils/color_constants.dart';
import '../../../controller/home_screen_controller.dart';
import '../../../routes/app_pages.dart'; // Import the new package

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(HomeScreenController());

    return Scaffold(
      body: Obx(() {
        return Container(
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
          child: RefreshIndicator(
            onRefresh: controller.fetchVehicleList,
            color: AppColors.primaryAppColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 16.0.sp),
                      child: Row(
                        children: [
                          Text(
                            "Vehicle List",
                            style: Styles.textFontRegular(size: 20, weight: FontWeight.w500)
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                Get.toNamed(Routes.notificationScreen);
                              },
                              child: Icon(Icons.notifications,color: AppColors.appblue,size: 25.sp,))
                        ],
                      ),
                    ),
                    // Horizontal Stats
                    _buildTopStats(controller),
                    SizedBox(height: 16.h),
                    // Vehicle Cards
                    ...controller.vehicleList
                        .map((vehicle) => _buildVehicleCard(vehicle))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // --- TOP STATS CODE (Unchanged) ---
  Widget _buildTopStats(HomeScreenController controller) {
    final stats = [
      {
        "label": "All vehicles",
        "value": controller.totalVehicles.toString(),
        "color": Colors.purple,
      },
      {
        "label": "Running",
        "value": controller.runningVehicles.toString(),
        "color": Colors.green,
      },
      {
        "label": "Idle",
        "value": controller.idleVehicles.toString(),
        "color": Colors.orange,
      },
      {
        "label": "Stopped",
        "value": controller.idleVehicles.toString(),
        "color": Colors.red,
      },
      {
        "label": "Expired",
        "value": controller.idleVehicles.toString(),
        "color": Colors.redAccent.shade200,
      },
      {
        "label": "Not Reporting",
        "value": controller.idleVehicles.toString(),
        "color": Colors.blue.shade300,
      },
      {
        "label": "No Data",
        "value": controller.idleVehicles.toString(),
        "color": Colors.grey,
      },
    ];

    return SizedBox(
      height: 110.sp, // adjust height to fit your box size
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: stats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return _buildStatBox(
            stat["label"] as String,
            stat["value"] as String,
            stat["color"] as Color,
          );
        },
      ),
    );
  }

  Widget _buildStatBox(String title, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 100.sp,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.sp,
            height: 30.sp,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.directions_car,
                color: AppColors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  // --- END TOP STATS CODE ---

  // --- REFACTORED VEHICLE CARD ---
  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    Color color = vehicle["color"] ?? Colors.brown;

    // Timeline data corresponding to the steps
    final List<Map<String, dynamic>> timelineData = [
      {
        "icon": Icons.directions_car,
        "text": vehicle["number"],
        "isHeader": true,
      },
      {
        "icon": Icons.directions_car,
        "text": vehicle["status"],
        "isHeader": false,
      },
      {
        "icon": Icons.access_time,
        "text": vehicle["lastUpdated"],
        "isHeader": false,
      },
      {
        "icon": Icons.location_on,
        "text": vehicle["address"],
        "isHeader": false,
        "isLast": true,
      },
    ];

    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.vehicleDetailsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 🚗 Vehicle image
                Column(
                  children: [
                    Image.asset(
                      vehicle["iconPath"],
                      width: 70.w,
                      height: 70.w,
                      fit: BoxFit.contain,
                    ),
                    Utils.addGap(30),
                    // Assuming a dark or colored background
                    Text(
                      "00",
                      style: Styles.textFontBold(
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "KMH",
                      style: Styles.textFontRegular(
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),

                // 📍 Timeline and details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // CrossAxisAlignment is critical here to align the top of the timeline
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- TIMELINE WIDGET ---
                      Timeline.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: timelineData.length,
                        // 🔑 FIX 1: Set Timeline padding to zero to eliminate default top/bottom padding
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final item = timelineData[index];
                          final isLast = index == timelineData.length - 1;
                          final isFirst = index == 0;

                          // --- 1. Define the Content (Text) ---
                          final content = Padding(
                            padding: EdgeInsets.only(
                              bottom: isLast ? 0 : 12.h,
                              left: 8.w,
                              // 🔑 FIX 2: Remove top padding from the first content item if desired
                              top: isFirst ? 0 : 0.h,
                            ),
                            child: Text(
                              item["text"],
                              textAlign: TextAlign.start,
                              style: item["isHeader"]
                                  ? TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    )
                                  : TextStyle(
                                      fontSize: 10.sp,

                                      color: Colors.black.withOpacity(0.8),
                                    ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );

                          // --- 2. Define the Node (Indicator and Connectors) ---
                          final timelineNode = TimelineNode(
                            indicator: _TimelineIndicator(
                              icon: item["icon"],
                              color: color,
                            ),
                            startConnector: isFirst
                                ? null
                                : SizedBox(
                                    height: 10.0.sp,
                                    child: DashedLineConnector(
                                      color: color,
                                      thickness: 1.5,
                                      gap: 6.0, // space between dashes
                                      dash: 6.0, // length of each dash
                                    ),
                                  ),
                            endConnector: isLast
                                ? null
                                : SizedBox(
                                    height: 10.0.sp,
                                    child: DashedLineConnector(
                                      color: color,
                                      thickness: 1.5,
                                      gap: 6.0, // space between dashes
                                      dash: 6.0, // length of each dash
                                    ),
                                  ),
                          );

                          // --- 3. Return the TimelineTile ---
                          return TimelineTile(
                            // 🔑 FIX 3: Remove default TimelineTile top and bottom padding
                            nodeAlign: TimelineNodeAlign.start,
                            // Set item extent to control vertical spacing, or keep it null
                            // to let content define height (preferred for wrapping text).

                            // You can try setting hasIndicator to false for the first item
                            // and placing the indicator manually inside contents, but
                            // for simplicity, we'll stick to TimelineTile structure.

                            // 🔑 FIX 4: Explicitly align the node/indicator to the start
                            // and ensure TimelineTile does not add its own default top/bottom margin.
                            // The main control is the Timeline.builder's padding: EdgeInsets.zero.

                            // The timeline component implicitly adds height. If the gap remains,
                            // you might need to manually set the vertical margin on the node itself.
                            node: timelineNode,
                            contents: content,
                          );
                        },
                      ),

                      // --- END TIMELINE WIDGET ---
                      SizedBox(height: 10.h),

                      // ⚙️ Action Icons Row
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Image.asset(
                    AppIcons.freeze,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    AppIcons.key,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    AppIcons.power,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    AppIcons.setellite,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    AppIcons.calendar,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    AppIcons.more,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Custom Indicator Widget (Replaces _circleIcon)
class _TimelineIndicator extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _TimelineIndicator({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.sp,
      height: 24.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Center(
        child: Icon(icon, size: 14.sp, color: Colors.white),
      ),
    );
  }
}
