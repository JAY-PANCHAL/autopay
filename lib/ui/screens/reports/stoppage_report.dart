import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_constants.dart';

class StoppageReportScreen extends StatefulWidget {
  const StoppageReportScreen({super.key});

  @override
  State<StoppageReportScreen> createState() => _StoppageReportScreenState();
}

class _StoppageReportScreenState extends State<StoppageReportScreen> {
  // CONTROLLERS
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  String selectedFilter = "Today";

  // SAMPLE LIST
  List<Map<String, dynamic>> ignitionList = [
    {
      "vehicle": "BR01JF1231",
      "time": "Oct 29, 2025 01:19:07 PM",
      "location":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "status": "On",
    },
    {
      "vehicle": "BR01JF1231",
      "time": "Oct 29, 2025 01:19:07 PM",
      "location":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "status": "Off",
    },
    {
      "vehicle": "BR01JF1231",
      "time": "Oct 29, 2025 01:19:07 PM",
      "location":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "status": "On",
    },
    {
      "vehicle": "BR01JF1231",
      "time": "Oct 29, 2025 01:19:07 PM",
      "location":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "status": "Off",
    },
  ];
  final List<Map<String, dynamic>> tripList = [
    {
      "vehicle": "BR01JF1231",
      "duration": "0 h 38 m",
      "startTime": "Oct 29,2025 01:19:07 PM",
      "endTime": "Oct 29,2025 01:19:07 PM",
      "address":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "vehicleIconColor": Color(0xFFB66A0A),
    },
    {
      "vehicle": "BR01JF1231",
      "duration": "0 h 38 m",
      "startTime": "Oct 29,2025 01:19:07 PM",
      "endTime": "Oct 29,2025 01:19:07 PM",
      "address":
      "Dhaneshwar Ghat Road, Durgasthan, Nalanda, 803101, Bihar Sharif, India",
      "vehicleIconColor": Color(0xFF2962FF),
    },
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
                children:  [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:AppColors.iconbg,   // 🔥 background color
                      borderRadius: BorderRadius.circular(16), // fully rounded
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.white,   // 🔥 icon color
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
                  color: AppColors.iconbg,   // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.timer,
                  color: Colors.white,   // 🔥 icon color
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
            crossAxisAlignment: CrossAxisAlignment.start,   // helps multi-line alignment
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.iconbg,   // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,   // 🔥 icon color
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
                      "Stoppage Report",
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
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      /*ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: tripList.length,
                        itemBuilder: (context, index) {
                          final item = tripList[index];
                          return tripItem(item);
                        },
                      ),*/
                      ...tripList.map((item) => tripItem(item)),


                      const SizedBox(height: 25),
                    ],
                  ),
                ),


                const SizedBox(height: 25),
               // Container(height: 600,)

                // LIST OF IGNITION RECORDS
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget tripItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:AppColors.iconbg,   // 🔥 background color
                      borderRadius: BorderRadius.circular(16), // fully rounded
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.white,   // 🔥 icon color
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item["vehicle"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Text(
                "Duration: ${item["duration"]}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          /// START TIME
          Row(
            children:  [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color:  Colors.green,   // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.timer,
                  color: Colors.white,   // 🔥 icon color
                  size: 18,
                ),
              ),
           //   Icon(Icons.circle, color: Colors.green, size: 16),
              SizedBox(width: 10),
              Text(item["startTime"]),

            ],
          ),

          const SizedBox(height: 12),

          /// END TIME
          Row(
            children:  [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color:  Colors.red,   // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.timer,
                  color: Colors.white,   // 🔥 icon color
                  size: 18,
                ),
              ),
             // Icon(Icons.circle, color: Colors.red, size: 16),
              SizedBox(width: 10),
              Text(item["endTime"]),
            ],
          ),


          const SizedBox(height: 12),

          /// ADDRESS
          Row(
            children:  [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color:AppColors.iconbg,   // 🔥 background color
                  borderRadius: BorderRadius.circular(16), // fully rounded
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,   // 🔥 icon color
                  size: 18,
                ),
              ),
             // Icon(Icons.location_on, color: Colors.brown, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item["address"],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

}
