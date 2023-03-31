import 'dart:ui';

import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  Function()? onEditingComplete;
  TextInputType? keyboardType;
  EdgeInsetsGeometry? margin;
  List<TextInputFormatter>? inputFormatters;
  Widget? icon;
  bool isPassword;
  bool? enabled;
  bool check;
  int? maxLines;
  bool? removeBorder;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  TextFieldWidget({
    super.key,
    this.removeBorder,
    this.hintText,
    this.controller,
    this.validate,
    this.keyboardType,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.maxLines,
    this.onChanged,
    this.enabled,
    this.icon,
    this.check = false,
    this.textInputAction,
    this.focusNode,
    this.isPassword = false,
  });

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        enabled: enabled,
        maxLines: maxLines == 1 ? 1 : maxLines,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isPassword == false ? false : isPassword,
        validator: validate,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          border: removeBorder == true
              ? InputBorder.none
              : const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.blackColor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
          hintText: hintText ?? 'hint Text...',
          suffixIcon: icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
