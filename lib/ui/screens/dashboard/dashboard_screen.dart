import 'package:autopay/ui/screens/dashboard/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';

// Assuming MainScreenController.dart
class MainScreenController extends GetxController {
  // Start at the 'Home' index (2)
  var currentIndex = 2.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}

// --- Placeholder Screen Widgets (Define your actual screens here) ---
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Dashboard Content - State Preserved"));
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Map Content - State Preserved"));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home Content (Speedometer goes here)"));
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Reports Content - State Preserved"));
  }
}



// --- MainScreen Widget ---
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.put(MainScreenController());

  // Define the list of screen widgets for the PersistentTabView
  final List<Widget> screens = const [
    DashboardScreen(),
    MapScreen(),
    HomeScreen(),
    ReportsScreen(),
    AppSettingScreen(),
  ];

  // --- Build the Tab Configs ---
  List<PersistentTabConfig> get _tabs => [
    _buildTabConfig(Icons.grid_view_outlined, "Dashboard", 0),
    _buildTabConfig(Icons.location_on, "Map", 1),
    _buildTabConfig(Icons.home, "Home", 2),
    _buildTabConfig(Icons.bar_chart, "Reports", 3),
    _buildTabConfig(Icons.settings, "Setting", 4),
  ];

  // Helper to build a single PersistentTabConfig
  // NOTE: We don't need a custom 'icon' widget here, as we are creating the ENTIRE
  // tab bar custom look in the CustomNavBarWidget below.
  PersistentTabConfig _buildTabConfig(IconData icon, String label, int index) {
    return PersistentTabConfig(
      screen: screens[index], // Assign the correct screen
      item: ItemConfig(
        title: label,
        icon: Icon(icon), // Just a basic Icon for the config
        activeForegroundColor: AppColors.appblue,
        inactiveForegroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use the PersistentTabController to manage the index
    final PersistentTabController tabController = PersistentTabController(
      initialIndex: controller.currentIndex.value, // Start at Home (2)
    );

    // Listen to changes in the package's controller and update the GetX controller
    tabController.addListener(() {
      controller.changeTabIndex(tabController.index);
    });

    return PersistentTabView(
      controller: tabController,
      tabs: _tabs,
      navBarBuilder: (navBarConfig) => CustomNavBarWidget(
        config: navBarConfig,
        controller: controller, // Pass the GetX controller
      ),
      // Important for custom nav bar
      //navBarStyle: NavBarStyle.custom,
      // Required settings for persistence
      stateManagement: true,
      hideNavigationBar: false,
    );
  }
}

// --- Custom NavBar Widget for Full Control ---
class CustomNavBarWidget extends StatelessWidget {
  final NavBarConfig config;
  final MainScreenController controller;

  const CustomNavBarWidget({
    Key? key,
    required this.config,
    required this.controller,
  }) : super(key: key);

  // Helper to build a single item in the custom bar
  Widget _buildItem(ItemConfig item, bool isSelected, int index) {
    final Color color = isSelected
        ? item.activeForegroundColor
        : item.inactiveForegroundColor;
    final IconData icon = (item.icon as Icon).icon!;
    final String label = item.title!;

    return Expanded(
      child: InkWell(
        onTap: () {
          // This calls the package's onItemSelected which handles the screen change
          config.onItemSelected(index);
          // The MainScreen's listener will update the GetX controller
        },
        child: Container(
          // Ensure padding/height for the whole clickable area
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 1. Custom Blue Indicator Line (TOP)
              Container(
                margin: EdgeInsets.only(bottom: 4.sp), // Space below the line
                height: 3.sp,
                width: 50.sp,
                color: isSelected ? AppColors.appblue : Colors.transparent,
              ),
              // 2. Icon
              Icon(icon, color: color, size: 24.sp),
              // 3. Text
              Padding(
                padding: EdgeInsets.only(top: 2.sp),
                child: Text(
                  label,
                  style: Styles.textFontRegular(
                    size: 10.sp, // Adjusted size to fit well
                    weight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the GetX controller for the selected index
    return Obx(() {
      final int currentIndex = controller.currentIndex.value;
      return Container(
        height:
            70.sp +
            MediaQuery.of(context).padding.bottom, // Ensure sufficient height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        // Use a Row with Expanded for even spacing
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: () {
              // Immediately invoked function to handle the index counter
              int index = 0;
              return config.items.map((item) {
                final itemWidget = _buildItem(
                  item,
                  currentIndex == index,
                  index,
                );
                index++; // Increment the index after using it
                return itemWidget;
              }).toList();
            }(), // Call the function immediately
          ),
        ),
      );
    });
  }
}
