import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_track/controller/splash_controller.dart';
import '../../common/utils/image_paths.dart';
import '../../common/utils/utility.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());
  @override
  void initState() {
    //  getData();
    // checkVersion();
    super.initState();
  }

  void checkVersion() async {
    splashController.version.value = await Utils.getAppVersion();
    print("App version: ${splashController.version}");
  }

  /* getData() async {
    await splashController.getTokenApi();
  }
*/
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    var width = MediaQuery.of(context).size.height;

    return Obx(() {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.logo,
                height: height,
                width: width,
              ),
              Text(
                splashController.version.value,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ],
          ));
    });
  }
}
