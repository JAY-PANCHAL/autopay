import 'package:get/get.dart';

import '../bluetooth/bluetooth.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/milk_collection_screens/milk_collection_list_screen.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/todays_work_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.homeScreen,
        page: () => HomeScreen(),
        transition: Transition.downToUp),

  ];
}
