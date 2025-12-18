import 'dart:convert';
import 'dart:io';
import 'package:autopay/common/utils/storage_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../network/model/country_model.dart';
import '../../routes/app_pages.dart';
import 'Styles.dart';
import 'app_constants.dart';
import 'color_constants.dart';
import 'dimensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Utils {
  static final isTablet = checkTablet();
  //Predefined heights
  static final height4 = getHeight(8.h, 4.h);
  static final height6 = getHeight(10.h, 6.h);
  static final height8 = getHeight(12.h, 8.h);
  static final height10 = getHeight(14.h, 10.h);
  static final height12 = getHeight(16.h, 12.h);
  static final height14 = getHeight(18.h, 14.h);
  static final height16 = getHeight(20.h, 16.h);
  static final height18 = getHeight(22.h, 18.h);
  static final height20 = getHeight(24.h, 20.h);
  static final height22 = getHeight(26.h, 22.h);
  static final height24 = getHeight(28.h, 24.h);
  static final height26 = getHeight(30.h, 26.h);
  static final height28 = getHeight(32.h, 28.h);
  static final height30 = getHeight(34.h, 30.h);
  static final height32 = getHeight(36.h, 32.h);
  static final height34 = getHeight(38.h, 34.h);
  static final height36 = getHeight(40.h, 32.h);
  static final height38 = getHeight(42.h, 32.h);
  static final height40 = getHeight(44.h, 32.h);
  static final height42 = getHeight(46.h, 32.h);
  static final height44 = getHeight(48.h, 32.h);
  static final height46 = getHeight(50.h, 32.h);
  static final height48 = getHeight(52.h, 32.h);
  static final height50 = getHeight(54.h, 32.h);
  static final height52 = getHeight(56.h, 32.h);
  static final height54 = getHeight(58.h, 32.h);
  static final height56 = getHeight(60.h, 32.h);
  //Predefined widths
  static final width4 = getWidth(8.w, 4.w);
  static final width6 = getWidth(10.w, 6.w);
  static final width8 = getWidth(12.w, 8.w);
  static final width10 = getWidth(14.w, 10.w);
  static final width12 = getWidth(16.w, 12.w);
  static final width14 = getWidth(18.w, 14.w);
  static final width16 = getWidth(20.w, 16.w);
  static final width18 = getWidth(22.w, 18.w);
  static final width20 = getWidth(24.w, 20.w);
  static final width22 = getWidth(26.w, 22.w);
  static final width24 = getWidth(28.w, 24.w);
  static final width26 = getWidth(30.w, 26.w);
  static final width28 = getWidth(32.w, 28.w);
  static final width30 = getWidth(34.w, 30.w);
  static final width32 = getWidth(36.w, 32.w);
  static final width34 = getWidth(38.w, 34.w);
  //Predefined sizes
  static final size4 = getSize(8.w, 4.w);
  static final size6 = getSize(10.w, 6.w);
  static final size8 = getSize(12.w, 8.w);
  static final size10 = getSize(14.sp, 10.sp);
  static final size12 = getSize(16.sp, 12.sp);
  static final size14 = getSize(18.sp, 14.sp);
  static final size16 = getSize(20.sp, 16.sp);
  static final size18 = getSize(22.sp, 18.sp);
  static final size20 = getSize(24.sp, 20.sp);
  static final size22 = getSize(26.sp, 22.sp);
  static final size24 = getSize(28.sp, 24.sp);
  static final size26 = getSize(30.sp, 26.sp);
  static final size28 = getSize(32.sp, 28.sp);
  static final size30 = getSize(34.sp, 30.sp);
  static final size32 = getSize(36.sp, 32.sp);
  static final size34 = getSize(38.sp, 34.sp);
  static final size36 = getSize(40.sp, 36.sp);
  static final size38 = getSize(42.sp, 38.sp);
  static final size40 = getSize(44.sp, 40.sp);
  static final size42 = getSize(46.sp, 42.sp);
  static final size44 = getSize(48.sp, 44.sp);
  static final size46 = getSize(50.sp, 46.sp);
  static final size48 = getSize(52.sp, 48.sp);
  static final size50 = getSize(54.sp, 50.sp);
  static final size52 = getSize(56.sp, 52.sp);
  static final size54 = getSize(58.sp, 54.sp);
  static final size56 = getSize(60.sp, 56.sp);
  static final size58 = getSize(62.sp, 58.sp);
  static final size60 = getSize(64.sp, 60.sp);
  static final size62 = getSize(66.sp, 62.sp);
  static final size64 = getSize(68.sp, 64.sp);
  static final size66 = getSize(70.sp, 66.sp);
  static final size68 = getSize(72.sp, 68.sp);
  static final size70 = getSize(74.sp, 70.sp);
  static final size72 = getSize(76.sp, 72.sp);
  //Check if it is a table10
  static bool checkTablet() {
    final screenWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return screenWidth > 600;
  }

  static Text normalText(String text,
      {double size = 10,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      style: Styles.textFontRegular(
          size: size.sp, weight: fontWeight, color: color),
    );
  }

  static double getHeight(double tabletSize, double normalSize) {
    return isTablet ? tabletSize : normalSize;
  }

  static double getWidth(double tabletSize, double normalSize) {
    return isTablet ? tabletSize : normalSize;
  }

  static double getSize(double tabletSize, double normalSize) {
    return isTablet ? tabletSize : normalSize;
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}";
  }
/*
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (kDebugMode) {
        print('Internet mode : mobile');
      }
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (kDebugMode) {
        print('Internet mode : wifi');
      }
      return true;
    }
    return false;
  }
*/
 static  Future<List<Countries>> getCountriesFromStorage() async {
    final jsonString = await StorageService().getString(AppConstants.countriespr);

    if (jsonString.isEmpty) {
      return [];
    }

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Countries.fromJson(e)).toList();
  }

  static String getCurrentTimeFormatted() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    return formattedTime;
  }

  static String replaceNullZero(String? str) {
    if (str == null || str.trim().isEmpty || str.toLowerCase() == "null") {
      return "0";
    }
    return str;
  }

  static void showSnackBar(error, context, onRetry) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(error),
      duration: const Duration(hours: 1),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () {
          onRetry();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getDeviceType() {
    //1 for iOS, 2 for Android
    if (Platform.isIOS) {
      // import 'dart:io'
      return "1";
    } else {
      return "2";
    }
  }

  static loader(context) {
    return Center(
      child: /*Container(
          height: 60.0,
        width: 60.0,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(30)),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.appblue,
          ),
        ),
      )*/
          LoadingAnimationWidget.inkDrop(
        color: AppColors.appblue,
        size: 60,
      ),
    );
  }

  static bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static showToast(message) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15.0);

  static String convertiEnDateEtHeure(n) {
    String date = DateFormat('yyyy-MM-dd').format(n);
    return date;
  }

  void snackBar(String msg, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Widget buildProgressIndicator() {
    return Container(
      height: Dimensions.screenHeight,
      color: AppColors.black.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.blue,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
    );
  }

  static Widget loadNetworkImage({url, mWidth, fit, mHeight}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: mWidth,
      height: mHeight,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }

  static addSmallGap10() {
    return SizedBox(
      height: 10.sp,
    );
  }

  static addSmallGap5() {
    return SizedBox(
      height: 5,
    );
  }

  static addGap15() {
    return SizedBox(
      height: 15.sp,
    );
  }

  static addMediumGap() {
    return SizedBox(
      height: 20.sp,
    );
  }

  static addGap(int size) {
    return SizedBox(
      height: size.h,
    );
  }

  static addHGap(int size) {
    return SizedBox(
      width: size.w,
    );
  }

  static checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static addLargeGap() {
    return SizedBox(
      height: 30.sp,
    );
  }

  // static Future<UserModel> getLoginData() async {
  //   var value = await StorageService.to.getString(AppConstants.loginPref);

  //   if (value != "") {
  //     var data = jsonDecode(value);
  //     UserModel usermodel = UserModel.fromJson(data);
  //     return usermodel;
  //   } else {
  //     return UserModel();
  //   }
  // }

  static Future<bool> isLoggedIn() async {
    var isloggedInPref =
        await StorageService.to.getBool(AppConstants.isLoginPref);
    print(isloggedInPref);
    bool isLogin = isloggedInPref ? true : false;
    return isLogin;
  }

  /// ✨ Custom log with a dynamic message
  static void logCustom(String title, String message) {
    print("\n✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨");
    print("✨ $title ✨");
    print("📌 $message");
    print("✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨\n");
  }

  static void getLogoutDialog(context) {
    Platform.isAndroid
        ? Get.dialog(
            AlertDialog(
              title: Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  child: Text(AppConstants.yes),
                  onPressed: () {
                    Navigator.of(Get.overlayContext!, rootNavigator: true)
                        .pop(AppConstants.logout); //  Get.back();
                    StorageService().clearData();
                    Get.offAllNamed(Routes.login);
                    // Get.offNamedUntil(Routes.splash, (route) => false);
                  },
                ),
                TextButton(
                  child: Text(AppConstants.no),
                  onPressed: () {
                    Navigator.of(Get.overlayContext!, rootNavigator: true)
                        .pop(AppConstants.logout);
                  },
                ),
              ],
            ),
            barrierDismissible: false,
          )
        : Get.dialog(
            CupertinoAlertDialog(
              title: Text('Are you sure you want to logout?'),
              actions: [
                CupertinoDialogAction(
                  child: Text(AppConstants.yes),
                  onPressed: () {
                    Navigator.of(Get.overlayContext!, rootNavigator: true)
                        .pop(AppConstants.logout);
                    StorageService().clearData();
                    Get.offNamedUntil(Routes.splash, (route) => false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(AppConstants.no),
                  onPressed: () {
                    Navigator.of(Get.overlayContext!, rootNavigator: true)
                        .pop(AppConstants.logout);
                  },
                )
              ],
            ),
            barrierDismissible: false,
          );
  }

  static void getReasonDialog(BuildContext context, String reason,bool isTablet) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 12,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top header bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryAppColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  "Reason",
                  style: TextStyle(
                    fontSize:isTablet==true?16.sp:14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Circle icon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.info_outline,
                  color: Colors.blueAccent, size: 32),
            ),

            const SizedBox(height: 20),

            // Reason text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                reason,
                style: TextStyle(
                  fontSize:isTablet==true?14.sp:12.sp,
                  color: Colors.grey.shade800,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      barrierDismissible: true,
      transitionCurve: Curves.easeOutBack,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  static svgFile({fileName, height, width, color}) => SvgPicture.asset(
        fileName,
        height: height,
        width: width,
        color: color,
      );

  static svgFileWithoutColor({fileName, height, width}) => SvgPicture.asset(
        fileName,
        height: height,
        width: width,
      );

  static void getDeleteNotificationDialog(context, onYesPressed, onNoPressed) {
    Platform.isAndroid
        ? Get.dialog(
            AlertDialog(
              title: Text('Are you sure you want to delete this notification?'),
              actions: [
                TextButton(
                    child: Text(AppConstants.yes),
                    onPressed:
                        onYesPressed /*() {
              Navigator.of(Get.overlayContext!, rootNavigator: true)
                  .pop(AppConstants.logout);                    //  Get.back();

            },*/
                    ),
                TextButton(
                  child: Text(AppConstants.no),
                  onPressed:
                      onNoPressed, /* () {
              Navigator.of(Get.overlayContext!, rootNavigator: true)
                  .pop(AppConstants.logout);                  },*/
                ),
              ],
            ),
            barrierDismissible: false,
          )
        : Get.dialog(
            CupertinoAlertDialog(
              title: Text('Are you sure you want to logout?'),
              actions: [
                CupertinoDialogAction(
                  child: Text(AppConstants.yes),
                  onPressed: onYesPressed,
                ),
                CupertinoDialogAction(
                  child: Text(AppConstants.no),
                  onPressed: onNoPressed,
                )
              ],
            ),
            barrierDismissible: false,
          );
  }

  static Widget callWidget(String phonenumber, Widget commonwidget) {
    return GestureDetector(
      onTap: () async {
        await launchPhone(phonenumber);
      },
      child: commonwidget,
    );
  }

  static commonWidgetWithUnderline(title, value, context) {
    return Visibility(
      visible: value != null && value != "",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${title}",
            style: Styles.textFontRegular(
                size: 14.sp, weight: FontWeight.w600, color: AppColors.appblue),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            padding: EdgeInsets.all(12.sp),
            margin: EdgeInsets.symmetric(
              vertical: 8.sp,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.sp),
                ),
                border: Border.all(color: AppColors.appblue)),
            child: Text(
              value,
              style: Styles.textFontRegular(
                  size: 14,
                  weight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
          ),
          Utils.addGap(10)
        ],
      ),
    );
  }

  static Widget emailWidget(String email, Widget commonwidget) {
    return GestureDetector(
      onTap: () async {
        await launchEmail(email);
      },
      child: commonwidget,
    );
  }

  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  // Function to launch phone dialer
  static Future<void> launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  static double parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String?) return double.tryParse(value ?? "") ?? 0.0;
    return 0.0;
  }

  static int parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double)
      return value.toInt(); // or round(), ceil(), floor() based on use case
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
