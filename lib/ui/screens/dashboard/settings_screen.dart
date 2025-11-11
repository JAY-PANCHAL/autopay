import 'package:autopay/common/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../settings/change_password.dart'; // For responsive sizing

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in your main.dart or a parent widget if not already done
    // For this example, we assume it's initialized.
    // ScreenUtil.init(context, designSize: const Size(375, 812)); // Example values

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
          children: [
            // Custom AppBar
            _buildAppBar(context),
            // Settings List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                children: [
                  _SettingsTile(
                    icon: AppIcons.generalSetting,
                    title: "General Setting",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.changePassword,
                    // Using lock icon for change password
                    title: "Change Password",
                    onTap: () {
                      showChangePasswordDialog(context); // Call the method here
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.configAlert,
                    title: "Configure Alerts",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.customers,
                    title: "Customers",
                    onTap: () {
                      // Handle tap
                      Get.toNamed(Routes.customerListScreen);
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.dealers,
                    title: "Dealers",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.licenses,
                    title: "Licenses",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.expense,
                    title: "Expense",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _SettingsTile(
                    icon: AppIcons.geofences,
                    title: "Geofences",
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ],
              ),
            ),
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
            /* GestureDetector(
              onTap: () {
           //     Navigator.of(context).pop(); // Go back
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
            ),*/
            SizedBox(width: 20.w),
            Text(
              "App setting",
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

// Custom Widget for each setting tile
class _SettingsTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(icon, height: 28.sp, width: 28.sp),

              //   Icon(icon, color: AppColors.primaryBlue, size: 28.sp),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  title,
                  style: Styles.subtitleTextStyle(
                    size: 14.sp,
                    weight: FontWeight.w500,
                    color: AppColors.greyText,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.greyText.withOpacity(0.7),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
