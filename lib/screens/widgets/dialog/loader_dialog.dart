import 'package:flutter/material.dart';

import '../../../utils/color.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: CircularProgressIndicator(
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(height: 10,),
              const Text(
                'Loading',
                style: TextStyle(
                  color : Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
