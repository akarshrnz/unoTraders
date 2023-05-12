import 'dart:convert';

import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../services/helper/url.dart';
import '../../utils/color.dart';
import '../../utils/png.dart';
import '../../utils/toast.dart';
import '../../main.dart';
import '../widgets/dialog/loader_dialog.dart';
import 'package:http/http.dart' as http;

class EnterOtp extends StatefulWidget {
  final String? mobile;
  const EnterOtp({Key? key, this.mobile}) : super(key: key);

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  TextEditingController _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.mobile.toString());
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
              width: MediaQuery.of(context).size.width * 0.7,
              child: PinCodeTextField(
                controller: _otp,
                length: 4,
                obscureText: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: AppColor.whiteBtnColor,
                    activeColor: AppColor.whiteBtnColor,
                    inactiveColor: AppColor.whiteBtnColor,
                    selectedColor: AppColor.whiteBtnColor,
                    inactiveFillColor: AppColor.whiteBtnColor.withOpacity(0.2),
                    selectedFillColor: AppColor.whiteBtnColor.withOpacity(0.2)),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                // controller: textEditingController,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                validate();
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
                  'OK',
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

  void validate() async {
    LoadingDialog.show(context);
    final params = {
      "mobile": widget.mobile,
      "otp": _otp.text,
    };
    var response = await http.post(
      Uri.parse(Url.validateOtp),
      body: params,
    );
    print(params);
    print(response.body);
    final result = jsonDecode(response.body);
    LoadingDialog.hide(context);
    if (result['status'] == 200) {
      print("ot p login data");
      sp!.setString('token', result['data']['token']);
      sp!.setString("id", result['data']['user_id'].toString());
      sp!.setString("userType", result['data']['user_type']);
      sp!.setString("userName", result['data']['name']);
      sp!.setString("mobile", result['data']['mobile']);
      sp!.setString("profilePic", result['data']['profile_pic']);
      sp!.setString("email", result['data']['email']);

      // ignore: avoid_print
      print("user id");
      // ignore: avoid_print
      print(sp!.getString('id'));
      print(sp!.getString('userName'));
      // ignore: avoid_print
      print(sp!.getString('userType'));
      ToastMsg.toastMsg(result['message']);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      ToastMsg.toastMsg(result['message']);
    }
  }
}
