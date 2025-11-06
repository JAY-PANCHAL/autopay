import 'package:get/get.dart';

class MainScreenController extends GetxController {
  // Observable variable to store the index of the currently selected tab
  var currentIndex = 2.obs; // Start at index 2 (Home, as shown in the screenshot)

  // List of placeholder screens for the body of the Scaffold
  final List<String> screenTitles = const [
    "Dashboard Screen",
    "Map Screen",
    "Home Screen",
    "Reports Screen",
    "Setting Screen",
  ];

  // Method to change the current index
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}