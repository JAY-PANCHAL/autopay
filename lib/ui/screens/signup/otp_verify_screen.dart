import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../common/utils/image_paths.dart';
import '../../../common/utils/utility.dart';
import '../../../controller/otp_controller.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // Initialize the controller
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    // Define the style for the OTP boxes
    final defaultPinTheme = PinTheme(
      width: 60.sp,
      height: 60.sp,
      textStyle: Styles.textFontBold(
        weight: FontWeight.w400,

        size: 24.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppColors.appblue,
        width: 2,
      ), // Blue border when focused
    );

    return Scaffold(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                // Top logo + back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Utils.addHGap(10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 35.sp,
                        height: 35.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios, // or Icons.error_outline
                            color: AppColors.appblue,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),

                    Image.asset(
                      AppIcons.logo, // Replace with your logo path
                      width: 160,
                      height: 100,
                    ),
                  ],
                ),
                SizedBox(height: 25.sp),
                // White Card
                Container(
                  padding: EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.sp),
                      // 1. Header Text
                      Text(
                        "OTP Verification",
                        style: Styles.textFontBold(
                          size: 20.sp,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 14.sp),
                      Text(
                        "Create an account or log in to explore our app",
                        style: Styles.textFontRegular(
                          weight: FontWeight.w400,
                          size: 12.sp,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.sp),
                      // 2. OTP Input Fields (Using Pinput)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OTP code",
                            style: Styles.textFontRegular(
                              weight: FontWeight.w400,
                              size: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          SizedBox(height: 8.sp),
                          Pinput(
                            controller: controller.otpController,
                            focusNode: controller.focusNode,
                            length: 4,
                            // 4-digit OTP
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,

                            // The pinTheme for the fields is set to look like the screenshot
                            showCursor: true,
                            // Update the GetX reactive variable on change
                            onChanged: (value) {
                              controller.currentOtp.value = value;
                            },
                            // Automatically submit when all 4 digits are entered
                            onCompleted: (pin) {
                              controller.verifyOtp();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30.sp),
                      // 3. Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50.sp,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            // Primary Blue Color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          onPressed: controller.verifyOtp,
                          // Call the controller's method
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: Styles.textFontBold(
                                  color: Colors.white,
                                  size: 18.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8.sp),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.sp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100, // Placeholder background
      body: Center(
        child: Container(
          width: 350.sp,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Header Text
              Text(
                "**OTP Verification**",
                style: Styles.textFontBold(
                  size: 24.sp,
                  weight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                "Create an account or log in to explore our app",
                style: Styles.textFontRegular(
                  weight: FontWeight.w400,

                  size: 14.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.sp),

              // 2. OTP Input Fields (Using Pinput)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OTP code",
                    style: Styles.textFontRegular(
                      weight: FontWeight.w400,

                      size: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  Pinput(
                    controller: controller.otpController,
                    focusNode: controller.focusNode,
                    length: 4,
                    // 4-digit OTP
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,

                    // The pinTheme for the fields is set to look like the screenshot
                    showCursor: true,
                    // Update the GetX reactive variable on change
                    onChanged: (value) {
                      controller.currentOtp.value = value;
                    },
                    // Automatically submit when all 4 digits are entered
                    onCompleted: (pin) {
                      controller.verifyOtp();
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.sp),

              // 3. Submit Button
              SizedBox(
                width: double.infinity,
                height: 50.sp,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor, // Primary Blue Color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  onPressed: controller.verifyOtp,
                  // Call the controller's method
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Submit",
                        style: Styles.textFontBold(
                          color: Colors.white,
                          size: 18.sp,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.sp),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
