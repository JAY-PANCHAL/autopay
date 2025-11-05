import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../common/CommanTextField.dart';
import '../../common/rounded_button.dart';
import '../../common/utils/app_constants.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/strings.dart';
import '../../common/utils/utility.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LoginController loginScreenController = Get.put((LoginController()));
  bool obscureText = true;
  var istablet = Utils.checkTablet();

  @override
  Widget build(BuildContext context) {
    var width = Utils.getScreenWidth(context);
    var height = Utils.getScreenHeight(context);

    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        blur: 5,
        progressIndicator: Utils.loader(context),
        inAsyncCall: loginScreenController.isLoading.value,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: width,
              child: Form(
                key: loginScreenController.formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.addGap(istablet ? 10 : 50),
                      SlideInRight(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: Utils.normalText(
                            Strings.kLogIn,
                            color: AppColors.secondaryAppColor,
                            size: istablet ? 18 : 40,
                          ),
                        ),
                      ),
                      Utils.addGap(istablet ? 55 : 50),
                      SlideInRight(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 200),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'USERNAME',
                            style: TextStyle(
                              fontSize: istablet ? 18 : 20,
                              letterSpacing: 2,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Utils.addGap(istablet ? 28 : 15),
                      SlideInRight(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 200),
                        child: getTextFormField(
                          inputType: TextInputType.text,
                          hintTextSize: istablet ? 11.sp : 14.sp,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return AppConstants.errorEmail;
                            }
                            return null;
                          },
                          controller: loginScreenController.userNameController,
                          isObscureText: false,
                          onChanged: (String value) {},
                          hintText: Strings.kEnterUserName,
                          labelText: Strings.kPhoneLabel,
                          labelSize: istablet ? 34 : 18,
                          fontSize: istablet ? 25 : 16,
                          passwordButton:
                              const Padding(padding: EdgeInsets.all(8.0)),
                        ),
                      ),
                      Utils.addGap(istablet ? 50 : 40),
                      SlideInRight(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 200),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'PASSWORD',
                            style: TextStyle(
                              fontSize: istablet ? 18 : 20,
                              letterSpacing: 2,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Utils.addGap(istablet ? 28 : 15),
                      SlideInRight(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 200),
                        child: getTextFormField(
                          inputType: TextInputType.text,
                          hintTextSize: istablet ? 11.sp : 14.sp,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return AppConstants.errorPassword;
                            }
                            return null;
                          },
                          controller: loginScreenController.passwordController,
                          isObscureText:
                              true, // assuming password should be hidden
                          onChanged: (String value) {},
                          hintText: Strings.kEnterPassword,
                          labelText: Strings.kPhoneLabel,
                          labelSize: istablet ? 34 : 18,
                          fontSize: istablet ? 25 : 16,
                          passwordButton:
                              const Padding(padding: EdgeInsets.all(8.0)),
                        ),
                      ),
                      Utils.addGap(istablet ? 50 : 40),
                      SlideInRight(
                        delay: const Duration(milliseconds: 700),
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: RoundedButton(
                            buttonText: Strings.kLogIn,
                            color: AppColors.secondaryAppColor,
                            width: width / 1.5,
                            size: istablet ? 8 : 16,
                            onpressed: () {
                              loginScreenController.validate(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
