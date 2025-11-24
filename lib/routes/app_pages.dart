import 'package:autopay/ui/screens/settings/customer_list_screen.dart';
import 'package:autopay/ui/screens/signup/otp_verify_screen.dart';
import 'package:autopay/ui/screens/signup/signup_dealer_screen.dart';
import 'package:autopay/ui/screens/signup/signup_vendor_screen.dart';
import 'package:get/get.dart';
import '../ui/screens/dashboard/dashboard_screen.dart';
import '../ui/screens/settings/add_customers_screen.dart';
import '../ui/screens/settings/add_expense_screen.dart';
import '../ui/screens/settings/expense_screen.dart';
import '../ui/screens/settings/geofence_screen.dart';
import '../ui/screens/signup/get_started_screen.dart';
import '../ui/screens/signup/login_screen.dart';
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
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => OtpVerificationScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.getstarted,
      page: () => GetStartedScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.signupDistributorScreen,
      page: () => SignupDistributorScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.signupDealerScreen,
      page: () => SignupDealerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.signupVendorScreen,
      page: () => SignupVendorScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.signupCustomerScreen,
      page: () => SignupCustomerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => MainScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.customerListScreen,
      page: () => CustomersListScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.addNewCustomerScreen,
      page: () => AddNewCustomerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.expenseScreen,
      page: () => ExpenseScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.addExpenseScreen,
      page: () => AddExpenseScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.geofenceHomeScreen,
      page: () => GeofenceHomeScreen(),
      transition: Transition.rightToLeft,
    ),

  ];
}
