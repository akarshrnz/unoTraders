import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/helper/url.dart';
import '../../utils/color.dart';
import '../../utils/png.dart';
import '../../utils/toast.dart';
import '../widgets/dialog/loader_dialog.dart';
import 'enter_otp.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    emailFocus.dispose();

    super.dispose();
  }

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
            // Text(
            //   'Welcome!',
            //   style: TextStyle(
            //       color: AppColor.whiteColor,
            //       fontSize: MediaQuery.of(context).size.width * 0.07,
            //       fontWeight: FontWeight.w900),
            // ),
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                focusNode: emailFocus,
                controller: email,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
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
              onTap: () async {
                if (email.text.isNotEmpty) {
                  emailFocus.unfocus();
                  LoadingDialog.show(context);
                  final params = {
                    "email": email.text,
                  };
                  print(Url.forgotPassword);
                  print(params);
                  try {
                    var response = await http.post(
                      Uri.parse(
                          'https://demo.unotraders.com/api/v1/reset_password'),
                      body: params,
                    );
                    print(response.statusCode);
                    final result = jsonDecode(response.body);

                    print(result);
                    if (response.statusCode == 200) {
                      ToastMsg.toastMsg(result['message'] ?? "");
                      email.clear();
                    } else {
                      ToastMsg.toastMsg(
                          result['message'] ?? "Something Went Wrong");
                    }
                  } catch (e) {
                    print(e.toString());
                    ToastMsg.toastMsg('Something Went Wrong');
                  }

                  if (!mounted) return;
                  LoadingDialog.hide(context);
                }
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
                  'Send Request',
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
      "mobile": email.text,
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
                mobile: email.text,
              )));
    } else {
      ToastMsg.toastMsg(result['message']);
    }
  }
}
