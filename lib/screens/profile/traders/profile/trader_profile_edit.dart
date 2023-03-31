import 'dart:io';

import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TraderProfileEdit extends StatefulWidget {
  final TraderProfileModel profileModel;
  final String traderId;
  const TraderProfileEdit(
      {super.key, required this.profileModel, required this.traderId});

  @override
  State<TraderProfileEdit> createState() => _TraderProfileEditState();
}

class _TraderProfileEditState extends State<TraderProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  late ProfileProvider profileProvider;
  late LocationProvider locationProvider;
  late ImagePickProvider imageProvider;
  late FocusNode userNameFocus;
  late FocusNode nameFocus;
  late FocusNode emailFocus;
  late FocusNode mobileFocus;
  late FocusNode locationFocus;
  late FocusNode addressFocus;
  late FocusNode landMarkFocus;
  late FocusNode webUrlFocus;
  late TextEditingController userNameController;
  late TextEditingController mobileController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController locationController;
  late TextEditingController emailController;
  late TextEditingController webUrlController;
  late TextEditingController landMarkController;
  late int selectedRadioType;
  late int selectedRadioCategory;
  String? timeFrom;
  String? timeTwo;
  bool isHandyMan = false;
  bool isAvailable = false;
  bool isAcceptAppointments = false;
  bool isReference = false;
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    selectedRadioType = 0;
    selectedRadioCategory = 0;
    initialization();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imageProvider.initialValues();
      locationProvider.initializeLocation();
      locationProvider.clearData();
      locationProvider.assignLocation(
          lat: widget.profileModel.locLongitude!,
          long: widget.profileModel.locLongitude!);
    });
  }

  initialization() {
    landMarkFocus = FocusNode();
    webUrlFocus = FocusNode();
    nameFocus = FocusNode();
    mobileFocus = FocusNode();
    emailFocus = FocusNode();
    addressFocus = FocusNode();
    userNameFocus = FocusNode();
    locationFocus = FocusNode();
    landMarkController = TextEditingController();
    webUrlController = TextEditingController();
    nameController = TextEditingController(
        text:
            widget.profileModel.name!.isEmpty ? "" : widget.profileModel.name);
    userNameController =
        TextEditingController(text: widget.profileModel.username);
    emailController = TextEditingController(text: widget.profileModel.email);
    mobileController = TextEditingController(
        text: widget.profileModel.mobile!.isEmpty
            ? ""
            : widget.profileModel.mobile);
    addressController = TextEditingController(
        text: widget.profileModel.address!.isEmpty
            ? ""
            : widget.profileModel.address);
    locationController = TextEditingController(
        text: widget.profileModel.location!.isEmpty
            ? ""
            : widget.profileModel.location);
  }

  Future<TimeOfDay?> picktime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  @override
  void dispose() {
    landMarkFocus.dispose();
    webUrlFocus.dispose();
    nameFocus.dispose();
    mobileFocus.dispose();
    userNameFocus.dispose();
    emailFocus.dispose();
    addressFocus.dispose();
    locationFocus.dispose();
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    emailController.dispose();
    userNameController.dispose();
    locationController.dispose();
    webUrlController.dispose();
    landMarkController.dispose();
    super.dispose();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadioType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(appBarTitle: "Edit Profile"),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 17),
                shrinkWrap: true,
                children: [
                  AppConstant.kheight(height: size.width * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<ImagePickProvider>(
                          builder: (context, imgProvider, _) {
                        return Container(
                          child: imgProvider.imageFile.isNotEmpty
                              ? CircleAvatar(
                                  radius: size.width * 0.09,
                                  child: CircleAvatar(
                                    radius: size.width * 0.075,
                                    backgroundColor: AppColor.whiteColor,
                                    child: CircleAvatar(
                                      radius: size.width * 0.07,
                                      backgroundImage: FileImage(
                                          File(imgProvider.images[0].path)),
                                    ),
                                  ),
                                )
                              : widget.profileModel.profilePic!.isNotEmpty ==
                                      true
                                  ? CircleAvatar(
                                      radius: size.width * 0.077,
                                      backgroundColor: AppColor.whiteColor,
                                      child: CircleAvatar(
                                        radius: size.width * 0.075,
                                        backgroundImage: NetworkImage(
                                            widget.profileModel.profilePic!),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: size.width * 0.08,
                                      child: Image.asset(
                                        PngImages.profile,
                                      )),
                        );
                      }),
                      AppConstant.kWidth(width: size.width * .03),
                      InkWell(
                          onTap: () {
                            imageProvider.pickProfileImage();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(Icons.upload, color: AppColor.green),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.green, width: 2)),
                          )

                          //  Container(
                          //   alignment: Alignment.center,
                          //   width: size.width * .27,
                          //   height: size.height * .04,
                          // decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.circular(size.width * .04),
                          //     border: Border.all(color: AppColor.green)),
                          //   child: TextWidget(data: "Picture Upload"),
                          // ),
                          )
                    ],
                  ),
                  AppConstant.kheight(height: size.width * .02),
                  rowTitleType(
                      padding: EdgeInsets.all(1),
                      mainAxisAlignment: MainAxisAlignment.center,
                      onChangedOne: (val) {
                        print("Radio $val");
                        setSelectedRadio(int.parse(val.toString()));
                      },
                      onChangedTwo: (val) {
                        print("Radio $val");
                        setSelectedRadio(int.parse(val.toString()));
                      },
                      title: "Type:",
                      buttomTextOne: "Company",
                      buttonTextTwo: "individual",
                      groupValue: selectedRadioType,
                      valueOne: 0,
                      valueTwo: 1),
                  rowTitleType(
                      padding: EdgeInsets.only(right: 115),
                      mainAxisAlignment: MainAxisAlignment.start,
                      onChangedOne: (val) {
                        print("Radio $val");
                        setState(() {
                          selectedRadioType = int.parse(val.toString());
                        });
                      },
                      onChangedTwo: (val) {
                        print("Radio $val");
                        setState(() {
                          selectedRadioType = int.parse(val.toString());
                        });
                      },
                      title: "Main Category:",
                      buttomTextOne: "Seller",
                      buttonTextTwo: "Service",
                      groupValue: selectedRadioCategory,
                      valueOne: 0,
                      valueTwo: 1),
                  AppConstant.kheight(height: 5),
                  columnWidget(
                      context: context,
                      widgetOne: TextWidget(data: "User Name"),
                      widgetTwo: TextFieldWidget(
                          focusNode: userNameFocus,
                          controller: userNameController,
                          enabled: false,
                          hintText: "User name",
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else {
                              return null;
                            }
                          })),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "Name"),
                    widgetTwo: TextFieldWidget(
                        focusNode: nameFocus,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        hintText: "Name",
                        onFieldSubmitted: (p0) {
                          nameFocus.unfocus();
                          FocusScope.of(context).requestFocus(mobileFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "Email"),
                    widgetTwo: TextFieldWidget(
                        focusNode: emailFocus,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        hintText: "Email",
                        onFieldSubmitted: (p0) {
                          emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(addressFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "Mobile"),
                    widgetTwo: TextFieldWidget(
                        focusNode: mobileFocus,
                        controller: mobileController,
                        enabled: true,
                        hintText: "Mobile",
                        onFieldSubmitted: (p0) {
                          mobileFocus.unfocus();
                          FocusScope.of(context).requestFocus(webUrlFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "Web url"),
                    widgetTwo: TextFieldWidget(
                        focusNode: webUrlFocus,
                        controller: webUrlController,
                        enabled: true,
                        hintText: "Web url",
                        onFieldSubmitted: (p0) {
                          webUrlFocus.unfocus();
                          FocusScope.of(context).requestFocus(addressFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "Address"),
                    widgetTwo: TextFieldWidget(
                        focusNode: addressFocus,
                        hintText: "Address..",
                        controller: addressController,
                        textInputAction: TextInputAction.done,
                        maxLines: 6,
                        enabled: true,
                        onFieldSubmitted: (p0) {
                          addressFocus.unfocus();
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  AppConstant.kheight(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 101),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                            data: "Handyman:", style: TextStyle(fontSize: 17)),
                        AppConstant.kWidth(width: 22),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: isHandyMan,
                            onChanged: (value) {
                              setState(() {
                                isHandyMan = !isHandyMan;
                              });
                            },
                          ),
                        ),
                        AppConstant.kWidth(width: 7),
                        TextWidget(
                            data: "Yes:", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  AppConstant.kheight(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 98),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                            data: "Is Available:",
                            style: TextStyle(fontSize: 17)),
                        AppConstant.kWidth(width: 22),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: isAvailable,
                            onChanged: (value) {
                              setState(() {
                                isAvailable = !isAvailable;
                              });
                            },
                          ),
                        ),
                        AppConstant.kWidth(width: 7),
                        TextWidget(
                            data: "Yes:", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  AppConstant.kheight(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                            data: "Accept Appointments:",
                            style: TextStyle(fontSize: 17)),
                        AppConstant.kWidth(width: 22),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: isAcceptAppointments,
                            onChanged: (value) {
                              setState(() {
                                isAcceptAppointments = !isAcceptAppointments;
                              });
                            },
                          ),
                        ),
                        AppConstant.kWidth(width: 7),
                        TextWidget(
                            data: "Yes:", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  AppConstant.kheight(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 107),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                            data: "Reference:", style: TextStyle(fontSize: 17)),
                        AppConstant.kWidth(width: 22),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: isReference,
                            onChanged: (value) {
                              setState(() {
                                isReference = !isReference;
                              });
                            },
                          ),
                        ),
                        AppConstant.kWidth(width: 7),
                        TextWidget(
                            data: "Yes:", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  AppConstant.kheight(height: 10),
                  Row(
                    children: [
                      AppConstant.kWidth(width: 29),
                      TextWidget(
                          data: "Available Time From:",
                          style: TextStyle(fontSize: 17)),
                      AppConstant.kWidth(width: 22),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            final time = await picktime();
                            if (time == null) return;
                            print(time.hour);
                            print(time.minute);
                            timeFrom = "${time.hour}:${time.minute}";
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text(timeFrom ?? ""),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                          ),
                        ),
                      ),
                      AppConstant.kWidth(width: 3),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            final time = await picktime();
                            if (time == null) return;
                            print(time.hour);
                            print(time.minute);
                            timeTwo = "${time.hour}:${time.minute}";
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text(timeTwo ?? ""),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "location"),
                    widgetTwo: TextFieldWidget(
                        focusNode: locationFocus,
                        controller: locationController,
                        enabled: true,
                        hintText: "location",
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                          locationFocus.unfocus();
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            locationProvider.autocompleteSearch(search: value);
                          } else {
                            locationProvider.clearAll();
                          }
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Consumer<LocationProvider>(
                      builder: (context, locProvider, _) {
                    return locProvider.predictions.isEmpty ||
                            locationController.text.toString().isEmpty
                        ? const SizedBox(
                            height: 0,
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: locProvider.predictions.length,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    locationFocus.unfocus();
                                    locationProvider.onSelected(
                                        value: locProvider.predictions[index]);
                                    locationController.text = locProvider
                                        .selected!.description
                                        .toString();
                                    locationProvider.clearPrediction();
                                  },
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.location_on,
                                      color: AppColor.primaryColor,
                                    ),
                                    title: TextWidget(
                                        data: locProvider
                                            .predictions[index].description
                                            .toString()),
                                  ),
                                ));
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<LocationProvider>(
                        builder: (context, locProvider, _) {
                      return locProvider.locationError.isNotEmpty
                          ? TextWidget(
                              data: locProvider.locationError,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const SizedBox();
                    }),
                  ),
                  columnWidget(
                    context: context,
                    widgetOne: TextWidget(data: "LandMark"),
                    widgetTwo: TextFieldWidget(
                        focusNode: landMarkFocus,
                        hintText: "LandMark",
                        controller: landMarkController,
                        textInputAction: TextInputAction.done,
                        enabled: true,
                        onFieldSubmitted: (p0) {
                          landMarkFocus.unfocus();
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  AppConstant.kheight(height: size.width * .03),
                  DefaultButton(
                      text: "Submit",
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                        } else {}
                      },
                      radius: size.width * .04),
                  AppConstant.kheight(height: size.width * .03),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column columnWidget(
      {required Widget widgetOne,
      required Widget widgetTwo,
      required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstant.kheight(height: size.width * .02),
        widgetOne,
        AppConstant.kheight(height: 5),
        widgetTwo,
      ],
    );
  }

  Widget rowTitleType(
      {required String title,
      required String buttomTextOne,
      required String buttonTextTwo,
      required int valueOne,
      required int valueTwo,
      required int groupValue,
      required void Function(int?)? onChangedOne,
      required void Function(int?)? onChangedTwo,
      required MainAxisAlignment mainAxisAlignment,
      EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          AppConstant.kWidth(width: 22),
          singleRadioButtonRow(
            buttonText: buttomTextOne,
            value: valueOne,
            groupValue: groupValue,
            activeColor: Colors.green,
            onChanged: onChangedOne,
          ),
          AppConstant.kWidth(width: 7),
          singleRadioButtonRow(
            buttonText: buttonTextTwo,
            value: valueTwo,
            groupValue: groupValue,
            activeColor: Colors.green,
            onChanged: onChangedTwo,
          ),
        ],
      ),
    );
  }

  Widget singleRadioButtonRow(
      {required int value,
      required String buttonText,
      required int? groupValue,
      Color? activeColor,
      required void Function(int?)? onChanged}) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 35,
          child: Radio(
              value: value,
              groupValue: selectedRadioType,
              activeColor: activeColor ?? Colors.green,
              onChanged: onChanged),
        ),
        AppConstant.kWidth(width: 7),
        Text(buttonText, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
