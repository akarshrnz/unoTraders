import 'package:codecarrots_unotraders/model/reset%20password/reset_password_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/color.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ProfileProvider provider;
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  FocusNode currentPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  static final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    provider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  clearAllFields() {
    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBarWidget(appBarTitle: "Reset Password"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppConstant.kheight(height: 10),
                  TextFieldWidget(
                      focusNode: currentPasswordFocus,
                      controller: currentPassword,
                      hintText: "Enter current password",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        currentPasswordFocus.unfocus();
                        FocusScope.of(context).requestFocus(newPasswordFocus);
                      },
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  AppConstant.kheight(height: 15),
                  TextFieldWidget(
                      focusNode: newPasswordFocus,
                      controller: newPassword,
                      hintText: "Enter new password",
                      textInputAction: TextInputAction.next,
                      isPassword: true,
                      maxLines: 1,
                      onFieldSubmitted: (p0) {
                        newPasswordFocus.unfocus();
                        FocusScope.of(context)
                            .requestFocus(confirmPasswordFocus);
                      },
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  AppConstant.kheight(height: 15),
                  TextFieldWidget(
                      focusNode: confirmPasswordFocus,
                      controller: confirmPassword,
                      hintText: "Confirm password",
                      isPassword: true,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (p0) {
                        confirmPasswordFocus.unfocus();
                      },
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else if (newPassword.text.toString() !=
                            confirmPassword.text.toString()) {
                          return "Passwords do not match";
                        } else {
                          return null;
                        }
                      }),
                  AppConstant.kheight(height: 20),
                  isLoading == true
                      ? AppConstant.circularProgressIndicator()
                      : DefaultButton(
                          height: 50,
                          text: "Submit",
                          onPress: () async {
                            setState(() {
                              isLoading = true;
                            });
                            FocusScope.of(context).unfocus();
                            await resetPassword();

                            setState(() {
                              isLoading = false;
                            });
                          },
                          radius: 5,
                          backgroundColor: Colors.green,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;

    if (_formKey.currentState!.validate()) {
      ResetPasswordModel reset = ResetPasswordModel(
          oldPassword: currentPassword.text,
          password: newPassword.text,
          passwordConfirmation: confirmPassword.text,
          userId: int.parse(id),
          userType: userType);
      bool res = await provider.resetPassword(reset: reset);
      if (res == true) {
        clearAllFields();
      }
    } else {
      // ignore: avoid_print
      print("in valid");
    }
  }
}
