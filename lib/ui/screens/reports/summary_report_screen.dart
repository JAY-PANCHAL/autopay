import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_constants.dart';
import '../../../network/model/summary_report_model.dart';

class SummaryReportScreen extends StatefulWidget {
  const SummaryReportScreen({super.key});

  @override
  State<SummaryReportScreen> createState() => _SummaryReportScreenState();
}

class _SummaryReportScreenState extends State<SummaryReportScreen> {
  // CONTROLLERS
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  String selectedFilter = "Today";

  // SAMPLE LIST
  final List<SummaryReportModel> stoppageList = [
    SummaryReportModel(
      vehicleNo: "BR01JF1231",
      distanceKm: 60.48,
      engineHours: "01:19:07 hrs",
      runningHours: "01:19:07 hrs",
      stopHours: "01:19:07 hrs",
      idleHours: "01:19:07 hrs",
      startLocation:
          "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      endLocation:
          "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      startingKm: "000023815",
      endingKm: "000023875",
      avgSpeed: 45.57,
      maxSpeed: 86,
      fuelSpent: 0,
    ),
    SummaryReportModel(
      vehicleNo: "BR02MJ9982",
      distanceKm: 42.12,
      engineHours: "00:52:44 hrs",
      runningHours: "00:30:20 hrs",
      stopHours: "00:11:13 hrs",
      idleHours: "00:11:11 hrs",
      startLocation: "Gandhi Maidan, Patna, Bihar, India",
      endLocation: "Rajendra Nagar, Patna, Bihar, India",
      startingKm: "000045710",
      endingKm: "000045755",
      avgSpeed: 38.4,
      maxSpeed: 72,
      fuelSpent: 1.2,
    ),
  ];

  // DATE PICKER FUNCTION
  Future<void> pickDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      controller.text = DateFormat("dd-MM-yyyy").format(picked);
      setState(() {});
    }
  }

  // FILTER BUTTON BUILDER
  Widget filterButton(String label) {
    final bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() => selectedFilter = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.appblue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.appblue),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // IGNITION CARD
  Widget ignitionCard(Map item) {
    final bool on = item["status"] == "On";

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.iconbg, // 🔥 background color
                      borderRadius: BorderRadius.circular(16), // fully rounded
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.white, // 🔥 icon color
                      size: 18,
                    ),
                  ),

                  //   Icon(Icons.directions_car, color: Colors.orange, size: 26),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                item["vehicle"],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Icon(
                on
                    ? Icons.power_settings_new
                    : Icons.power_settings_new_outlined,
                color: on ? Colors.green : Colors.red,
                size: 22,
              ),
              const SizedBox(width: 6),
              Text(
                "Ignition ${on ? "On" : "Off"}",
                style: TextStyle(
                  color: on ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // TIME ROW
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.iconbg, // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.timer,
                  color: Colors.white, // 🔥 icon color
                  size: 18,
                ),
              ),

              //  const Icon(Icons.timer, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(item["time"], style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // LOCATION
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // helps multi-line alignment
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.iconbg, // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white, // 🔥 icon color
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),

              // 🔥 This prevents overflow
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    item["location"],
                    style: const TextStyle(fontSize: 14),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // MAIN UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
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
                      "Summary Report",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // SEARCH FIELD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        height: 55,
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
                        child: TextField(
                          controller: searchCtrl,
                          decoration: const InputDecoration(
                            hintText: "Search Vehicle",

                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // FILTER BUTTONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filterButton("Today"),
                          filterButton("Yesterday"),
                          filterButton("Week"),
                          filterButton("Month"),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // DATE PICKERS
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => pickDate(fromDateCtrl),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      fromDateCtrl.text.isEmpty
                                          ? "Select Date"
                                          : fromDateCtrl.text,
                                    ),
                                    const Icon(Icons.calendar_today, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => pickDate(toDateCtrl),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      toDateCtrl.text.isEmpty
                                          ? "Select Date"
                                          : toDateCtrl.text,
                                    ),
                                    const Icon(Icons.calendar_today, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                /*  ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: tripList.length,
                  itemBuilder: (context, index) {
                    return VehicleTripCard( tripList[index]);
                  },
                ),*/
                ...stoppageList.map((item) => VehicleTripCard(item)),

                //  Container(height: 600,)

                // LIST OF IGNITION RECORDS
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget VehicleTripCard(SummaryReportModel trip) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle + Distance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.directions_car, color: Colors.brown, size: 30),
                  SizedBox(width: 8),
                  Text(
                    trip.vehicleNo,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.route, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    "${trip.distanceKm} km",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(),

          // Hours Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _hours("Engine hours", trip.engineHours, Colors.purple),
              _hours("Running", trip.runningHours, Colors.green),
              _hours("Stop", trip.stopHours, Colors.red),
              _hours("Idle", trip.idleHours, Colors.amber),
            ],
          ),

          SizedBox(height: 12),
          Divider(),

          // Start Location
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: 6),
              Expanded(
                child: Text(trip.startLocation, style: TextStyle(fontSize: 13)),
              ),
            ],
          ),

          SizedBox(height: 10),

          // KM Boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _kmBox("Starting KM", trip.startingKm, Colors.green.shade100),
              Icon(Icons.more_horiz, color: Colors.grey),
              _kmBox("Ending KM", trip.endingKm, Colors.red.shade100),
            ],
          ),

          SizedBox(height: 10),

          // End Location
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 6),
              Expanded(
                child: Text(trip.endLocation, style: TextStyle(fontSize: 13)),
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(),

          // Bottom Stats
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _stat(Icons.speed, "Avg: ${trip.avgSpeed} kmph"),
                const SizedBox(width: 16),
                _stat(Icons.flash_on, "Max.speed: ${trip.maxSpeed} kmph"),
                const SizedBox(width: 16),
                _stat(
                  Icons.local_gas_station,
                  "Fuel Spent : ${trip.fuelSpent} L",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hours(String title, String time, Color color) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.black54)),
        SizedBox(height: 4),
        Container(width: 60, height: 3, color: color),
        SizedBox(height: 4),
        Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _kmBox(String title, String km, Color bg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.black54)),
          SizedBox(height: 4),
          Text(km, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.orange),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
