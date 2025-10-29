import 'package:autopay/common/utils/Styles.dart';
import 'package:autopay/common/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class getTextFormField extends StatelessWidget {
  getTextFormField(
      {Key? key,
      this.controller,
      this.ontap,
      this.labelText,
      this.labelSize,
      required this.validator,
      this.enableInteractiveSelection,
      this.hintText,
      this.callback,
      this.length,
      this.prefixIcon,
      required this.isObscureText,
      this.passwordButton,
      this.inputType,
      this.enabled,
      this.inputFormatters,
      this.autovalidateMode,
      required this.onChanged,
      this.readMode,
      this.focusNode,
      this.fontSize,
      this.hintTextSize})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final double? labelSize;
  final int? length;
  final String? Function(String?)? validator;
  final VoidCallback? callback;
  bool isObscureText;
  final String? hintText;
  final Widget? passwordButton;
  final Widget? prefixIcon;
  final TextInputType? inputType;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? ontap;
  final FocusNode? focusNode;
  bool? enabled = true;
  bool? enableInteractiveSelection = true;
  bool? readMode = false;
  final ValueChanged<String> onChanged;
  final double? fontSize;
  final double? hintTextSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      controller: controller,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLength: length,
      onTap: ontap,
      validator: validator,
      obscureText: isObscureText,
      enabled: enabled,
      focusNode: focusNode,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: AppColors.black, // <-- sets typing text color
      ),
      cursorColor: AppColors.appGray,
      keyboardType: inputType,
      readOnly: readMode ?? false,
      decoration: InputDecoration(
        filled: true,
        focusColor: Colors.black,
        prefixIcon: prefixIcon,
        fillColor: AppColors.grayE6,
        suffixIcon: passwordButton,
        // labelText: labelText,
        labelStyle: Styles.TextBoxLableStyle(labelSize),
        //  floatingLabelStyle: Styles.TextBoxFlotingLableStyle(16.0),
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent)),
        hintStyle: Styles.TextBoxHintStyle(hintTextSize ?? 14),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

class getenabledTextFormField extends StatelessWidget {
  getenabledTextFormField(
      {Key? key,
      this.controller,
      this.ontap,
      this.labelText,
      this.labelSize,
      required this.validator,
      this.enableInteractiveSelection,
      this.hintText,
      this.callback,
      this.length,
      required this.isObscureText,
      this.passwordButton,
      this.inputType,
      this.enabled,
      this.inputFormatters,
      this.autovalidateMode,
      this.onChanged,
      this.readMode,
      this.focusNode})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final double? labelSize;
  final int? length;
  final String? Function(String?)? validator;
  final VoidCallback? callback;
  final bool isObscureText;
  final String? hintText;
  final Widget? passwordButton;
  final TextInputType? inputType;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? ontap;
  final FocusNode? focusNode;
  bool? enabled = true;
  bool? enableInteractiveSelection = true;
  bool? readMode = false;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      controller: controller,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLength: length,
      onTap: ontap,
      validator: validator,
      obscureText: isObscureText,
      enabled: enabled,
      focusNode: focusNode,
      style: Styles.midContrassText(value: 16.0),
      cursorColor: Colors.grey,
      keyboardType: inputType,
      readOnly: readMode ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: passwordButton,
        labelText: labelText,
        labelStyle: Styles.TextBoxLableStyle(labelSize),
        // floatingLabelStyle: Styles.TextBoxFlotingLableStyle(16.0),
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.appblue)),
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.appblue)),
        hintStyle: Styles.TextBoxHintStyle(14.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppColors.appblue),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppColors.appblue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppColors.appblue),
        ),
      ),
    );
  }
}

class getTransparentTextFormField extends StatelessWidget {
  getTransparentTextFormField(
      {Key? key,
      this.controller,
      this.ontap,
      this.labelText,
      required this.validator,
      this.enableInteractiveSelection,
      this.hintText,
      this.callback,
      this.length,
      required this.isObscureText,
      this.passwordButton,
      this.inputType,
      this.enabled,
      this.inputFormatters,
      this.autovalidateMode,
      required this.onChanged,
      this.minlines,
      this.readMode,
      this.focusNode})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final int? length;
  final int? minlines;

  final String? Function(String?)? validator;
  final VoidCallback? callback;
  final bool isObscureText;
  final String? hintText;
  final Widget? passwordButton;
  final TextInputType? inputType;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? ontap;
  final FocusNode? focusNode;

  bool? enabled = true;
  bool? enableInteractiveSelection = true;
  bool? readMode = false;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        controller: controller,
        enableInteractiveSelection: enableInteractiveSelection,
        maxLength: length,
        onTap: ontap,
        validator: validator,
        obscureText: isObscureText,
        enabled: enabled,
        focusNode: focusNode,
        style: Styles.midContrassText(value: 16.0),
        cursorColor: Colors.grey,
        keyboardType: inputType,
        minLines: minlines,
        maxLines: 5,
        readOnly: readMode ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: passwordButton,
          labelText: labelText,
          labelStyle: Styles.TextBoxLableStyle(16.0),
          //  floatingLabelStyle: Styles.TextBoxFlotingLableStyle(16.0),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appblue)),
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: AppColors.appblue)),
          hintStyle: Styles.TextBoxHintStyle(14.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.appblue),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.appblue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.appblue),
          ),
        ));
  }
}
