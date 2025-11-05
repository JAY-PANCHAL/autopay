import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../common/utils/Styles.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/image_paths.dart';
import '../../common/utils/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes/app_pages.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GetStartedScreenState();
}

class GetStartedScreenState extends State<GetStartedScreen> {
  var _current = 0.obs;

  //  final HomeController homeController = Get.put((HomeController()));
  var obscureText = true.obs;
  final CarouselController _controller = CarouselController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onRefresh() async {
    /*  await homeController.getBannerApi(context);
    updateGreetingMessage();*/
  }

  var context1;

  @override
  Widget build(BuildContext context) {
    context1 = context;

    return ModalProgressHUD(
      color: Colors.black.withOpacity(0.6),
      dismissible: false,
      blur: 5,
      progressIndicator: Utils.loader(context),
      inAsyncCall: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppIcons.common_bg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(
                      AppIcons.logo, // Replace with your logo path
                      width: 160,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // White container card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Get Started now",
                        style: Styles.textFontRegular(
                          size: 24,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Create an account or log in to explore\nabout our app",
                        textAlign: TextAlign.center,
                        style: Styles.textFontRegular(
                          size: 12,
                          weight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // 4 buttons in grid
                      GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.3,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signupDistributorScreen);
                            },
                            child: _buildSignupButton(
                              "Sign up for Distributor",
                              AppIcons.distirbutor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signupDealerScreen);
                            },
                            child: _buildSignupButton(
                              "Sign up for Dealer",
                              AppIcons.dealer,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signupVendorScreen);
                            },
                            child: _buildSignupButton(
                              "Sign up for Vendor",
                              AppIcons.vendor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signupCustomerScreen);
                            },
                            child: _buildSignupButton(
                              "Sign up for Customer",
                              AppIcons.customer,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25.sp),

                      Row(
                        children: const [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black26),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Or"),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black26),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 50.sp,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // TODO: navigate to login
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_right_alt, color: Colors.white),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have an account? ",
                            style: Styles.textFontRegular(
                              size: 12,
                              weight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: navigate to sign in
                            },
                            child: Text(
                              "Sign in",
                              style: Styles.textFontRegular(
                                size: 12,
                                weight: FontWeight.w600,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Help section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Need Help ?",
                            style: Styles.textFontRegular(
                              size: 12,
                              weight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone, color: Colors.black54),
                              SizedBox(width: 15),
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 15),
                              Icon(Icons.ondemand_video, color: Colors.black54),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utils.addGap(10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(image, height: 35.sp, width: 35.sp),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 10, left: 10),
            child: Text(
              title,

              style: Styles.textFontBold(
                size: 16,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget getImageFromBase64(String strBase64String) {
    Uint8List bytes = base64.decode(strBase64String);
    try {
      return Image.memory(
        bytes,
        alignment: Alignment.center,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, url, error) => Image.asset(
          AppIcons.placeholder,
          alignment: Alignment.center,
          fit: BoxFit.fill,
        ),
      );
    } catch (e) {
      return Image.asset(
        AppIcons.placeholder,
        alignment: Alignment.center,
        fit: BoxFit.contain,
      );
    }
  }
*/

  Widget getImageFromNetwork(String imageUrl) {
    return Image.network(
      imageUrl,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,

      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Icon(Icons.error, color: Colors.white));
      },
    );
  }

  /*
  Widget getImageFromBase64(String? strBase64String) {
    // Check for null or empty string
    if (strBase64String == null || strBase64String.trim().isEmpty) {
      return Icon(Icons.image)*/
  /*Image.asset(
        AppIcons.placeholder,
        alignment: Alignment.center,
        fit: BoxFit.contain,
      )*/ /*
;
    }

    return FutureBuilder<Uint8List>(
      future: _decodeBase64(strBase64String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());

          //  return Image.asset(AppIcons.placeholder, fit: BoxFit.contain);
        } else if (snapshot.hasError || !snapshot.hasData) {
          return
            Icon(Icons.image);
          //Image.asset(AppIcons.placeholder, fit: BoxFit.contain);
        } else {
          return Image.memory(snapshot.data!,
              fit: BoxFit.fitHeight, gaplessPlayback: true);
        }
      },
    );
  }
*/
}
