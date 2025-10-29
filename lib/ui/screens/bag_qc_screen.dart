import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_track/common/utils/color_constants.dart';
import 'package:smart_track/common/utils/utility.dart';
import 'package:smart_track/controller/bagQc_controller.dart';
import 'package:smart_track/controller/global_controller.dart';
import 'package:smart_track/routes/app_pages.dart';

import 'bag_details_screen.dart';

class BagQCScreen extends StatefulWidget {
  const BagQCScreen({super.key});

  @override
  State<BagQCScreen> createState() => _BagQCScreenState();
}

class _BagQCScreenState extends State<BagQCScreen> {
  BagQCController bagQCController = Get.put(BagQCController());
  GlobalController globalController = Get.find<GlobalController>();
  var isTablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        blur: 5,
        progressIndicator: Utils.loader(context),
        inAsyncCall: bagQCController.isLoading.value,
        child: Scaffold(
            backgroundColor: bagQCController.priority == "1"
                ? AppColors.lightRed
                : bagQCController.priority == "2"
                    ? AppColors.lightOrange
                    : bagQCController.priority == "3"
                        ? AppColors.lightYellow
                        : bagQCController.priority == "4"
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
            body: bagQCController.bagStyleNo.value == ""
                ? Center(
                    child: Text(
                    "No Bag Data Found",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ))
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: bagQCController.priority == "1"
                                  ? Colors.red.shade700
                                  : bagQCController.priority == "2"
                                      ? Colors.orange.shade700
                                      : bagQCController.priority == "3"
                                          ? Colors.yellow.shade700
                                          : bagQCController.priority == "4"
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
                                bagQCController.priority == "1"
                                    ? "V Urgent Bags"
                                    : bagQCController.priority == "2"
                                        ? "Urgent Bags"
                                        : bagQCController.priority == "3"
                                            ? "Moderate Priority"
                                            : bagQCController.priority == "4"
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
                              "Bag No: ${bagQCController.bagNo.value ?? ""}",
                              "${bagQCController.bagCreatedOn.value ?? ""}",
                              1),
                          Utils.addGap(10),
                          // Control Buttons
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
                                  child: bagQCController.imageUrl.value
                                      .contains('http') || bagQCController.imageUrl.value
                                      .contains('http')
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => ImageZoomScreen(
                                          imageUrl: bagQCController.imageUrl.value,
                                        ));
                                      },
                                      child: Image.network(
                                        bagQCController.imageUrl.value,
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
                                      ),
                                    ),
                                  )
                                      :  const Icon(
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _detailText("Style:",
                                        " ${bagQCController.bagStyleNo.value ?? ""}"),
                                    _detailText("Quantity:",
                                        " ${bagQCController.bagQuantity.value ?? ""}"),
                                    _detailText("Net Weight:",
                                        " ${bagQCController.bagNetWeight.value ?? ""}"),
                                    _detailText("Stone Count:",
                                        " ${bagQCController.bagStoneCount.value ?? ""}"),
                                    _detailText("Stone Cut:",
                                        " ${bagQCController.bagStoneCut.value ?? ""}"),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Utils.addGap(10),
                          Expanded(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                child: Column(children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          globalController.qcMasterList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${globalController.qcMasterList[index].title ?? ""} :  ${index == 0 ? bagQCController.bagQuantity.value ?? "" : index == 1 ? bagQCController.bagNetWeight.value ?? "" : 0}",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Obx(() => GestureDetector(
                                                    onTap: () {
                                                      if (index == 0) {
                                                        bagQCController
                                                                .firstStatus
                                                                .value =
                                                            !bagQCController
                                                                .firstStatus
                                                                .value;
                                                      } else if (index == 1) {
                                                        bagQCController
                                                                .secondStatus
                                                                .value =
                                                            !bagQCController
                                                                .secondStatus
                                                                .value;
                                                      } else if (index == 2) {
                                                        bagQCController
                                                                .thirdStatus
                                                                .value =
                                                            !bagQCController
                                                                .thirdStatus
                                                                .value;
                                                      } else if (index == 3) {
                                                        bagQCController
                                                                .fourthStatus
                                                                .value =
                                                            !bagQCController
                                                                .fourthStatus
                                                                .value;
                                                      } else {
                                                        Utils.showToast(
                                                            "Something went wrong");
                                                      }
                                                    },
                                                    child:
                                                        _switchButton(index))),
                                              ],
                                            ),
                                            Utils.addGap(20),
                                            //   Row(
                                            //     children: [
                                            //       _buildButton(Colors.green, "IN"),
                                            //       SizedBox(
                                            //           width: 12), // spacing between buttons
                                            //       _buildButton(Colors.red, "Reject"),
                                            //     ],
                                            //   ),
                                            // ],
                                          ],
                                        );
                                      },
                                      // children: [
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text("Quantity :",
                                      //           style: TextStyle(
                                      //               fontSize: 20.sp,
                                      //               fontWeight: FontWeight.bold)),
                                      //       Obx(() => GestureDetector(
                                      //             onTap: () {
                                      //               bagQCController.quantitySwitch.value =
                                      //                   !bagQCController
                                      //                       .quantitySwitch.value;
                                      //             },
                                      //             child: AnimatedContainer(
                                      //               duration: Duration(milliseconds: 300),
                                      //               width: 60.sp,
                                      //               height: 30.sp,
                                      //               padding: EdgeInsets.symmetric(
                                      //                   horizontal: 4),
                                      //               decoration: BoxDecoration(
                                      //                 color: bagQCController
                                      //                         .quantitySwitch.value
                                      //                     ? Colors.green
                                      //                     : Colors.grey.shade400,
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(20),
                                      //               ),
                                      //               child: Align(
                                      //                 alignment: bagQCController
                                      //                         .quantitySwitch.value
                                      //                     ? Alignment.centerRight
                                      //                     : Alignment.centerLeft,
                                      //                 child: Container(
                                      //                   width: 45,
                                      //                   alignment: Alignment.center,
                                      //                   child: Text(
                                      //                     bagQCController
                                      //                             .quantitySwitch.value
                                      //                         ? "YES"
                                      //                         : "No",
                                      //                     style: TextStyle(
                                      //                       color: Colors.white,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontSize: 12,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )),
                                      //     ],
                                      //   ),
                                      //   Utils.addGap(10),
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text("Weight :",
                                      //           style: TextStyle(
                                      //               fontSize: 20.sp,
                                      //               fontWeight: FontWeight.bold)),
                                      //       Obx(() => GestureDetector(
                                      //             onTap: () {
                                      //               bagQCController.weightSwitch.value =
                                      //                   !bagQCController
                                      //                       .weightSwitch.value;
                                      //             },
                                      //             child: AnimatedContainer(
                                      //               duration: Duration(milliseconds: 300),
                                      //               width: 60.sp,
                                      //               height: 30.sp,
                                      //               padding: EdgeInsets.symmetric(
                                      //                   horizontal: 4),
                                      //               decoration: BoxDecoration(
                                      //                 color: bagQCController
                                      //                         .weightSwitch.value
                                      //                     ? Colors.green
                                      //                     : Colors.grey.shade400,
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(20),
                                      //               ),
                                      //               child: Align(
                                      //                 alignment: bagQCController
                                      //                         .weightSwitch.value
                                      //                     ? Alignment.centerRight
                                      //                     : Alignment.centerLeft,
                                      //                 child: Container(
                                      //                   width: 45,
                                      //                   alignment: Alignment.center,
                                      //                   child: Text(
                                      //                     bagQCController
                                      //                             .weightSwitch.value
                                      //                         ? "YES"
                                      //                         : "No",
                                      //                     style: TextStyle(
                                      //                       color: Colors.white,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontSize: 12,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )),
                                      //     ],
                                      //   ),
                                      //   Utils.addGap(10),
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text("Size :",
                                      //           style: TextStyle(
                                      //               fontSize: 20.sp,
                                      //               fontWeight: FontWeight.bold)),
                                      //       Obx(() => GestureDetector(
                                      //             onTap: () {
                                      //               bagQCController.sizeSwitch.value =
                                      //                   !bagQCController.sizeSwitch.value;
                                      //             },
                                      //             child: AnimatedContainer(
                                      //               duration: Duration(milliseconds: 300),
                                      //               width: 60.sp,
                                      //               height: 30.sp,
                                      //               padding: EdgeInsets.symmetric(
                                      //                   horizontal: 4),
                                      //               decoration: BoxDecoration(
                                      //                 color:
                                      //                     bagQCController.sizeSwitch.value
                                      //                         ? Colors.green
                                      //                         : Colors.grey.shade400,
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(20),
                                      //               ),
                                      //               child: Align(
                                      //                 alignment:
                                      //                     bagQCController.sizeSwitch.value
                                      //                         ? Alignment.centerRight
                                      //                         : Alignment.centerLeft,
                                      //                 child: Container(
                                      //                   width: 45,
                                      //                   alignment: Alignment.center,
                                      //                   child: Text(
                                      //                     bagQCController.sizeSwitch.value
                                      //                         ? "YES"
                                      //                         : "No",
                                      //                     style: TextStyle(
                                      //                       color: Colors.white,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontSize: 12,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )),
                                      //     ],
                                      //   ),
                                      //   Utils.addGap(10),
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text("Aesthetics :",
                                      //           style: TextStyle(
                                      //               fontSize: 20.sp,
                                      //               fontWeight: FontWeight.bold)),
                                      //       Obx(() => GestureDetector(
                                      //             onTap: () {
                                      //               bagQCController
                                      //                       .aestheticsSwitch.value =
                                      //                   !bagQCController
                                      //                       .aestheticsSwitch.value;
                                      //             },
                                      //             child: AnimatedContainer(
                                      //               duration: Duration(milliseconds: 300),
                                      //               width: 60.sp,
                                      //               height: 30.sp,
                                      //               padding: EdgeInsets.symmetric(
                                      //                   horizontal: 4),
                                      //               decoration: BoxDecoration(
                                      //                 color: bagQCController
                                      //                         .aestheticsSwitch.value
                                      //                     ? Colors.green
                                      //                     : Colors.grey.shade400,
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(20),
                                      //               ),
                                      //               child: Align(
                                      //                 alignment: bagQCController
                                      //                         .aestheticsSwitch.value
                                      //                     ? Alignment.centerRight
                                      //                     : Alignment.centerLeft,
                                      //                 child: Container(
                                      //                   width: 45,
                                      //                   alignment: Alignment.center,
                                      //                   child: Text(
                                      //                     bagQCController
                                      //                             .aestheticsSwitch.value
                                      //                         ? "YES"
                                      //                         : "No",
                                      //                     style: TextStyle(
                                      //                       color: Colors.white,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontSize: 12,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )),
                                      //     ],
                                      //   ),
                                      //   Utils.addGap(10),
                                      //   Row(
                                      //     children: [
                                      //       _buildButton(Colors.green, "IN"),
                                      //       SizedBox(
                                      //           width: 12), // spacing between buttons
                                      //       _buildButton(Colors.red, "Reject"),
                                      //     ],
                                      //   ),
                                      // ],
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      _buildButton(
                                        Colors.green,
                                        "In",
                                        () {
                                          if (bagQCController.firstStatus.value &&
                                              bagQCController
                                                  .secondStatus.value &&
                                              bagQCController
                                                  .thirdStatus.value &&
                                              bagQCController
                                                  .fourthStatus.value) {
                                            bagQCController.qcEntryApiCall(
                                                isInward: 1,
                                                firstStatus: bagQCController
                                                            .firstStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                secondStatus: bagQCController
                                                            .secondStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                thirdStatus: bagQCController
                                                            .thirdStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                fourthStatus: bagQCController
                                                            .fourthStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                context: context);
                                          } else {
                                            Utils.showToast(
                                                "Please Select All Parameters as Yes ");
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 12.sp,
                                      ),
                                      _buildButton(
                                        Colors.red,
                                        "Out",
                                        () {
                                          {
                                            bagQCController.qcEntryApiCall(
                                                isInward: 2,
                                                firstStatus: bagQCController
                                                            .firstStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                secondStatus: bagQCController
                                                            .secondStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                thirdStatus: bagQCController
                                                            .thirdStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                fourthStatus: bagQCController
                                                            .fourthStatus
                                                            .value ==
                                                        true
                                                    ? 1
                                                    : 0,
                                                context: context);
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                  //   Row(
                                  //     children: [
                                  //       _buildButton(Colors.green, "IN"),
                                  //       SizedBox(
                                  //           width: 12), // spacing between buttons
                                  //       _buildButton(Colors.red, "Reject"),
                                  //     ],
                                  //   ),
                                  // ],
                                ]),
                              ),
                            ),
                          ),

                          Utils.addGap(16),

                          // Uncomment this to show the status timeline
                          // _statusTable(),
                        ],
                      ),
                    ),
                  )),
      );
    });
  }

  Widget _switchButton(int index) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 50.sp,
        height: 25.sp,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: index == 0
            ? BoxDecoration(
                color: bagQCController.firstStatus.value
                    ? Colors.green
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              )
            : index == 1
                ? BoxDecoration(
                    color: bagQCController.secondStatus.value
                        ? Colors.green
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  )
                : index == 2
                    ? BoxDecoration(
                        color: bagQCController.thirdStatus.value
                            ? Colors.green
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      )
                    : index == 3
                        ? BoxDecoration(
                            color: bagQCController.fourthStatus.value
                                ? Colors.green
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          )
                        : BoxDecoration(
                            color: bagQCController.quantitySwitch.value
                                ? Colors.green
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
        child: index == 0
            ? Align(
                alignment: bagQCController.firstStatus.value
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 45,
                  alignment: Alignment.center,
                  child: Text(
                    bagQCController.firstStatus.value ? "YES" : "No",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                    ),
                  ),
                ),
              )
            : index == 1
                ? Align(
                    alignment: bagQCController.secondStatus.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 45,
                      alignment: Alignment.center,
                      child: Text(
                        bagQCController.secondStatus.value ? "YES" : "No",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                        ),
                      ),
                    ),
                  )
                : index == 2
                    ? Align(
                        alignment: bagQCController.thirdStatus.value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 45,
                          alignment: Alignment.center,
                          child: Text(
                            bagQCController.thirdStatus.value ? "YES" : "No",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                            ),
                          ),
                        ),
                      )
                    : index == 3
                        ? Align(
                            alignment: bagQCController.fourthStatus.value
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 45,
                              alignment: Alignment.center,
                              child: Text(
                                bagQCController.fourthStatus.value
                                    ? "YES"
                                    : "No",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: bagQCController.quantitySwitch.value
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 45,
                              alignment: Alignment.center,
                              child: Text(
                                bagQCController.quantitySwitch.value
                                    ? "YES"
                                    : "No",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                                ),
                              ),
                            ),
                          ));
  }

  Widget _buildIconButton(IconData icon, Color color, String label) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
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

  Widget _buildButton(Color color, String label, VoidCallback onTap) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: isTablet ? 10.sp : 8.sp, // Tablet vs Mobile size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bagCard(String code, String time, int urgency) {
    Color urgencyColor = bagQCController.priority == "1"
        ? Colors.red.shade700
        : bagQCController.priority == "2"
            ? Colors.orange.shade700
            : bagQCController.priority == "3"
                ? Colors.yellow.shade700
                : bagQCController.priority == "4"
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

  Widget _detailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          text: "$label ",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp),
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
