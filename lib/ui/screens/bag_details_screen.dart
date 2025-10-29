import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/color_constants.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/bagDetails_controller.dart';
import 'package:smart_track/controller/global_controller.dart';
import 'package:smart_track/routes/app_pages.dart';
import 'package:photo_view/photo_view.dart';

class BagDetailsScreen extends StatefulWidget {
  const BagDetailsScreen({super.key});

  @override
  State<BagDetailsScreen> createState() => _BagDetailsScreenState();
}

class _BagDetailsScreenState extends State<BagDetailsScreen> {
  BagdetailsController bagDetailsController = Get.put(BagdetailsController());
  GlobalController globalController = Get.find<GlobalController>();
  bool isTablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (bagDetailsController.statusCode.value == "0" ||
              bagDetailsController.statusCode.value == "2") {
            // Get.offAllNamed(Routes.allBagsScreen);
            Get.offAllNamed(
              Routes.allBagsScreen,
              arguments: {
                'priority': int.parse(bagDetailsController.priority.value),
                'index': int.parse(bagDetailsController.priority.value),
                'isQC': 0,
              },
            );
            return true;
          }
          Utils.showToast("Please Pause Or Stop the ongoing Bag ");
          return false;
          // Get.offAllNamed(Routes.homeScreen);
        },
        child: ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          blur: 5,
          progressIndicator: Utils.loader(context),
          inAsyncCall: bagDetailsController.isLoading.value,
          child: Scaffold(
              backgroundColor: bagDetailsController.priority == "1"
                  ? AppColors.lightRed
                  : bagDetailsController.priority == "2"
                  ? AppColors.lightOrange
                  : bagDetailsController.priority == "3"
                  ? AppColors.lightYellow
                  : bagDetailsController.priority == "4"
                  ? AppColors.lightGreen
                  : AppColors.lightBlue,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primaryAppColor,
                elevation: 4,
                toolbarHeight: 56.h,
                title: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: GestureDetector(
                    //     onTap: () => Get.toNamed(Routes.profileScreen),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //       child: Icon(Icons.person,
                    //           color: AppColors.primaryAppColor),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Text(
                        "SMART TRACK",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
/*
              body: SafeArea(
                child: bagDetailsController.bagStyleNo.value == ""
                    ? Center(
                        child: Text(
                        "No Bag Data Found",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ))
                    : Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: bagDetailsController.priority == "1"
                                          ? Colors.red.shade700
                                          : bagDetailsController.priority == "2"
                                              ? Colors.orange.shade700
                                              : bagDetailsController.priority == "3"
                                                  ? Colors.yellow.shade700
                                                  : bagDetailsController.priority ==
                                                          "4"
                                                      ? Colors.green.shade700
                                                      : Colors.blue.shade700,
                                      borderRadius: BorderRadius.circular(12.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        bagDetailsController.priority == "1"
                                            ? "V Urgent Bags"
                                            : bagDetailsController.priority == "2"
                                                ? "Urgent Bags"
                                                : bagDetailsController.priority == "3"
                                                    ? "Moderate Priority"
                                                    : bagDetailsController.priority ==
                                                            "4"
                                                        ? "Second Priority"
                                                        : "Incoming QC",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),


                             */
/*     ListView(
                                  //crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [*/ /*

                                      Utils.addGap(16),
                                      // Bag Details Card
                                      _bagCard(
                                          "Bag No: ${bagDetailsController.bagNo.value ?? ""}",
                                          "${bagDetailsController.bagCreatedOn.value ?? ""}",
                                          1),

                                      Utils.addGap(10),

                                      // Control Buttons
                                      Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 12.h),
                                          child: bagDetailsController.statusCode.value ==
                                              "0"
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // _buildIconButton(
                                              //     Icons.play_arrow, Colors.green, "Start"),
                                              //1-start,2-pause,3-resume,4-out
                                              _buildIconButton(Icons.play_arrow,
                                                  Colors.green, "Start", 1),
                                              _buildIconButton(Icons.stop,
                                                  Colors.red, "Stop", 4),
                                            ],
                                          )
                                              : bagDetailsController.statusCode.value ==
                                              "1"
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // _buildIconButton(
                                              //     Icons.play_arrow, Colors.green, "Start"),
                                              //1-start,2-pause,3-resume,4-out
                                              _buildIconButton(Icons.pause,
                                                  Colors.orange, "Pause", 2),
                                              _buildIconButton(Icons.stop,
                                                  Colors.red, "Stop", 4),
                                            ],
                                          )
                                              : bagDetailsController
                                              .statusCode.value ==
                                              "2"
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              _buildIconButton(
                                                  Icons.play_arrow,
                                                  Colors.green,
                                                  "Resume",
                                                  3),
                                              // _buildIconButton(
                                              //     Icons.pause, Colors.orange, "Pause"),
                                              _buildIconButton(Icons.stop,
                                                  Colors.red, "Stop", 4),
                                            ],
                                          )
                                              : bagDetailsController
                                              .statusCode.value ==
                                              "3"
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              // _buildIconButton(
                                              //     Icons.play_arrow, Colors.green, "Resume"),
                                              _buildIconButton(
                                                  Icons.pause,
                                                  Colors.orange,
                                                  "Pause",
                                                  2),
                                              _buildIconButton(
                                                  Icons.stop,
                                                  Colors.red,
                                                  "Stop",
                                                  4),
                                            ],
                                          )
                                              : Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              // _buildIconButton(
                                              //     Icons.play_arrow, Colors.green, "Resume"),
                                              _buildIconButton(
                                                  Icons.pause,
                                                  Colors.orange,
                                                  "Pause",
                                                  2),
                                              _buildIconButton(
                                                  Icons.stop,
                                                  Colors.red,
                                                  "Stop",
                                                  4),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Utils.addGap(16),

                                      // Image + Bag Info
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              padding:
                                              EdgeInsets.all(8.r), // Internal spacing
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(
                                                    16.r), // Smooth rounded corners
                                                border: Border.all(
                                                  color: Colors
                                                      .grey.shade300, // Light grey border
                                                  width: 2.5,
                                                ),
                                              ),
                                              child: bagDetailsController.imageUrl.value
                                                  .startsWith('http')
                                                  ? Image.network(
                                                bagDetailsController.imageUrl.value,
                                                fit: BoxFit.contain,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.broken_image,
                                                        size: 60,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        'Image failed to load',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Image.asset(
                                                        'assets/images.png',
                                                        fit: BoxFit.contain,
                                                        height: 100,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                                  : Image.asset(
                                                'assets/images.png', // fallback to asset
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                _detailText("Style:",
                                                    " ${bagDetailsController.bagStyleNo.value ?? ""}"),
                                                _detailText("Quantity:",
                                                    " ${bagDetailsController.bagQuantity.value ?? ""}"),
                                                _detailText("Net Weight:",
                                                    " ${bagDetailsController.bagNetWeight.value ?? ""}"),
                                                _detailText("Stone Count:",
                                                    " ${bagDetailsController.bagStoneCount.value ?? ""}"),
                                                _detailText("Stone Cut:",
                                                    " ${bagDetailsController.bagStoneCut.value ?? ""}"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Utils.addGap(15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              bagDetailsController.viewTiming.value =
                                              !bagDetailsController.viewTiming.value;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryAppColor,
                                                  borderRadius:
                                                  BorderRadius.circular(12.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ]),
                                              child: Padding(
                                                padding: EdgeInsets.all(15.sp),
                                                child: Text(
                                                  "View Timing ",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Utils.addGap(10),
                                      bagDetailsController.viewTiming.value
                                          ? Expanded(
                                            child: Column(
                                              children: [
                                                // Header row
                                                */
/*
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 12, vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.primaryAppColor),
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Status",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            "Date & Time",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Remark",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                                          */ /*

                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                  decoration: BoxDecoration(color: AppColors.primaryAppColor),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          "Status",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: isTablet ? 12.sp : 10.sp, // Tablet vs Mobile
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Date & Time",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: isTablet ? 12.sp : 10.sp, // Tablet vs Mobile
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "Remark",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: isTablet ? 12.sp : 10.sp, // Tablet vs Mobile
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                */
/*
                                                    Expanded(
                                                    child: ListView.builder(
                                                      itemCount: bagDetailsController
                                                          .bagActivityList.length,
                                                      itemBuilder: (context, index) {
                                                        final statusList = [
                                                          {
                                                            "text": "Started On",
                                                            "color": Colors.green,
                                                            "date":
                                                                "20/11/2023 - 10:00am",
                                                            "showEye": false
                                                          },
                                                          {
                                                            "text": "Paused On",
                                                            "color": Colors.orange,
                                                            "date":
                                                                "20/11/2023 - 12:00pm",
                                                            "showEye": true
                                                          },
                                                          {
                                                            "text": "Resumed On",
                                                            "color":
                                                                Colors.yellow.shade800,
                                                            "date":
                                                                "20/11/2023 - 12:00pm",
                                                            "showEye": false
                                                          },
                                                          {
                                                            "text": "End",
                                                            "color": Colors.red,
                                                            "date":
                                                                "20/11/2023 - 12:00pm",
                                                            "showEye": false
                                                          },
                                                        ];

                                                        final item = bagDetailsController
                                                            .bagActivityList[index];

                                                        return Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 12),
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .grey.shade200),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              // Status + Dot
                                                              Expanded(
                                                                flex: 2,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 10,
                                                                      height: 10,
                                                                      margin:
                                                                          EdgeInsets.only(
                                                                              right: 8),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: item.status ==
                                                                                "Start"
                                                                            ? Colors.green
                                                                            : item.status ==
                                                                                    "Pause"
                                                                                ? Colors
                                                                                    .yellow
                                                                                : item.status ==
                                                                                        "Pause"
                                                                                    ? Colors
                                                                                        .yellow
                                                                                    : Colors
                                                                                        .red,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      item.status
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Date & Time
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  item.createdOn
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14),
                                                                ),
                                                              ),
                                                              // Reason icon if available
                                                              Expanded(
                                                                child: item.reason != ""
                                                                    ? IconButton(
                                                                        icon: Icon(Icons
                                                                            .remove_red_eye),
                                                                        onPressed: () {
                                                                          Utils.getReasonDialog(
                                                                              context,
                                                                              item.reason
                                                                                  .toString());
                                                                        },
                                                                        color:
                                                                            Colors.blue)
                                                                    : SizedBox(),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                                          */ /*

                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: bagDetailsController.bagActivityList.length,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {
                                                      final item = bagDetailsController.bagActivityList[index];
                                                      return Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                                        decoration: BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(color: Colors.grey.shade200),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Status + Dot
                                                            Expanded(
                                                              flex: 2,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 10,
                                                                    height: 10,
                                                                    margin: const EdgeInsets.only(right: 8),
                                                                    decoration: BoxDecoration(
                                                                      color: item.status == "Start"
                                                                          ? Colors.green
                                                                          : item.status == "Pause"
                                                                          ? Colors.yellow
                                                                          : item.status == "Resume"
                                                                          ? Colors.yellow.shade800
                                                                          : Colors.red,
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.status.toString(),
                                                                    style: TextStyle(
                                                                      fontSize: isTablet ? 10.sp : 12.sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Date & Time
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                item.createdOn.toString(),
                                                                style: TextStyle(
                                                                  fontSize: isTablet ? 10.sp : 12.sp,
                                                                ),
                                                              ),
                                                            ),
                                                            // Reason icon if available
                                                            Expanded(
                                                              child: item.reason != ""
                                                                  ? IconButton(
                                                                icon: const Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  Utils.getReasonDialog(
                                                                    context,
                                                                    item.reason.toString(),
                                                                  );
                                                                },
                                                                color: Colors.blue,
                                                                iconSize: isTablet ? 16.sp : 20.sp, // Optional scaling
                                                              )
                                                                  : const SizedBox(),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          : Container()

                                      // Uncomment this to show the status timeline
                                      // _statusTable(),
                                  */
/*  ],
                                  ),*/ /*


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              )
*/


              body: SafeArea(
                child: bagDetailsController.bagStyleNo.value == ""
                    ? Center(
                  child: Text(
                    "No Bag Data Found",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Priority Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: bagDetailsController.priority == "1"
                                ? Colors.red.shade700
                                : bagDetailsController.priority == "2"
                                ? Colors.orange.shade700
                                : bagDetailsController.priority == "3"
                                ? Colors.yellow.shade700
                                : bagDetailsController.priority == "4"
                                ? Colors.green.shade700
                                : Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              bagDetailsController.priority == "1"
                                  ? "V Urgent Bags"
                                  : bagDetailsController.priority == "2"
                                  ? "Urgent Bags"
                                  : bagDetailsController.priority == "3"
                                  ? "Moderate Priority"
                                  : bagDetailsController.priority == "4"
                                  ? "Second Priority"
                                  : "Incoming QC",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Utils.addGap(16),

                        // Bag Details Card
                        _bagCard(
                          "Bag No: ${bagDetailsController.bagNo.value ?? ""}",
                          "${bagDetailsController.bagCreatedOn.value ?? ""}",
                          1,
                        ),

                        Utils.addGap(10),

                        // Control Buttons

                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            child: bagDetailsController.statusCode.value ==
                                "0"
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                // _buildIconButton(
                                //     Icons.play_arrow, Colors.green, "Start"),
                                //1-start,2-pause,3-resume,4-out
                                _buildIconButton(Icons.play_arrow,
                                    Colors.green, "Start", 1),
                                _buildIconButton(Icons.stop,
                                    Colors.red, "Stop", 4),
                              ],
                            )
                                : bagDetailsController.statusCode.value ==
                                "1"
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                // _buildIconButton(
                                //     Icons.play_arrow, Colors.green, "Start"),
                                //1-start,2-pause,3-resume,4-out
                                _buildIconButton(Icons.pause,
                                    Colors.orange, "Pause", 2),
                                _buildIconButton(Icons.stop,
                                    Colors.red, "Stop", 4),
                              ],
                            )
                                : bagDetailsController
                                .statusCode.value ==
                                "2"
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                              children: [
                                _buildIconButton(
                                    Icons.play_arrow,
                                    Colors.green,
                                    "Resume",
                                    3),
                                // _buildIconButton(
                                //     Icons.pause, Colors.orange, "Pause"),
                                _buildIconButton(Icons.stop,
                                    Colors.red, "Stop", 4),
                              ],
                            )
                                : bagDetailsController
                                .statusCode.value ==
                                "3"
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                              children: [
                                // _buildIconButton(
                                //     Icons.play_arrow, Colors.green, "Resume"),
                                _buildIconButton(
                                    Icons.pause,
                                    Colors.orange,
                                    "Pause",
                                    2),
                                _buildIconButton(
                                    Icons.stop,
                                    Colors.red,
                                    "Stop",
                                    4),
                              ],
                            )
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                              children: [
                                // _buildIconButton(
                                //     Icons.play_arrow, Colors.green, "Resume"),
                                _buildIconButton(
                                    Icons.pause,
                                    Colors.orange,
                                    "Pause",
                                    2),
                                _buildIconButton(
                                    Icons.stop,
                                    Colors.red,
                                    "Stop",
                                    4),
                              ],
                            ),
                          ),
                        ),

                        /*       Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: _buildControlButtons(),
                          ),
                        ),*/

                        Utils.addGap(16),

                        // Image + Bag Info
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.all(0.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 2.5,
                                  ),
                                ),
                                child: bagDetailsController.imageUrl.value
                                    .contains('http') ||
                                    bagDetailsController.imageUrl.value
                                        .contains('http')
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: /*Image.network(
                                                                        bagDetailsController.imageUrl.value,
                                                                        fit: BoxFit.cover,

                                                                        errorBuilder: (context, error, stackTrace) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.broken_image,
                                            size: 60,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Image failed to load',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Image.asset(
                                            'assets/images.png',
                                            fit: BoxFit.contain,
                                            height: 100,
                                          ),
                                        ],
                                      );
                                                                        },
                                                                      )*/

                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => ImageZoomScreen(
                                          imageUrl: bagDetailsController.imageUrl.value,
                                        ));
                                      },
                                    child: Image.network(
                                      bagDetailsController.imageUrl.value,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                          stackTrace) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            const Icon(
                                              Icons.broken_image,
                                              size: 60,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Image failed to load',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Image.asset(
                                              'assets/images.png',
                                              fit: BoxFit.contain,
                                              height: 100,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),


                                )
                                    : const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _detailText("Style:",
                                      " ${bagDetailsController.bagStyleNo
                                          .value ?? ""}"),
                                  _detailText("Quantity:",
                                      " ${bagDetailsController.bagQuantity
                                          .value ?? ""}"),
                                  _detailText("Net Weight:",
                                      " ${bagDetailsController.bagNetWeight
                                          .value ?? ""}"),
                                  _detailText("Stone Count:",
                                      " ${bagDetailsController.bagStoneCount
                                          .value ?? ""}"),
                                  _detailText("Stone Cut:",
                                      " ${bagDetailsController.bagStoneCut
                                          .value ?? ""}"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Utils.addGap(15),

                        // View Timing Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                bagDetailsController.viewTiming.value =
                                !bagDetailsController.viewTiming.value;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAppColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(15.sp),
                                child: Text(
                                  "View Timing ",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        Utils.addGap(10),

                        // Timing Table + List
                        if (bagDetailsController.viewTiming.value) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.primaryAppColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isTablet ? 12.sp : 10.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Date & Time",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isTablet ? 12.sp : 10.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Remark",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isTablet ? 12.sp : 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ListView.builder(
                            itemCount: bagDetailsController.bagActivityList
                                .length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = bagDetailsController
                                  .bagActivityList[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            margin: const EdgeInsets.only(
                                                right: 8),
                                            decoration: BoxDecoration(
                                              color: item.status == "Start"
                                                  ? Colors.green
                                                  : item.status == "Pause"
                                                  ? Colors.yellow
                                                  : item.status == "Resume"
                                                  ? Colors.yellow.shade800
                                                  : Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            item.status.toString(),
                                            style: TextStyle(
                                              fontSize: isTablet ? 10.sp : 12
                                                  .sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        item.createdOn.toString(),
                                        style: TextStyle(
                                          fontSize: isTablet ? 10.sp : 12.sp,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: item.reason != "" &&
                                          item.reason != null
                                          ? IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          Utils.getReasonDialog(
                                              context,
                                              item.reason.toString(),
                                              isTablet
                                          );
                                        },
                                        color: Colors.blue,
                                        iconSize: isTablet ? 16.sp : 20.sp,
                                      )
                                          : const SizedBox(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )

          ),
        ),
      );
    });
  }

  Widget _buildDialog(BuildContext context, int reason) {
    int? selectedIndex = null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button at Top Right
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(4.sp),
                    child: Icon(Icons.close, color: Colors.white, size: 18.sp),
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // PAUSE REASON title
              Text(
                reason.toString() == "1"
                    ? "Start Reason"
                    : reason.toString() == "2"
                    ? "Pause Reason"
                    : reason.toString() == "3"
                    ? "Resume Reason"
                    : reason.toString() == "4"
                    ? "Work Done Reason"
                    : "",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16.h),
              // Buttons for reasons
              ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reason.toString() == "1"
                    ? globalController.startReason.length
                    : reason.toString() == "2"
                    ? globalController.pauseReason.length
                    : reason.toString() == "3"
                    ? globalController.resumeReason.length
                    : reason.toString() == "4"
                    ? globalController.stopReason.length
                    : globalController.startReason.length,
                itemBuilder: (context, index) {
                  final item = reason.toString() == "1"
                      ? globalController.startReason[index]
                      : reason.toString() == "2"
                      ? globalController.pauseReason[index]
                      : reason.toString() == "3"
                      ? globalController.resumeReason[index]
                      : reason.toString() == "4"
                      ? globalController.stopReason[index]
                      : globalController.startReason[index];
                  //   var isSelected ;
                  /* bagDetailsController.selectedReasonIndex.value ==
                          index;*/
                  print(bagDetailsController.selectedReasonIndex.value);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _customReasonButton(
                      item.reason ?? "",
                      //isSelected,
                      bagDetailsController.selectedReasonIndex.value ==
                          index,
                          () {
                        setState(() {
                          selectedIndex = index;
                          bagDetailsController.selectedReasonIndex.value =
                              index;
                          bagDetailsController.selectedReasonCode.value =
                              item.reasonCode ?? 0; // ✅ Save the code here
                          print(bagDetailsController
                              .selectedReasonCode.value);
                        });
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 24.h),

              /* // PROCESS DETAILS title
              bagDetailsController.statusCode.value == "0" && reason != 4
                  ? Text(
                      "Sub Process Details",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )
                  : Container(),

              SizedBox(height: 16.h),
              bagDetailsController.statusCode.value == "0" && reason != 4
                  ? SizedBox(
                      height: 120.h, // You can adjust this height as needed
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                      physics: NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                        itemCount: globalController.subProcessMasterList.length,
                        itemBuilder: (context, index) {
                          final item =
                              globalController.subProcessMasterList[index];
                          final isSelected = bagDetailsController
                                  .selectedSubProcessIndex.value ==
                              index;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _customSubProcessButton(
                              item.subProcessName ?? "",
                              isSelected,
                              () {
                                setState(() {
                                  bagDetailsController
                                      .selectedSubProcessIndex.value = index;
                                  bagDetailsController
                                          .selectedSubProcessCode.value =
                                      item.subProcessCode ??
                                          0; // ✅ Save the code here
                                  print(bagDetailsController
                                      .selectedSubProcessCode.value);
                                });
                              },
                            ),
                          );
                        },
                      ))
                  : Container(),*/
              // Dropdowns
              // Row(
              //   children: [
              //     // Expanded(child: _customDropdown("Select Process")),
              //     // SizedBox(width: 8.w),
              //     Expanded(
              //         child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black),
              //         borderRadius: BorderRadius.circular(6.sp),
              //       ),
              //       padding: EdgeInsets.symmetric(vertical: 12.sp),
              //       child: Center(
              //         child: Text(
              //           globalController
              //                   .subProcessMasterList[0].subProcessName ??
              //               "",
              //           style: TextStyle(fontSize: 14.sp),
              //         ),
              //       ),
              //     ))
              //     // Expanded(child: _customDropdown("Select Sub-Process")),
              //   ],
              // ),

              SizedBox(height: 24.h),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (bagDetailsController.selectedReasonCode.value == 0) {
                    Utils.showToast("Please select atleast one reason");
                  } else {
                    bagDetailsController.workerEntryApiCall(
                        reasonCode: bagDetailsController.selectedReasonCode
                            .value,
                        subprocessCode: bagDetailsController.activeReason
                            .value !=
                            1
                            ? 0
                            : bagDetailsController.selectedSubProcessCode.value,
                        statusCode: bagDetailsController.activeReason.value,
                        workerQCInward:
                        int.parse(bagDetailsController.qcInwardCode.value),
                        context: context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                  EdgeInsets.symmetric(horizontal: 32.sp, vertical: 12.sp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.sp),
                  ),
                ),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _customReasonButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
          isSelected ? Colors.indigo.withOpacity(0.1) : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.indigo : Colors.black),
          borderRadius: BorderRadius.circular(6.sp),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: isSelected ? Colors.indigo : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customSubProcessButton(String text, bool isSelected,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
          isSelected ? Colors.indigo.withOpacity(0.1) : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.indigo : Colors.black),
          borderRadius: BorderRadius.circular(6.sp),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: isSelected ? Colors.indigo : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropdown(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6.sp),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 12.sp)),
          items: [], // Add your DropdownMenuItems here
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, String label, int reason
      // {required VoidCallback onTap}
      ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            bagDetailsController.selectedReasonCode.value = 0;

            bagDetailsController.selectedReasonIndex.value = (-1);
            bagDetailsController.activeReason.value = reason;
            showDialog(
              context: context,
              barrierDismissible:
              false, // Set to true if you want tap outside to dismiss
              builder: (BuildContext context) {
                return _buildDialog(context, reason); // Pass context
              },
            );
          },
          borderRadius: BorderRadius.circular(32),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 1.5),
            ),
            child: Icon(icon, size: 24.sp, color: color),
          ),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 12.sp, color: color)),
      ],
    );
  }

  Widget _bagCard(String code, String time, int urgency) {
    Color urgencyColor = bagDetailsController.priority == "1"
        ? Colors.red.shade700
        : bagDetailsController.priority == "2"
        ? Colors.orange.shade700
        : bagDetailsController.priority == "3"
        ? Colors.yellow.shade700
        : bagDetailsController.priority == "4"
        ? Colors.green.shade700
        : Colors.blue.shade700;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: urgencyColor, width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(Icons.shopping_bag, color: urgencyColor, size: 30.sp),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text("Assigned Time: $time", style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
  Widget _detailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          text: "$label ",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
*/
  Widget _detailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          text: "$label ",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 14.sp : 12.sp, // Tablet vs Mobile size
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: isTablet ? 12.sp : 10.sp, // Tablet vs Mobile size
              ),
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

  /* Widget _tableRow(String status, String time, String reason,
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
  }*/
  Widget _tableRow(String status, String time, String reason,
      {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      color: isHeader ? AppColors.thirdAppColor : null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              status,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.white : Colors.black,
                fontSize: isTablet ? 16.sp : 12.sp, // Tablet vs Mobile
              ),
            ),
          ),
          Expanded(
            child: Text(
              time,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.white : Colors.black,
                fontSize: isTablet ? 16.sp : 12.sp, // Tablet vs Mobile
              ),
            ),
          ),
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.white : Colors.black,
                fontSize: isTablet ? 16.sp : 12.sp, // Tablet vs Mobile
              ),
            ),
          ),
        ],
      ),
    );
  }

}




class ImageZoomScreen extends StatelessWidget {
  final String imageUrl;

  ImageZoomScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage('assets/images.png') as ImageProvider,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
