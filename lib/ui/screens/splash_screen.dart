import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/image_paths.dart';
import '../../common/utils/utility.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
  }

  void checkVersion() async {
    splashController.version.value = await Utils.getAppVersion();
    print("App version: ${splashController.version}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    var width = MediaQuery.of(context).size.height;


      return Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              */ /*Image.asset(
                AppIcons.logo,
                height: height,
                width: width,
              ),*/ /*
              Text(
                "Logo",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ],
          ));

  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppIcons.common_bg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Image.asset(
                AppIcons.logo,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
