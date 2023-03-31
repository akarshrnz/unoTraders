import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/helper/url.dart';
import '../../utils/color.dart';
import '../../utils/png.dart';
import '../../utils/toast.dart';
import '../widgets/dialog/loader_dialog.dart';
import 'enter_otp.dart';
import 'package:http/http.dart' as http;

class OtpLogin extends StatefulWidget {
  const OtpLogin({Key? key}) : super(key: key);

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  TextEditingController _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColor.gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.whiteColor,
              radius: MediaQuery.of(context).size.width * 0.17,
              child: Image.asset(
                PngImages.logo,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'Welcome!',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              'Login to Continue',
              style: TextStyle(
                  color: AppColor.whiteColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _mobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    labelText: 'Mobile Number',
                    labelStyle: const TextStyle(color: AppColor.whiteBtnColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: AppColor.whiteColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: AppColor.whiteColor),
                    )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                otpLogin();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: AppColor.whiteBtnColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: Text(
                  'SEND OTP',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void otpLogin() async {
    LoadingDialog.show(context);
    final params = {
      "mobile": _mobile.text,
    };
    var response = await http.post(
      Uri.parse(Url.otpLogin),
      body: params,
    );
    print(params);
    print(response.body);
    final result = jsonDecode(response.body);
    LoadingDialog.hide(context);
    if (result['status'] == 200) {
      ToastMsg.toastMsg(result['message']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EnterOtp(
                mobile: _mobile.text,
              )));
    } else {
      ToastMsg.toastMsg(result['message']);
    }
  }
}
