// import 'package:aasaan_flutter/common/rounded_button.dart';
// import 'package:aasaan_flutter/common/utils/color_constants.dart';
// import 'package:aasaan_flutter/common/utils/strings.dart';
// import 'package:aasaan_flutter/controller/verify_otp_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:pinput/pinput.dart';

// import '../../common/utils/utility.dart';
// import '../../routes/app_pages.dart';

// class VerifyOtpScreen extends StatefulWidget {
//   VerifyOtpScreen({Key? key}) : super(key: key);

//   @override
//   State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
// }

// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   final VerifyOtpController controller = Get.put((VerifyOtpController()));
//   final TextEditingController _otpController = TextEditingController();
//   var istablet = Utils.checkTablet();

//   @override
//   Widget build(BuildContext context) {
//     var width = Utils.getScreenWidth(context);
//     var height = Utils.getScreenHeight(context);

//     return Obx(() {
//       return ModalProgressHUD(
//         color: Colors.black.withOpacity(0.6),
//         dismissible: false,
//         blur: 5,
//         progressIndicator: Utils.loader(context),
//         inAsyncCall: controller.isLoading.value,
//         child: SafeArea(
//           child: Scaffold(
//             resizeToAvoidBottomInset: true,
//             body: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 width: width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Utils.addGap(100),
//                     Text(
//                       Strings.kVerifyOTP,
//                       style: TextStyle(
//                           fontSize: 22.sp, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     ),
//                     Utils.addGap(50),
//                     Text(
//                       Strings.kEnterOTP,
//                       style: TextStyle(
//                           fontSize: 18.sp, fontWeight: FontWeight.w300),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 30.h),
//                     Pinput(
//                       controller: controller.otpController,
//                       length: 4,
//                       defaultPinTheme: PinTheme(
//                         width: 50.w,
//                         height: 50.h,
//                         textStyle: TextStyle(
//                             fontSize: 22.sp, fontWeight: FontWeight.bold),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           border: Border.all(color: AppColors.appColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30.h),
//                     RoundedButton(
//                       buttonText: Strings.kVerifyOTP,
//                       size: istablet ? 10 : 12,
//                       color: AppColors.appColor,
//                       onpressed: () {
//                         controller.verifyOtpApiCall();
//                       },
//                       width: MediaQuery.of(context).size.width / 1.5,
//                     ),
//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             width: width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Utils.addGap(istablet ? 60 : 100),
//                 Utils.normalText("Verify OTP", size: istablet ? 22 : 22),
//                 Utils.addGap(istablet ? 60 : 50),
//                 Utils.normalText("Enter the OTP sent to your phone",
//                     size: istablet ? 22 : 18, fontWeight: FontWeight.w300),
//                 Utils.addGap(istablet ? 40 : 30),
//                 Pinput(
//                   controller: _otpController,
//                   length: 4,
//                   defaultPinTheme: PinTheme(
//                     width: 50.w,
//                     height: 50.h,
//                     textStyle:
//                         TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       border: Border.all(color: AppColors.appColor),
//                     ),
//                   ),
//                 ),
//                 Utils.addGap(istablet ? 40 : 30),
//                 RoundedButton(
//                   buttonText: "Verify OTP",
//                   size: istablet ? 8 : 16,
//                   color: AppColors.appColor,
//                   onpressed: () {},
//                   width: MediaQuery.of(context).size.width / 1.5,
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
