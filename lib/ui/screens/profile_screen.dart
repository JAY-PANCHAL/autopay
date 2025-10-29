import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/storage_service.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/profile_controller.dart';
import 'package:smart_track/routes/app_pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  var isTablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Obx(() {
          return ModalProgressHUD(
            color: Colors.black.withOpacity(0.6),
            dismissible: false,
            blur: 5,
            progressIndicator: Utils.loader(context),
            inAsyncCall: profileController.isLoading.value,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildDetailCard(
                            "User Name", profileController.userName.value),
                        _buildDetailCard(
                            "Employee Name", profileController.name.value),
                        _buildDetailCard("User Code",
                            profileController.userCode.value),
                        _buildDetailCard(
                            "Designation", profileController.designation.value),
                        _buildDetailCard("Work Location Name",
                            profileController.workLocationName.value),
                        _buildDetailCard(
                            "Role Name", profileController.roleName.value),
                        _buildDetailCard(
                            "Company Name", profileController.companyName.value),
                       /* _buildDetailCard(
                            "Category", profileController.category.value),
                        _buildDetailCard(
                            "Skill", profileController.roleName.value),
                        _buildDetailCard(
                            "Process", profileController.processName.value),
                        _buildDetailCard(
                            "SubProcess", profileController.subProcess.value),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.getLogoutDialog(context);
        },
        backgroundColor: Colors.indigo,
        label: Text("Logout"),
        icon: Icon(Icons.logout),
        tooltip: 'Logout',
      ),*/

     /* floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          Utils.getLogoutDialog(context);
        },
        backgroundColor: Colors.indigo,
        label: Text(
          "Logout",
          style: TextStyle(
            fontSize: isTablet ? 10.sp : 12.sp,
          ),
        ),
        icon: Icon(
          Icons.logout,
          size: isTablet ? 16.sp : 20.sp, // Icon scales for tablet/mobile
        ),
        tooltip: 'Logout',
      ),
*/
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
