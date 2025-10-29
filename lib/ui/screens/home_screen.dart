import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/color_constants.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/global_controller.dart';
import 'package:smart_track/controller/home_controller.dart';
import 'package:smart_track/routes/app_pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put((HomeScreenController()));
  GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  final List<Map<String, dynamic>> badgeItems = [
    {
      "title": "V.V. Urgent Bags",
      "value": "4",
      "color": Colors.red,
      "icon": Icons.warning_amber,
    },
    {
      "title": "Urgent Bags",
      "value": "2",
      "color": Colors.deepOrange,
      "icon": Icons.priority_high,
    },
    {
      "title": "Moderate Priority Bags",
      "value": "10",
      "color": Colors.amber,
      "icon": Icons.timer,
    },
    {
      "title": "Second Priority Bags",
      "value": "50",
      "color": Colors.green,
      "icon": Icons.check_circle,
    },
    {
      "title": "Incoming QC Bag",
      "value": "35",
      "color": Colors.blue,
      "icon": Icons.inbox,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
        snackBar: const SnackBar(content: Text('Tap again to exit!')),
        child: Obx(() {
          return ModalProgressHUD(
            color: Colors.black.withOpacity(0.6),
            dismissible: false,
            blur: 5,
            progressIndicator: Utils.loader(context),
            inAsyncCall: homeScreenController.isLoading.value,
            child: Scaffold(
              backgroundColor: const Color(0xFFF6F6F6),
              appBar: AppBar(
                backgroundColor: AppColors.primaryAppColor,
                elevation: 4,
                toolbarHeight: 56.h,
                // title: Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: GestureDetector(
                //         onTap: () => Get.toNamed(Routes.profileScreen),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.white,
                //           child: Icon(Icons.person,
                //               color: AppColors.primaryAppColor),
                //         ),
                //       ),
                //     ),
                //     Text(
                //       "SMART TRACK",
                //       style: TextStyle(
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
                title: Stack(
                  alignment: Alignment.center,
                  children: [
/*
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(), // 👈 open drawer
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryAppColor,
                            ),
                          ),
                        ),
                      ),
                    ),
*/
                    Text(
                      "SMART TRACK",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // 👇 Add drawer
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColors.primaryAppColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){
                            //    Get.toNamed(Routes.profileScreen);
                              }                  ,
                              child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryAppColor,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            homeScreenController.empDetailsModel.data?[0].userName??"",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.work, color: AppColors.primaryAppColor),
                      title: Text("Today's Work"),
                      onTap: () {
                        // navigate to today's work screen
                        Get.toNamed(Routes.todaysWorkScreen);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_2, color: AppColors.primaryAppColor),
                      title: Text("Profile"),
                      onTap: () {
                        Get.toNamed(Routes.profileScreen);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: AppColors.primaryAppColor),
                      title: Text("Logout"),
                      onTap: () {
                        Utils.getLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),

              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.2,
                    ),
                    children: [
                      //is only qc 1-true,0-false
                      _buildBadgeTile(
                          "V.V.Urgent Bags",
                          homeScreenController.vvUrgentTotal.value.toString(),
                          Colors.red,
                          Icons.warning_amber,
                          1,
                          0,
                          1,0),
                      //is only qc 1-true,0-false
                      _buildBadgeTile(
                          "Urgent Bags",
                          homeScreenController.urgentTotal.value.toString(),
                          Colors.deepOrange,
                          Icons.priority_high,
                          2,
                          0,
                          2,0),
                      //is only qc 1-true,0-false
                      _buildBadgeTile(
                          "Moderate Priority Bags",
                          homeScreenController.moderateTotal.value.toString(),
                          Colors.amber,
                          Icons.timer,
                          3,
                          0,
                          3,0),
                      //is only qc 1-true,0-false
                      _buildBadgeTile(
                          "Second Priority Bags",
                          homeScreenController.secondPriorityTotal.value
                              .toString(),
                          Colors.green,
                          Icons.check_circle,
                          4,
                          0,
                          4,0),
                      //is only qc 1-true,0-false
                      _buildBadgeTile(
                          "Incoming QC Bag",
                          homeScreenController.incomingQCTotal.value.toString(),
                          Colors.blue,
                          Icons.inbox,
                          0,
                          1,
                          5,0),

                      _buildBadgeTile(
                          "Active",
                          homeScreenController.activeBagsTotal.value.toString(),
                          AppColors.thirdAppColor,
                          Icons.start,
                          0,
                          1,
                          6,1)

                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget _buildBadgeTile(String title, String value, Color color, IconData icon,
      int priority, int isQC, int index,int isActive) {
    //is only qc 1-true,0-false
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.allBagsScreen,
        arguments: {
          'priority': priority, // Example: 1 for V.V. Urgent Bags
          'index': index, // Example: 1 for V.V. Urgent Bags
          'isQC': isQC, // Example: 1 for V.V. Urgent Bags
          'isActive':isActive
        },
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 26.sp),
              SizedBox(height: 8.h),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
              ),
              SizedBox(height: 6.h),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
