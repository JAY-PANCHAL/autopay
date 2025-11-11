import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/Styles.dart';
import '../../../common/utils/color_constants.dart';
import '../../../common/utils/utility.dart';

class Customer {
  final String name;
  final String userId;

  Customer({required this.name, required this.userId});
}

final List<Customer> mockCustomers = [
  Customer(name: "ADo", userId: "1124856584"),
  Customer(name: "B. Smith", userId: "1124856585"),
  Customer(name: "C. Jones", userId: "1124856586"),
  Customer(name: "D. Brown", userId: "1124856587"),
  Customer(name: "E. Davis", userId: "1124856588"),
];
// --- END MOCK CLASSES/CONSTANTS ---

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightBlue1, // Start color (lighter)
              AppColors.lightBlue2, // Middle color
              AppColors.white, // End color (can be adjusted for more blue)
            ],
            stops: [0.1, 0.5, 0.9], // Adjust stops for gradient distribution
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar (Back button and Title)
            _buildAppBar(context),
            // Search Bar
            _buildSearchBar(),
            SizedBox(height: 16.h),

            // Customer List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: mockCustomers.length,
                itemBuilder: (context, index) {
                  return _buildCustomerCard(mockCustomers[index]);
                },
              ),
            ),

            // Bottom "Add Customers" Button
            _buildAddCustomerButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Go back
              },
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.white, // soft blue background
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.sp,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Text(
              "Customers",
              style: Styles.headlineTextStyle(weight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderGrey, width: 1.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search User",
            hintStyle: Styles.subtitleTextStyle(
              color: AppColors.textGrey.withOpacity(0.7),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: AppColors.appblue,
              size: 24.sp,
            ),
          ),
          style: Styles.subtitleTextStyle(color: AppColors.black),
        ),
      ),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left-side User Icon
            CircleAvatar(
              radius: 20.sp,
              backgroundColor: AppColors.appblue.withOpacity(0.2),
              child: Icon(Icons.person, color: AppColors.appblue, size: 24.sp),
            ),
            SizedBox(width: 12.w),
            // Right-side Info (Expanded to take all available width)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Row → Name + Add Device button aligned at end
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          customer.name,
                          style: Styles.headlineTextStyle(
                            size: 16.sp,
                            weight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildActionButton(
                        text: "Add Device",
                        isPrimary: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Bottom Row → User ID + Action icons at end
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "User Id : ${customer.userId}",
                          style: Styles.subtitleTextStyle(size: 12.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          _buildActionIcon(
                            icon: Icons.edit_outlined,
                            onTap: () {},
                          ),
                          SizedBox(width: 8.w),
                          _buildActionIcon(
                            icon: Icons.notifications_none,
                            onTap: () {},
                          ),
                          SizedBox(width: 8.w),
                          _buildActionIcon(
                            icon: Icons.delete_outline,
                            onTap: () {},
                          ),
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
    );
  }

  Widget _buildActionButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isPrimary ? 20.w : 10.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.appblue : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: isPrimary ? null : Border.all(color: AppColors.borderGrey),
        ),
        child: Text(
          text,
          style: Styles.subtitleTextStyle(
            size: 12.sp,
            weight: FontWeight.w600,
            color: isPrimary ? AppColors.white : AppColors.appblue,
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: AppColors.appblue.withOpacity(0.1), // soft blue background
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, size: 18.sp, color: AppColors.appblue),
        ),
      ),
    );
  }

  Widget _buildAddCustomerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: ElevatedButton(
          onPressed: () {
            // Action to add new customer
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            elevation: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Customers",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.add, color: AppColors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
