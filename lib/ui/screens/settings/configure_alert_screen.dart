import 'package:flutter/material.dart';
import '../../../common/utils/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfigureAlertsScreen extends StatefulWidget {
  const ConfigureAlertsScreen({super.key});

  @override
  State<ConfigureAlertsScreen> createState() => _ConfigureAlertsScreenState();
}

class _ConfigureAlertsScreenState extends State<ConfigureAlertsScreen> {
  bool ignitionOff = true;
  bool ignitionOn = false;
  String selectedValue = "BRII05FG53";

  List<String> vehicles = [
    "BRII05FG53",
    "MH12AB7890",
    "GJ01XY1234",
    "DL03ZZ7788",
  ];

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                      "Configure Alerts",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14),

                      items: vehicles.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Card with Items
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Ignition Off
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ignition Off",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _customCheckBox(
                            value: ignitionOff,
                            onTap: () {
                              setState(() {
                                ignitionOff = !ignitionOff;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Ignition On
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ignition On",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _customCheckBox(
                            value: ignitionOn,
                            onTap: () {
                              setState(() {
                                ignitionOn = !ignitionOn;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Checkbox UI
  Widget _customCheckBox({required bool value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 2),
          color: value ? Colors.black : Colors.transparent,
        ),
        child: value
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }
}
