
import 'dart:ui';

import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
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
  bool isPassowrd;
  bool? enabled;
  bool check;
  int? maxLines;
 TextInputAction? textInputAction;
  FocusNode? focusNode;
  TextFieldWidget( {
    super.key,
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
    this.isPassowrd = false,
  });

  @override
  State<TextFieldWidget> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<TextFieldWidget> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:widget.margin,
      decoration:
          BoxDecoration(color: AppColor.whiteColor, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
       enabled:widget.enabled ,
        maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isPassowrd == false ? false : widget.isPassowrd,
        validator: widget.validate,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.blackColor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          hintText: widget.hintText ?? 'hint Text...',
          suffixIcon: widget.icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
