import 'package:autopay/common/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightBlue1,
              AppColors.lightBlue2,
              AppColors.white,
            ],
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// ---------- Header ----------
              Row(
                children: [
                  SizedBox(width: 16.sp),
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
                    "Notifications",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final result = await showEventFilterDialog(context);
                      print(result); // List<String> → selected event names
                    },
                    child: Icon(
                      Icons.filter_alt,
                      size: 25.sp,
                      color: AppColors.appblue,
                    ),
                  ),
                  SizedBox(width: 20.sp),
                ],
              ),

              const SizedBox(height: 20),

              /// ---------- Tabs ----------
              Container(
                height: 50.sp,
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.redAccent,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: "Alerts(10)"),
                    Tab(text: "Announcements(0)"),
                    Tab(text: "Reminders(192)"),
                  ],
                ),
              ),

              /// ---------- TAB VIEW FIX ----------
              /// Must wrap in Expanded to stop overflow
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _notificationList(isBlueCard: true),
                    _emptyAnnouncements(),
                    _notificationList(isBlueCard: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>?> showEventFilterDialog(BuildContext context) {
    final List<String> events = [
      "All Event",
      "Command Result",
      "Device Online",
      "Device Unknown",
      "Device Offline",
      "Device Inactive",
      "Device Moving",
      "Device Stopped",
      "Device Overspeed",
      "Device Fuel Drop",
      "Device Fuel Increase",
      "Geofence Enter",
      "Geofence Exit",
      "Alarm",
      "Ignition On",
      "Ignition Off",
      "Maintenance",
    ];

    /// For selection tracking
    final ValueNotifier<List<String>> selected = ValueNotifier([]);

    return showDialog<List<String>>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(
                maxWidth: 380,
                maxHeight: 600, // auto-sized but with limit
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// --- EVENT LIST (SCROLLABLE) ---
                  Expanded(
                    child: ValueListenableBuilder<List<String>>(
                      valueListenable: selected,
                      builder: (_, selectedItems, __) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: events.length,
                          itemBuilder: (_, index) {
                            final item = events[index];
                            final isSelected = selectedItems.contains(item);

                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) {
                                if (v == true) {
                                  selected.value = [...selectedItems, item];
                                } else {
                                  selected.value =
                                      selectedItems.where((e) => e != item).toList();
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// --- BUTTONS ---
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // SAFE POP
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appblue,

                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(selected.value);
                          },
                          child: const Text("Export"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ============= Notification List =============
  Widget _notificationList({required bool isBlueCard}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isBlueCard
                ? const Color(0xFFE7F4FF)
                : const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isBlueCard ? Icons.notifications : Icons.notification_important,
                color: isBlueCard ? Colors.black : Colors.amber,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "BR01JF1231",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Your device is going to expire, please contact your service provider",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ============= Empty Announcements =============
  Widget _emptyAnnouncements() {
    return const Center(
      child: Text(
        "No announcements available",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
