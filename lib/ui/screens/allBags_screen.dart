import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/app_constants.dart';
import 'package:smart_track/common/utils/color_constants.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/allBags_controller.dart';
import 'package:smart_track/routes/app_pages.dart';

class AllBagsScreen extends StatefulWidget {
  const AllBagsScreen({super.key});

  @override
  State<AllBagsScreen> createState() => _AllBagsScreenState();
}

class _AllBagsScreenState extends State<AllBagsScreen> {
  AllBagsController allBagsController = Get.put(AllBagsController());
  var isTablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.homeScreen);
          return true;
        },
        child: ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          blur: 5,
          progressIndicator: Utils.loader(context),
          inAsyncCall: allBagsController.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryAppColor,
              elevation: 4,
              toolbarHeight: 56.h,
              title: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.profileScreen),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,
                            color: AppColors.primaryAppColor),
                      ),
                    ),
                  ),
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
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Time Info Bar
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _timeBox("Idle Time", "10:00M"),
                    //     _timeBox("Work Time", "10:00M"),
                    //     _timeBox("Break Time", "10:00M"),
                    //   ],
                    // ),
                    Utils.addGap(12),
                    // Search bar and tabs
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextField(
                    //         decoration: InputDecoration(
                    //           hintText: 'Enter Bag Number',
                    //           prefixIcon: Icon(Icons.search),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10.r),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 8.w),
                    //     Icon(Icons.qr_code_scanner, size: 30.sp),
                    //   ],
                    // ),
                    // SizedBox(height: 10.h),

                    // Filter Tabs
                    SizedBox(
                      height: 40.sp,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        controller: allBagsController.chipScrollController,
                        children: [
                          _chip("All Bag", onTap: () {
                            allBagsController.getAllBags();
                          }, index: 0),
                          SizedBox(width: 5.sp),
                          _chip("V.V.Urgent", onTap: () {
                            allBagsController.filterByPriority(1);
                          }, index: 1),
                          SizedBox(width: 5.sp),
                          _chip("Urgent", onTap: () {
                            allBagsController.filterByPriority(2);
                          }, index: 2),
                          SizedBox(width: 5.sp),
                          _chip("Moderate Priority", onTap: () {
                            allBagsController.filterByPriority(3);
                          }, index: 3),
                          SizedBox(width: 5.sp),
                          _chip("Second Priority", onTap: () {
                            allBagsController.filterByPriority(4);
                          }, index: 4),
                          SizedBox(width: 5.sp),
                          _chip("Incoming QC", onTap: () {
                            allBagsController.filterByQC(0);
                          }, index: 5),
                          SizedBox(width: 5.sp),
                          _chip("Active", onTap: () {
                            allBagsController.filterByActive();
                          }, index: 6),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Bag List
                    Expanded(
                        child: ListView.builder(
                      itemCount: allBagsController.filteredBagList.length,
                      itemBuilder: (context, index) {
                        final bag = allBagsController.filteredBagList[index];
                        return Column(
                          children: [
                            _bagCard(
                                bag.bagNo.toString() ?? "#UNKNOWN",
                                bag.createdOn ?? "NA",
                                int.parse(bag.priority.toString() ?? "3"),
                                bag.bagNo ?? "",
                                bag.wrkerQCInwardCode ?? 0,
                                bag.isAccepted ?? 0,bag.isActive ?? 0),
                            // if (bag.bagStatus == "1" ||
                            //     bag.bagStatus == "3") ...[
                            //   SizedBox(height: 10.h),
                            //   Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Image.asset(
                            //         'assets/images.png',
                            //         height: 80.h,
                            //         width: 80.h,
                            //         fit: BoxFit.cover,
                            //       ),
                            //       SizedBox(width: 12.w),
                            //       Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           _detailText(
                            //               "Style:", bag.bagStyle ?? ""),
                            //           _detailText(
                            //               "Process:", bag.bagProcess ?? ""),
                            //           _detailText("Sub Process:",
                            //               bag.bagSubProcess ?? ""),
                            //           _detailText(
                            //               "Bag Type:", bag.bagType ?? ""),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            //   SizedBox(height: 10.h),
                            //   Center(
                            //     child: InkWell(
                            //       onTap: () {
                            //         print("object");
                            //       },
                            //       child: Container(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 12, vertical: 6),
                            //         decoration: BoxDecoration(
                            //           color: AppColors.primaryAppColor,
                            //           borderRadius: BorderRadius.circular(8),
                            //         ),
                            //         child: Text(
                            //           "View Timing",
                            //           style: const TextStyle(
                            //               color: Colors.white, fontSize: 12),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   SizedBox(height: 10.h),
                            //   _statusTable(),
                            // ],
                          ],
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _timeBox(String label, String time) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(time, style: TextStyle(fontSize: 12.sp)),
        ),
      ],
    );
  }

  Widget _chip(
    String label, {
    required VoidCallback onTap,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = allBagsController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () {
          allBagsController.selectedIndex.value = index;
          onTap();
          allBagsController.scrollToChip(allBagsController.selectedIndex.value);
        },
        child: AnimatedContainer(
          width: 150.sp,
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.thirdAppColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 12.sp : 10.sp, // Tablet vs Mobile

                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _bagCard(String code, String time, int urgency, String bagNo,
      int workerInwardCode, int isaccepted,int isActive,
      {bool urgent = false}) {
    return GestureDetector(
      onTap: () {
        if (isaccepted == 0) {
          Get.toNamed(Routes.bagQCScreen, arguments: {
            "bag_no": bagNo,
            "WrkerQCInward_code": workerInwardCode
          });
        } else {
          Get.toNamed(Routes.bagDetailScreen, arguments: {
            "bag_no": bagNo,
            "WrkerQCInward_code": workerInwardCode
          });
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(
            color:
            isActive==1?AppColors.appColor:
            urgency == 1
                ? Colors.red
                : urgency == 2
                    ? Colors.orange
                    : urgency == 3
                        ? Colors.amber
                        : urgency == 0
                            ? Colors.blue
                            : Colors.green,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                size: 30.sp,
                color:
                isActive==1?AppColors.appColor:

                urgency == 1
                    ? Colors.red
                    : urgency == 2
                        ? Colors.orange
                        : urgency == 3
                            ? Colors.amber
                            : urgency == 0
                                ? Colors.blue
                                : Colors.green,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      code,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              isaccepted == 0
                  ? Icon(
                      Icons.assistant_sharp,
                      size: 20.sp,
                      color: urgency == 1
                          ? Colors.red
                          : urgency == 2
                              ? Colors.orange
                              : urgency == 3
                                  ? Colors.amber
                                  : urgency == 0
                                      ? Colors.blue
                                      : Colors.green,
                    )
                  : Icon(Icons.assistant_sharp,
                      size: 20.sp, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          text: label + " ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tableRow("Status", "Date & Time", "Reason", isHeader: true),
        _tableRow("Started", "20/11 12:00pm", ""),
        _tableRow("Resumed On", "20/11 1:00pm", ""),
        _tableRow("End", "20/11 2:00pm", ""),
      ],
    );
  }

  Widget _tableRow(String status, String time, String reason,
      {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      color: isHeader ? AppColors.thirdAppColor : null,
      child: Row(
        children: [
          Expanded(
              child: Text(status,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: isHeader ? Colors.white : Colors.black))),
          Expanded(
              child: Text(time,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: isHeader ? Colors.white : Colors.black))),
          Expanded(
              child: Text(reason,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: isHeader ? Colors.white : Colors.black))),
        ],
      ),
    );
  }
}
