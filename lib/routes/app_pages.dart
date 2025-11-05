import 'package:autopay/controller/signup_customer_controller.dart';
import 'package:autopay/ui/screens/signup/signup_dealer_screen.dart';
import 'package:autopay/ui/screens/signup/signup_vendor_screen.dart';
import 'package:get/get.dart';

import '../bluetooth/bluetooth.dart';
import '../ui/screens/get_started_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/signup/signup_costomer_screen.dart';
import '../ui/screens/signup/signup_distributor_screen.dart';
import '../ui/screens/splash_screen.dart';

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
        name: Routes.getstarted,
        page: () => GetStartedScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.signupDistributorScreen,
        page: () => SignupDistributorScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.signupDealerScreen,
        page: () => SignupDealerScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.signupVendorScreen,
        page: () => SignupVendorScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.signupCustomerScreen,
        page: () => SignupCustomerScreen(),
        transition: Transition.downToUp),
  ];
}
