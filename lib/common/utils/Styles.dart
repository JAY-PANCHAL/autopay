import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_constants.dart';

class Styles {
  static RegulareNoteText(size,
          {required Color color, required FontWeight fontWeight}) =>
      TextStyle(
          fontFamily: "SF Pro",
          color: color,
          fontStyle: FontStyle.normal,
          fontSize: size,
          fontWeight: fontWeight);

  static TextStyle textFontRegular(
      {Color color = AppColors.darkGray,
      TextDecoration decoration = TextDecoration.none,
      required double size,
      required FontWeight weight}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        fontFamily: "SF Pro",
        decoration: decoration,
        fontWeight: weight);
  }

  static BoldNoteText(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w800);

  static TextBoxLableStyle(size) => TextStyle(
      fontFamily: "SF Pro",
      color: AppColors.appColor,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w400);

  static TextBoxLableStyleWhite(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w400);

  static gridText(size) => TextStyle(
      color: Colors.white,
      fontSize: size,
      fontFamily: "SF Pro",
      fontWeight: FontWeight.w400);

  static TextBoxHintStyle(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.grey,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w400);

  static ButtonTextStyle(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w400);

  static ButtonLoadingTextStyle(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w400);

  static SignUpBottomButtonText(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w600);

  static SignUpBottomButtonBoldText(size) => TextStyle(
      fontFamily: "SF Pro",
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w800);

  static TextStyle textFontBold(
      {Color color = AppColors.darkGray,
      required double size,
      required FontWeight weight}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        fontFamily: "SF Pro",
        fontWeight: weight);
  }

  static TextStyle textFontBoldItalic(
      {Color color = AppColors.darkGray,
      required double size,
      required FontWeight weight}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        fontFamily: "SF Pro",
        fontWeight: weight);
  }

  static brownBold({double value = 30}) => TextStyle(
      color: AppColors.black,
      fontSize: value,
      fontFamily: "SF Pro",
      fontWeight: FontWeight.normal);

  static primaryBold({double value = 30}) => TextStyle(
      color: AppColors.gradient_second,
      fontSize: value,
      fontFamily: "SF Pro",
      fontWeight: FontWeight.normal);

  static midContrassText({double value = 16}) => TextStyle(
      color: AppColors.appColor.shade700,
      fontSize: value,
      fontFamily: "SF Pro",
      fontWeight: FontWeight.normal);

  static highContrastReg({double value = 15}) => TextStyle(
      color: AppColors.black1617,
      fontSize: value,
      fontFamily: "SF Pro",
      fontWeight: FontWeight.w400);
}
