import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg{
  static toastMsg(String msg){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}