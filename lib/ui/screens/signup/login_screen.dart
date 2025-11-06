import 'package:autopay/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../common/utils/image_paths.dart';
import '../../../common/utils/utility.dart';
import '../../../controller/signup_customer_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.sp),

                        Text(
                          "Get Started Now",
                          style: Styles.textFontBold(
                            size: 22,
                            weight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15.sp),

                        Text(
                          "Create an account or login to explore our app",
                          style: Styles.textFontRegular(
                            size: 12,
                            weight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),

                        SizedBox(height: 30.sp),
                        _buildTextField(
                          controller.mobileController,
                          "Mobile Number",
                          hint: "Enter Your Mobile Number",
                        ),
                        SizedBox(height: 12.sp),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? "Password required" : null,
                          ),
                        ),
                        SizedBox(height: 30.sp),
                        // Remember Me and Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Row(
                                children: [
                                  SizedBox(
                                    width: 24.sp,
                                    height: 24.sp,
                                    child: Checkbox(
                                      value: controller.rememberMe.value,
                                      onChanged: (_) =>
                                          controller.toggleRememberMe(),
                                      activeColor: AppColors.appblue,
                                    ),
                                  ),
                                  SizedBox(width: 4.sp),
                                  Text(
                                    "Remember me",
                                    style: Styles.textFontRegular(
                                      weight: FontWeight.w500,
                                      size: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Forgot Password screen
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: Styles.textFontRegular(
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: AppColors
                                      .appblue, // Assuming blue for the link
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.sp),

                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("Or"),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30.sp),

                        // Login Button
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
                            onPressed: () => controller.validate(context),
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
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.sp),

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
                                Icon(
                                  Icons.ondemand_video,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label.isNotEmpty ? label : null,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}
