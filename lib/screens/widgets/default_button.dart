import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.height,
      this.width,
      this.backgroundColor,
      required this.radius,
      this.padding});
  final String text;
  final Color? backgroundColor;
  final Function() onPress;
  final double radius;
  final EdgeInsetsGeometry? padding;
 final double ? width;
 final  double ? height;


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColor.whiteColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(radius)),
          padding: padding,
          minimumSize: Size(width??size.width, height??50)
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(color: AppColor.whiteBtnColor),
        ),
      ),
    );
  }
}
