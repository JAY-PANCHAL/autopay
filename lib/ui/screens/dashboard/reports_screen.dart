import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/color_constants.dart';
import '../../../routes/app_pages.dart';
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reports = [
      {"title": "Ignition Report", "icon": Icons.vpn_key},
      {"title": "AC Report", "icon": Icons.ac_unit},
      {"title": "Trip Report", "icon": Icons.map},
      {"title": "Stoppage Report", "icon": Icons.block},
      {"title": "Summary Report", "icon": Icons.insert_chart},
      {"title": "Daily Report", "icon": Icons.access_time},
      {"title": "Over Speed Report", "icon": Icons.speed},
      {"title": "Geofence Report", "icon": Icons.gps_fixed},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightBlue1,
              AppColors.lightBlue2,
              AppColors.white,
            ],
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Reports",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
          
                // GRID
                Expanded(
                  child: GridView.builder(
                    itemCount: reports.length,
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = reports[index];
                      return GestureDetector(
                        onTap: () {
                          if( item["title"]=="Ignition Report"){
                            Get.toNamed(Routes.ignitionReportScreen);
                          }
                          // Navigate to screens here
                          // Get.to(() => IgnitionReportScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item["icon"],
                                size: 48,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item["title"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
