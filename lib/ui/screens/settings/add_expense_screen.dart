import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../common/utils/color_constants.dart';
import '../../../controller/add_expense_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final AddExpenseController controller = Get.put(AddExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.lightBlue1,
              AppColors.lightBlue2,
              AppColors.white,
            ],
            stops: [0.1, 0.5, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            child: Column(
              children: [
                // ---------------- HEADER ----------------
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "Add New Expense",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // ---------------- FORM ----------------
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
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
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ---------------- Date ----------------
                            _textLabel("Date"),
                            FormBuilderTextField(
                              name: "date",
                              decoration: _inputDecoration("Enter Date"),
                              validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Vehicle ----------------
                            _textLabel("Vehicle"),
                            FormBuilderDropdown(
                              name: "vehicle",
                              decoration: _inputDecoration("Select Vehicle"),
                              items: controller.vehicleList
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                                  .toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Expense Type ----------------
                            _textLabel("Expense Type"),
                            FormBuilderDropdown(
                              name: "expenseType",
                              decoration: _inputDecoration("Expense Type"),
                              items: controller.expenseTypes
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                                  .toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Quantity ----------------
                            _textLabel("Quantity"),
                            FormBuilderTextField(
                              name: "quantity",
                              decoration: _inputDecoration("Enter Quantity"),
                              validator: FormBuilderValidators.numeric(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Amount ----------------
                            _textLabel("Amount"),
                            FormBuilderTextField(
                              name: "amount",
                              decoration: _inputDecoration("Enter Amount"),
                              validator: FormBuilderValidators.numeric(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Payment Mode ----------------
                            _textLabel("Payment Mode"),
                            FormBuilderDropdown(
                              name: "paymentMode",
                              decoration: _inputDecoration("Payment Mode"),
                              items: controller.paymentModes
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                                  .toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Description ----------------
                            _textLabel("Expense Description"),
                            FormBuilderTextField(
                              name: "description",
                              decoration:
                              _inputDecoration("Enter Expense Description"),
                              maxLines: 3,
                            ),
                            SizedBox(height: 18.h),

                            // ---------------- Upload Image ----------------
                            _textLabel("Upload Image"),
                            Obx(
                                  () => GestureDetector(
                                onTap: controller.pickImage,
                                child: Container(
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.shade400, width: 1),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: controller.selectedImage.value == null
                                      ? Center(
                                    child: Text(
                                      "+ Upload Image",
                                      style: TextStyle(
                                          color: AppColors.appblue,
                                          fontSize: 16),
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    child: Image.file(
                                      controller.selectedImage.value!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ---------------- Bottom Button ----------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 18, right: 18),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: controller.submitExpense,
            child: const Text(
              "Add Expense",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.appblue, width: 1),
      ),
    );
  }
}
