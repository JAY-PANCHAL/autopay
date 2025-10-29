import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/color_constants.dart';

class TabProfileSettingScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Text("Profile Setting", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("society_name", "Society Name"),
              SizedBox(height: 15.h),
              _buildTextField("society_code", "Society Code"),
              SizedBox(height: 15.h),
              _buildTextField("taluka", "Taluka"),
              SizedBox(height: 15.h),
              _buildTextField("state", "State"),
              SizedBox(height: 15.h),
              _buildTextField("project", "Project"),
              SizedBox(height: 15.h),
              _buildTextField("secretary_name", "Project Secretary Name"),
              SizedBox(height: 15.h),
              _buildTextField("secretary_mobile", "Secretary Mobile"),
              SizedBox(height: 15.h),
              _buildTextField("gst_no", "GST No"),
              SizedBox(height: 20.h),
/*
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          print("Form Submitted: \${_formKey.currentState!.value}");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
                      ),
                    ),
                  ),
                ],
              ),
*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          // **Cancel Button**
          Expanded(
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text("Cancel", style: TextStyle(fontSize: 18.sp)),
              ),
            ),
          ),

          // **Submit Button**
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  print("Form Submitted: \${_formKey.currentState!.value}");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text("Submit", style: TextStyle(fontSize: 18.sp)),
              ),
            ),
          ),
        ],
      ),


    );
  }

  Widget _buildTextField(String name, String label) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
