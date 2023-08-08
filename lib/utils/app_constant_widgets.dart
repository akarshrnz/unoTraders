import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AppConstant {
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

  static overlayLoaderShow(BuildContext context) {
    Loader.show(context,
        overlayColor: Colors.black54,
        progressIndicator: CircularProgressIndicator(color: AppColor.green),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.grey)));
  }

  static overlayLoaderHide(BuildContext context) {
    Loader.hide();
  }

  static Widget _buildButton(BuildContext context, String text, IconData icon,
      VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
            ),
            const SizedBox(width: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }

  static void showImagePicker(
      BuildContext context, ImagePickProvider imagePickProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              _buildButton(context, 'Capture with Camera', Icons.camera_alt,
                  () {
                imagePickProvider.pickImageFromCamera();
                Navigator.pop(context);
              }),
              SizedBox(height: 16.0),
              _buildButton(context, 'Pick from Gallery', Icons.photo_library,
                  () {
                imagePickProvider.pickImage();
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );
  }
}
