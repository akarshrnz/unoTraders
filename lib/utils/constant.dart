import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Constant {


  static Widget kheight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  static Widget kWidth({required double width}) {
    return SizedBox(
      width: width,
    );
  }

  static void showSnackBar(var scaffoldKey, String message, Color? color) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColor.whiteColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color ?? AppColor.primaryColor,
        elevation: 10,
        shape: const StadiumBorder(),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  static toastMsg({required String msg, required Color backgroundColor}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget circularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColor.green),
    );
  }
}
