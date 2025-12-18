import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../common/utils/image_paths.dart';
import '../../../common/utils/utility.dart';
import '../../../controller/signup_distributor_controller.dart';
import '../../../network/model/country_model.dart';

class SignupDistributorScreen extends StatefulWidget {
  SignupDistributorScreen({super.key});

  @override
  State<SignupDistributorScreen> createState() =>
      _SignupDistributorScreenState();
}

class _SignupDistributorScreenState extends State<SignupDistributorScreen> {
  final controller = Get.put(SignupDistributorController());

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
      body: Container(
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
                      Text(
                        "Sign up for Distributor",
                        style: Styles.textFontBold(
                          size: 22,
                          weight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 15.sp),

                      // Upload photo
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[500],
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Upload Photo",
                            style: Styles.textFontRegular(
                              weight: FontWeight.w500,
                              size: 12,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25.sp),

                      // Name fields
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller.firstNameController,
                              "Enter Your Name*",
                              hint: "First Name",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller.lastNameController,
                              "",
                              hint: "Last Name",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.sp),
                      _buildTextField(
                        controller.userIdController,
                        "User ID*",
                        hint: "Enter Your User ID",
                      ),
                      SizedBox(height: 12.sp),

                      // Password
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          validator: controller.validatePassword,

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
                          /*validator: (value) =>
                        value!.isEmpty ? "Password required" : null,*/
                        ),
                      ),

                      SizedBox(height: 12.sp),

                      Obx(
                        () => TextFormField(
                          controller: controller.cnfpasswordController,
                          obscureText: !controller.iscnfPasswordVisible.value,
                          validator: controller.validatePassword,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.iscnfPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: controller.togglecnfPasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                          /* validator: (value) =>
                        value!.isEmpty ? "Confirm Password required" : null,
                    */
                        ),
                      ),

                      SizedBox(height: 12.sp),

                      // City / PO
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller.cityController,
                              "City/Village",
                              hint: "Enter Your City/Village",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller.poController,
                              "PO",
                              hint: "Enter Your PO",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.sp),

                      // Pin / District
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller.pinController,
                              "Pin Code",
                              hint: "Enter Your Pin Code",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller.districtController,
                              "District",
                              hint: "Enter Your District",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.sp),

                      // State / Mobile
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: _buildTextField(
                              controller.stateController,
                              "State",
                              hint: "Enter Your State",
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                              flex: 1,
                              child: buildCountryDropdown()),
                        ],
                      ),

                      SizedBox(height: 12.sp),

                      _buildTextField(
                        controller.mobileController,
                        "Mobile Number",
                        validator: controller.validateMobile,
                        hint: "Enter Your Mobile Number",
                      ),
                      SizedBox(height: 12.sp),
                      // WhatsApp / Email
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller.whatsappController,
                              "WhatsApp Number",
                              hint: "Enter WhatsApp Number",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller.emailController,
                              "Email Id",
                              validator: controller.validateEmail,

                              hint: "Enter Email ID",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.sp),

                      // Terms Checkbox
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.isTermsAccepted.value,
                              onChanged: (_) => controller.toggleTerms(),
                              activeColor: AppColors.blue,
                            ),
                            Expanded(
                              child: Text(
                                "Terms and Condition Accepted",
                                style: Styles.textFontRegular(
                                  weight: FontWeight.w500,
                                  size: 12,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.sp),

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
                          onPressed: () => controller.submitForm(context),
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

  Widget buildCountryDropdown() {
    return Obx(() {
      return DropdownButtonFormField<Countries>(
        value: controller.selectedCountry.value,

        // 🔑 CRITICAL FIX
        isExpanded: true,

        selectedItemBuilder: (context) {
          return controller.countriesList.map((country) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    country.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            );
          }).toList();
        },

        items: controller.countriesList.map((country) {
          return DropdownMenuItem<Countries>(
            value: country,
            child: Text(
              country.name ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),

        onChanged: (value) {
          controller.selectedCountry.value = value;
        },

        decoration: InputDecoration(
          labelText: "Country",
          hintText: "Select Country",
          hintStyle: TextStyle(fontSize: 10.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),

        validator: (value) {
          if (value == null) {
            return "Please select a country";
          }
          return null;
        },
      );
    });
  }


  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    String? hint,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label.isNotEmpty ? label : null,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator:
          validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return "Required";
            }
            return null;
          },
    );
  }
}
