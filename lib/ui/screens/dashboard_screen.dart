import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// Assuming MainScreenController.dart is the same
class MainScreenController extends GetxController {
  var currentIndex = 2.obs;

  // This controller is managed by the PersistentTabView now, but we keep the logic minimal
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

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Setting Content - State Preserved"));
  }
}
// ------------------------------------------------------------------

// Utility constants (AppColors and Styles)
const AppColors = Color(0xFF4C87B5);

class Styles {
  static TextStyle textFontRegular({
    double size = 14,
    FontWeight weight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color);
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.put(MainScreenController());

  // Define the list of screen widgets for the PersistentTabView
  final List<Widget> screens = const [
    DashboardScreen(),
    MapScreen(),
    HomeScreen(),
    ReportsScreen(),
    SettingScreen(),
  ];

  // --- Build the Custom Items ---
  List<PersistentTabConfig> get _tabs => [
    _buildTabItem(Icons.grid_view_outlined, "Dashboard", 0),
    _buildTabItem(Icons.location_on, "Map", 1),
    _buildTabItem(Icons.home, "Home", 2),
    _buildTabItem(Icons.bar_chart, "Reports", 3),
    _buildTabItem(Icons.settings, "Setting", 4),
  ];

  // Helper to build a single PersistentTabConfig
  PersistentTabConfig _buildTabItem(IconData icon, String label, int index) {
    return PersistentTabConfig(
      screen: screens[index], // Assign the correct screen
      item: ItemConfig(
        title: label,
        icon: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24.sp),
              // Custom Blue Indicator Line
              Container(
                margin: EdgeInsets.only(top: 2.sp),
                height: 3.sp,
                width: 30.sp,
                color: controller.currentIndex.value == index
                    ? AppColors
                    : Colors.transparent,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.sp),
                child: Text(
                  label,
                  style: Styles.textFontRegular(
                    size: 12.sp,
                    weight: FontWeight.w500,
                    // Color handling is done here for the custom look
                    color: controller.currentIndex.value == index
                        ? AppColors
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Item configuration for when the item is active/inactive
        activeForegroundColor: AppColors, // Main color for the tab bar
        inactiveForegroundColor: Colors.black,
      ),
      // Set initial state
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

      // --- Configuration to match the screenshot look and feel ---
      navBarBuilder: (navBarConfig) => Style15BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
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
      ),

      // Required settings for persistence
      stateManagement: true,
      hideNavigationBar: false,
    );
  }
}
