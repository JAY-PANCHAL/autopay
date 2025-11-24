// file: add_new_customer_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_constants.dart';
import '../../../controller/add_customer_controller.dart';

/// GetX Controller - holds formKey, dropdown lists and submit logic

class AddNewCustomerScreen extends StatelessWidget {
  AddNewCustomerScreen({Key? key}) : super(key: key);

  final AddCustomerController ctrl = Get.put(AddCustomerController());

  InputDecoration _fieldDecoration(String? hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightBlue1, // Start color (lighter)
              AppColors.lightBlue2, // Middle color
              AppColors.white,
            ],
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Add New Customer',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
                // The white rounded card look (similar to screenshot)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: FormBuilder(
                    key: ctrl.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name row (First + Last)
                        Text(
                          'Enter Your Name*',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'firstName',
                                decoration: _fieldDecoration('First Name'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                    errorText: 'Required',
                                  ),
                                  FormBuilderValidators.minLength(
                                    2,
                                    errorText: 'Too short',
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'lastName',
                                decoration: _fieldDecoration('Last Name'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                    errorText: 'Required',
                                  ),
                                  FormBuilderValidators.minLength(
                                    2,
                                    errorText: 'Too short',
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // User ID
                        Text(
                          'User ID*',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FormBuilderTextField(
                          name: 'userId',
                          decoration: _fieldDecoration('Enter Your User ID'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Required',
                            ),
                            FormBuilderValidators.match(
                              RegExp(r'^[A-Za-z0-9\-_]+$'),
                              errorText: 'Invalid characters',
                            ),
                          ]),
                        ),

                        SizedBox(height: 16.h),

                        // Mobile
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FormBuilderTextField(
                          name: 'mobile',
                          decoration: _fieldDecoration(
                            'Enter Your Mobile Number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Required',
                            ),
                            FormBuilderValidators.numeric(
                              errorText: 'Only digits allowed',
                            ),
                            FormBuilderValidators.minLength(
                              10,
                              errorText: '10 digits required',
                            ),
                            FormBuilderValidators.maxLength(
                              15,
                              errorText: 'Too long',
                            ),
                          ]),
                        ),

                        SizedBox(height: 16.h),

                        // Password with show/hide
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Obx(
                          () => FormBuilderTextField(
                            name: 'password',
                            decoration: _fieldDecoration('******').copyWith(
                              suffixIcon: GestureDetector(
                                onTap: () => ctrl.obscurePassword.value =
                                    !ctrl.obscurePassword.value,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: Icon(
                                    ctrl.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 22.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                            obscureText: ctrl.obscurePassword.value,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Required',
                              ),
                              FormBuilderValidators.minLength(
                                6,
                                errorText: 'Min 6 chars',
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                // Preferences section (title + thin blue line)
                Row(
                  children: [
                    Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A89C8),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(height: 1, color: Colors.grey.shade300),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Drop-downs placed in white rounded containers
                _dropdownBlock(
                  'Speed Unit',
                  'speedUnit',
                  ctrl.speedUnitOptions,
                  ctrl.speedUnit,
                ),
                _dropdownBlock(
                  'Distance Unit',
                  'distanceUnit',
                  ctrl.distanceUnitOptions,
                  ctrl.distanceUnit,
                ),
                _dropdownBlock(
                  'Altitude Unit',
                  'altitudeUnit',
                  ctrl.altitudeUnitOptions,
                  ctrl.altitudeUnit,
                ),
                _dropdownBlock(
                  'Volume Unit',
                  'volumeUnit',
                  ctrl.volumeUnitOptions,
                  ctrl.volumeUnit,
                ),
                _dropdownBlock(
                  'Time Zone',
                  'timeZone',
                  ctrl.timeZoneOptions,
                  ctrl.timeZone,
                ),

                SizedBox(height: 18.h),

                // Add Customers button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: ctrl.submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4C9BB1),
                      // screenshot-like teal/blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'Add Customers',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper to build a labeled dropdown that visually matches the screenshot
  Widget _dropdownBlock(
    String label,
    String name,
    List<String> items,
    RxnString valueHolder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 14.h),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: FormBuilderDropdown<String>(
            name: name,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            initialValue: valueHolder.value,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => valueHolder.value = v,
            validator: FormBuilderValidators.required(errorText: 'Required'),
          ),
        ),
      ],
    );
  }
}
