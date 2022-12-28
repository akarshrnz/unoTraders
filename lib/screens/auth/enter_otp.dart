import 'dart:convert';

import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../services/helper/api_services_url.dart';
import '../../utils/color.dart';
import '../../utils/png.dart';
import '../../utils/toast.dart';
import '../../main.dart';
import '../widgets/dialog/loader_dialog.dart';
import 'package:http/http.dart' as http;


class EnterOtp extends StatefulWidget {
  final String? mobile;
  const EnterOtp({Key? key,this.mobile}) : super(key: key);

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {

  TextEditingController _otp = TextEditingController();

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
                  selectedFillColor: AppColor.whiteBtnColor.withOpacity(0.2)
                ),
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
                }, appContext: context,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: (){
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
      Uri.parse(ApiServicesUrl.validateOtp),
      body: params,
    );
    print(params);
    print(response.body);
    final result = jsonDecode(response.body);
    LoadingDialog.hide(context);
    if (result['status'] == 200) {
      sp!.setString('token', result['data']['token']);
      ToastMsg.toastMsg(result['message']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard()));
    } else {
      ToastMsg.toastMsg(result['message']);
    }
  }

}
