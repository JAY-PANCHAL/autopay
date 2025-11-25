import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../controller/licence_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LicensesScreen extends StatelessWidget {
  LicensesScreen({super.key});

  final controller = Get.put(LicenseController());

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),

            // ROW WITH DATE PICKERS
            Row(
              children: [
                // From Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "From Date",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: controller.fromDateText,
                        readOnly: true,
                        onTap: () => controller.selectDate(context, true),
                        decoration: InputDecoration(
                          hintText: "Select Date",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // End Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "End Date",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: controller.endDateText,
                        readOnly: true,
                        onTap: () => controller.selectDate(context, false),
                        decoration: InputDecoration(
                          hintText: "Select Date",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Search Button
                InkWell(
                  onTap: controller.searchLicenses,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C88B8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Add Licenses Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.goToAddLicenses,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C88B8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Licenses   +",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false, // Don't absorb bottom padding
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Text(
              "Licenses",
              style: Styles.headlineTextStyle(
                size: 24.sp,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
