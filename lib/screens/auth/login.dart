import 'dart:convert';

import 'dart:convert';

import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/model/login_model.dart';
import 'package:codecarrots_unotraders/screens/auth/signup.dart';
import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';
import 'package:codecarrots_unotraders/screens/widgets/dialog/loader_dialog.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/toast.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/png.dart';

import 'otp_login.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColor.gradientColor,
        ),
        child: Center(
          child: SingleChildScrollView(
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
                TextWidget(
                  data: 'Welcome!',
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.w900),
                ),
                TextWidget(
                  data: 'Login to Continue',
                  style: TextStyle(
                      color: AppColor.whiteColor, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        labelStyle:
                            const TextStyle(color: AppColor.whiteBtnColor),
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        labelStyle:
                            const TextStyle(color: AppColor.whiteBtnColor),
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
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget(
                          data: 'Forgot Password ?',
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                        )
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    login();
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
                      data: 'Login',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.5,
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
                          builder: (context) => const OtpLogin()));
                    },
                    child: TextWidget(
                      data: 'Login with OTP',
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
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
                          builder: (context) => const SignupScreen()));
                    },
                    child: TextWidget(
                      data: 'Create a new account',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    LoadingDialog.show(context);
    final params = {
      'email': _email.text,
      'password': _password.text,
    };
    // final params = {
    //   "email": "akarshkk777@gmail.com",
    //   "password": "Akarsh@12345"
    // };
    var response = await http.post(Uri.parse(Url.login),
        // body: params,
        body: json.encode({
          "email": _email.text.toString(),
          "password": _password.text.toString()
        }),
        headers: {
          "Content-Type": "application/json",
          "Connection": "keep-alive",
          "Accept-Encoding": "gzip, deflate",
          "User-Agent": "Fetch Client",
          "Accept": "*/*",
          "Cache-Control": "no-cache"
        });

    print(response.body);
    // print(response.body);
    final result = jsonDecode(response.body);
    LoadingDialog.hide(context);
    print(result['data'].toString());
    print(result['data']['user_type'].toString());
    print(result['data']['user_id'].toString());

    if (result['status'] == 200) {
      print("shared");
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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()));
      ToastMsg.toastMsg(result['message']);
      _controllers();
    } else {
      ToastMsg.toastMsg(result['message']);
    }
  }

  _controllers() {
    setState(() {
      _email.clear();
      _password.clear();
    });
  }
}



// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: AppColor.gradientColor,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundColor: AppColor.whiteColor,
//               radius: MediaQuery.of(context).size.width * 0.17,
//               child: Image.asset(
//                 PngImages.logo,
//                 width: MediaQuery.of(context).size.width * 0.25,
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             TextWidget(data:
//               'Welcome!',
//               style: TextStyle(
//                   color: AppColor.whiteColor,
//                   fontSize: MediaQuery.of(context).size.width * 0.07,
//                   fontWeight: FontWeight.w900),
//             ),
//             const TextWidget(data:
//               'Login to Continue',
//               style: TextStyle(
//                   color: AppColor.whiteColor, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.05,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextFormField(
//                 controller: _email,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                     hintText: 'Email',
//                     labelText: 'Email',
//                     labelStyle: const TextStyle(color: AppColor.whiteBtnColor),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(color: AppColor.whiteColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(color: AppColor.whiteColor),
//                     )),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextFormField(
//                 controller: _password,
//                 obscureText: true,
//                 obscuringCharacter: '*',
//                 decoration: InputDecoration(
//                     hintText: 'Password',
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(color: AppColor.whiteBtnColor),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(color: AppColor.whiteColor),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(color: AppColor.whiteColor),
//                     )),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextWidget(data:
//                       'Forgot Password ?',
//                       style: TextStyle(
//                           color: AppColor.whiteColor,
//                           fontSize: MediaQuery.of(context).size.width * 0.045,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.13,
//                     )
//                   ],
//                 )),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             GestureDetector(
//               onTap: () {
//                 LoginModel log = LoginModel(
//                     email: 'akarshkk777@gmail.com', password: 'Akarsh@12345');
//                 login(login: log);
//               },
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 decoration: BoxDecoration(
//                   color: AppColor.whiteBtnColor,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Center(
//                     child: TextWidget(data:
//                   'Login',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.width * 0.045,
//                       fontWeight: FontWeight.w500),
//                 )),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.07,
//               width: MediaQuery.of(context).size.width * 0.5,
//               decoration: BoxDecoration(
//                 color: AppColor.whiteBtnColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(
//                     MediaQuery.of(context).size.width * 0.6),
//                 border: Border.all(
//                   color: AppColor.whiteColor,
//                 ),
//               ),
//               child: Center(
//                   child: MaterialButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const OtpLogin()));
//                 },
//                 child: TextWidget(data:
//                   'Login with OTP',
//                   style: TextStyle(
//                       color: AppColor.whiteColor,
//                       fontSize: MediaQuery.of(context).size.width * 0.045,
//                       fontWeight: FontWeight.w500),
//                 ),
//               )),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.07,
//               width: MediaQuery.of(context).size.width * 0.6,
//               decoration: BoxDecoration(
//                 color: AppColor.whiteBtnColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(
//                     MediaQuery.of(context).size.width * 0.6),
//                 border: Border.all(
//                   color: AppColor.whiteColor,
//                 ),
//               ),
//               child: Center(
//                   child: MaterialButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const SignupScreen()));
//                 },
//                 child: TextWidget(data:
//                   'Create a new account',
//                   style: TextStyle(
//                       color: AppColor.whiteColor,
//                       fontSize: MediaQuery.of(context).size.width * 0.045,
//                       fontWeight: FontWeight.w500),
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void login({required LoginModel login}) async {
//     // LoadingDialog.show(context);
//     final params = {
//       "email": "akarshkk777@gmail.com",
//       "password": "Akarsh@12345"
//     };
//     http.Response response;

//     try {
//       // ignore: avoid_print
//       print(ApiServicesUrl.login);
//       response = await http.post(
//           Uri.parse('https://demo.unotraders.com/api/v1/login'),
//           body: json.encode(login.toJson()),
//           headers: {});
//       // ignore: avoid_print
//       print("success");
//       // ignore: avoid_print
//       print(response.statusCode.toString());
//       // ignore: avoid_print
//       print(response.body);
//     } catch (e) {
//       // ignore: avoid_print
//       print("failed");
//       // ignore: avoid_print
//       print(e.toString());
//     }

//     // var first = json.decode(response.body);
//     // print(params);
//     // print(first['data'].toString());

//     // LoadingDialog.hide(context);
//     // if (result['status'] == 200) {
//     //   sp!.setString('token', result['data']['token']);
//     //   Navigator.of(context).pushReplacement(
//     //       MaterialPageRoute(builder: (context) => const Dashboard()));
//     //   ToastMsg.toastMsg(result['message']);
//     //   _controllers();
//     // } else {
//     //   ToastMsg.toastMsg(result['message']);
//     // }
//   }

//   _controllers() {
//     setState(() {
//       _email.clear();
//       _password.clear();
//     });
//   }
// }
