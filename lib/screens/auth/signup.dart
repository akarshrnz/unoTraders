import 'dart:convert';

import 'package:codecarrots_unotraders/model/auth%20Model/register_model.dart';
import 'package:codecarrots_unotraders/screens/auth/enter_otp.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/toast.dart';
import 'package:codecarrots_unotraders/screens/widgets/dialog/loader_dialog.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/png.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _userType = TextEditingController();
  TextEditingController _traderType = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _userType.text = "customer";
      _traderType.text = "individual";
    });
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
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
              TextWidget(
                data: 'Create Account',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.w900),
              ),
              TextWidget(
                data: 'Create a new account',
                style: TextStyle(
                    color: AppColor.whiteColor, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _userType.text = 'customer';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: _userType.text == 'customer'
                            ? AppColor.whiteBtnColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.2),
                        border: Border.all(
                          color: _userType.text == 'customer'
                              ? Colors.transparent
                              : AppColor.whiteBtnColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(_userType.text == 'customer'
                                ? PngImages.radioActive
                                : PngImages.radioDActive),
                          ),
                          TextWidget(
                            data: 'Customer',
                            style: TextStyle(
                                color: _userType.text == 'customer'
                                    ? AppColor.secondaryColor
                                    : AppColor.whiteColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _userType.text = 'trader';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: _userType.text == 'trader'
                            ? AppColor.whiteBtnColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.2),
                        border: Border.all(
                          color: _userType.text == 'trader'
                              ? Colors.transparent
                              : AppColor.whiteBtnColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(_userType.text == 'trader'
                                ? PngImages.radioActive
                                : PngImages.radioDActive),
                          ),
                          TextWidget(
                            data: 'Trader',
                            style: TextStyle(
                                color: _userType.text == 'trader'
                                    ? AppColor.secondaryColor
                                    : AppColor.whiteColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _userType.text == 'trader'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _traderType.text = 'individual';
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: _traderType.text == 'individual'
                                  ? AppColor.whiteBtnColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.2),
                              border: Border.all(
                                color: _traderType.text == 'individual'
                                    ? Colors.transparent
                                    : AppColor.whiteBtnColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      _traderType.text == 'individual'
                                          ? PngImages.radioActive
                                          : PngImages.radioDActive),
                                ),
                                TextWidget(
                                  data: 'Individual',
                                  style: TextStyle(
                                      color: _traderType.text == 'individual'
                                          ? AppColor.secondaryColor
                                          : AppColor.whiteColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _traderType.text = 'company';
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: _traderType.text == 'company'
                                  ? AppColor.whiteBtnColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.2),
                              border: Border.all(
                                color: _traderType.text == 'company'
                                    ? Colors.transparent
                                    : AppColor.whiteBtnColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      _traderType.text == 'company'
                                          ? PngImages.radioActive
                                          : PngImages.radioDActive),
                                ),
                                TextWidget(
                                  data: 'Company',
                                  style: TextStyle(
                                      color: _traderType.text == 'company'
                                          ? AppColor.secondaryColor
                                          : AppColor.whiteColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _name,
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _email,
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _userName,
                  onChanged: (val) {
                    checkUser();
                  },
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  decoration: InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _mobile,
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _password,
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _confirmPassword,
                  style: const TextStyle(color: AppColor.whiteBtnColor),
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      labelStyle:
                          const TextStyle(color: AppColor.whiteBtnColor),
                      hintStyle: const TextStyle(color: AppColor.whiteBtnColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: AppColor.whiteColor),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  create();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: AppColor.whiteBtnColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: TextWidget(
                    data: 'Create Account',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextWidget(
                data: 'Already have an account?',
                style: TextStyle(
                    color: AppColor.whiteColor, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: AppColor.whiteBtnColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.6),
                  border: Border.all(
                    color: AppColor.whiteColor,
                  ),
                ),
                child: Center(
                    child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: TextWidget(
                    data: 'Login',
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                )),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  void create() async {
    LoadingDialog.show(context);
    RegisterModel registerModel = RegisterModel(
        userType: _userType.text,
        traderType: _traderType.text,
        name: _name.text,
        email: _email.text,
        userName: _userName.text,
        mobile: _mobile.text,
        password: _password.text,
        confirmPassword: _confirmPassword.text);
    // final params = {
    //   'userType': _userType.text,
    //   'traderType': _traderType.text,
    //   'name': _name.text,
    //   'email': _email.text,
    //   'userName': _userName.text,
    //   'mobile': _mobile.text,
    //   'password': _password.text,
    //   'confirmPassword': _confirmPassword.text
    // };
    var response = await http
        .post(Uri.parse('https://demo.unotraders.com/api/v1/register'),
            body: json.encode(
              registerModel.toJson(),
            ),
            headers: {
          "Content-Type": "application/json",
          "Connection": "keep-alive",
          "Accept-Encoding": "gzip, deflate",
          "User-Agent": "Fetch Client",
          "Accept": "*/*",
          "Cache-Control": "no-cache"
        });
    print(registerModel.toJson());
    print(response.body);
    final result = jsonDecode(response.body);
    LoadingDialog.hide(context);
    if (result['status'] == 200) {
      ToastMsg.toastMsg(result['message']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EnterOtp(
                mobile: _mobile.text,
              )));
      // _controllers();
      //test
    } else {
      ToastMsg.toastMsg(result['message'][0] ?? "Something went wrong");
    }
  }

  // void create() async {
  //   LoadingDialog.show(context);
  //   // final params = {
  //   //   "userType": "customer",
  //   //   "traderType": "individual",
  //   //   "name": "akarsh123",
  //   //   "email": "sod123@mailinator.com",
  //   //   "userName": "sod53335",
  //   //   "mobile": "1234567895",
  //   //   "password": "Akarsh@12345",
  //   //   "confirmPassword": "Akarsh@12345"
  //   // };
  //   final params = {
  //     "userType": _userType.text.toString(),
  //     "traderType": _traderType.text.toString(),
  //     "name": _name.text.toString(),
  //     "email": _email.text.toString(),
  //     "userName": _userName.text.toString(),
  //     "mobile": _mobile.text.toString(),
  //     "password": _password.text.toString(),
  //     "confirmPassword": _confirmPassword.text.toString(),
  //   };
  //   var response = await http.post(
  //       Uri.parse('https://demo.unotraders.com/api/v1/register'),
  //       body: jsonEncode(params),
  //       headers: {
  //         "Accept": "application/json",
  //       });
  //   print(params);
  //   print(response.body);
  //   final result = jsonDecode(response.body);
  //   LoadingDialog.hide(context);
  //   if (result['status'] == 200) {
  //     ToastMsg.toastMsg(result['message']);
  //     _controllers();
  //   } else {
  //     ToastMsg.toastMsg(result['message']);
  //   }
  // }

  void checkUser() async {
    // LoadingDialog.show(context);
    var response = await http.get(
      Uri.parse(Url.checkUsername + _userName.text),
    );
    print(Url.checkUsername + _userName.text);
    print(response.body);
    final result = jsonDecode(response.body);
    // LoadingDialog.hide(context);
    if (result['status'] == 200) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: TextWidget(data: result['message'] ?? "Something Went Wrong"),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  _controllers() {
    setState(() {
      _userType.text == "customer";
      _traderType.text == "individual";
      _name.clear();
      _email.clear();
      _userName.clear();
      _mobile.clear();
      _password.clear();
      _confirmPassword.clear();
    });
  }
}
