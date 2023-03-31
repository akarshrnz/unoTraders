import 'dart:io';
import 'package:codecarrots_unotraders/model/appointments/appointmenst_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/location_provider.dart';

class BookAppointmentPopUp extends StatefulWidget {
  final int traderid;
  const BookAppointmentPopUp({
    super.key,
    required this.traderid,
  });

  @override
  State<BookAppointmentPopUp> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<BookAppointmentPopUp> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode dateeFocus = FocusNode();
  FocusNode timeFocus = FocusNode();
  DateTime dateTime = DateTime.now();
  bool isLoading = false;
  DateTime? validFrom;
  DateTime? validTo;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dateController.dispose();
    timeController.dispose();
    emailFocus.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    dateeFocus.dispose();
    timeFocus.dispose();

    super.dispose();
  }

  clearField() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    nameFocus.unfocus();
    emailFocus.unfocus();
    phoneFocus.unfocus();
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> picktime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Consumer<CurrentUserProvider>(builder: (context, currentUser, _) {
        phoneController.text = currentUser.currentUserPhone ?? "";
        emailController.text = currentUser.currentUserEmail ?? "";
        nameController.text = currentUser.currentUserName ?? "";
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: Provider.of<ImagePickProvider>(context, listen: true)
              //             .images
              //             .isEmpty ==
              //         true
              //     ? size.height * .68
              //     : size.height * .87,
              child: ListView(
                shrinkWrap: true,
                children: [
                  //heading

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const Text(
                        "Book an Appointment",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          child: IconButton(
                              onPressed: () {
                                clearField();

                                Navigator.pop(context);
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.circleXmark,
                                color: Colors.green,
                              )))
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  //body
                  AppConstant.kheight(height: 8),
                  Text("Name"),
                  TextFieldWidget(
                      enabled: false,
                      focusNode: nameFocus,
                      controller: nameController,
                      hintText: "Enter name",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(dateeFocus);
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
                  AppConstant.kheight(height: 10),
                  Text("Email"),
                  TextFieldWidget(
                      enabled: false,
                      keyboardType: TextInputType.none,
                      focusNode: emailFocus,
                      controller: emailController,
                      hintText: "Enter Email",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(phoneFocus);
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
                  AppConstant.kheight(height: 10),
                  Text("Phone"),
                  TextFieldWidget(
                      enabled: false,
                      keyboardType: TextInputType.none,
                      focusNode: phoneFocus,
                      controller: phoneController,
                      hintText: "Enter phone no",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        emailFocus.unfocus();
                        FocusScope.of(context).requestFocus(dateeFocus);
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
                  AppConstant.kheight(height: 10),
                  InkWell(
                    onTap: () async {
                      final date = await pickDate();
                      if (date == null) return;
                      // final time = await picktime();
                      // if (time == null) return;

                      validFrom = DateTime(
                        date.year,
                        date.month,
                        date.day,
                      );
                      // final amPm = DateFormat('hh:mm a').format(validFrom!);
                      String dateRes = "${date.day}-${date.month}-${date.year}";
                      dateController.text = dateRes;

                      setState(() {});
                    },
                    child: TextFieldWidget(
                        enabled: false,
                        focusNode: dateeFocus,
                        controller: dateController,
                        hintText: "date",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.none,
                        onFieldSubmitted: (p0) {
                          // unfocus();
                          dateeFocus.unfocus();

                          FocusScope.of(context).requestFocus(timeFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  AppConstant.kheight(height: 10),
                  //valid to
                  InkWell(
                    onTap: () async {
                      // final date = await pickDate();
                      // if (date == null) return;
                      // final time = await picktime();
                      // if (time == null) return;

                      // validTo = DateTime(
                      //   time.hour,
                      //   time.minute,
                      // );
                      // // print(validTo.toString());
                      // final amPm = DateFormat('hh:mm a').format(validTo!);
                      // String dateRes = "$amPm";
                      // print(amPm);
                      // timeController.text = dateRes;
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        print(picked.format(context));
                        timeController.text = picked.format(context);
                      }

                      setState(() {});
                    },
                    child: TextFieldWidget(
                        enabled: false,
                        keyboardType: TextInputType.none,
                        focusNode: timeFocus,
                        controller: timeController,
                        hintText: "Time",
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                          timeFocus.unfocus();
                          // unfocus();
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  AppConstant.kheight(height: 10),
                  isLoading == true
                      ? AppConstant.circularProgressIndicator()
                      : DefaultButton(
                          height: 50,
                          text: "Send Appointment",
                          onPress: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (currentUser.currentUserType != null &&
                                currentUser.currentUserType!.toLowerCase() ==
                                    "customer") {
                              AddAppointmentModel appointments =
                                  AddAppointmentModel(
                                      appointmentDate: dateController.text,
                                      appointmentTime: timeController.text,
                                      traderId: widget.traderid,
                                      remarks: "",
                                      customerId: int.parse(
                                        currentUser.currentUserId!,
                                      ));
                              await ProfileServices.addAppointment(
                                  appointments: appointments);
                            }

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
          )
        ]);
      }),
    ));
  }
}
