import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/storage_service.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/profile_controller.dart';
import 'package:smart_track/routes/app_pages.dart';

import '../controller/todays_work_controller.dart';

class TodaysWorkScreen extends StatefulWidget {
  const TodaysWorkScreen({super.key});

  @override
  State<TodaysWorkScreen> createState() => _TodaysWorkScreenState();
}

class _TodaysWorkScreenState extends State<TodaysWorkScreen> {
  final TodaysWorkController controller = Get.put(TodaysWorkController());
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
            inAsyncCall: controller.isLoading.value,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Today's Status",
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
                            "Work start time ", "${controller.todaysStatusModel.value.data?[0].workStartTime??""}"),

                        _buildDetailCard(
                            "Total Time ", controller.todaysStatusModel.value.data?[0].totalTime??" "),
                        _buildDetailCard(
                            "Total out bags ", "${controller.todaysStatusModel.value.data?[0].totalOutBags??0}"),
                        _buildDetailCard(
                            "Total out quantity ", "${controller.todaysStatusModel.value.data?[0].totalOutGty??0}"),

                        _buildDetailCard(
                            "Total out weight ", "${controller.todaysStatusModel.value.data?[0].totalOutWeight??0}"),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
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
