import 'dart:io';

import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../provider/image_pick_provider.dart';
import '../../../provider/job_provider.dart';
import '../../../provider/location_provider.dart';

class EditCustomerProfile extends StatefulWidget {
  final CustomerProfileModel customerProfile;
  const EditCustomerProfile({super.key, required this.customerProfile});

  @override
  State<EditCustomerProfile> createState() => _EditCustomerProfileState();
}

class _EditCustomerProfileState extends State<EditCustomerProfile> {
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
  late TextEditingController userNameController;
  late TextEditingController mobileController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController locationController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    initialization();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imageProvider.initialValues();
      locationProvider.initializeLocation();
      locationProvider.clearData();
      locationProvider.assignLocation(
          lat: widget.customerProfile.locLongitude!,
          long: widget.customerProfile.locLongitude!);
    });
  }

  initialization() {
    nameFocus = FocusNode();
    mobileFocus = FocusNode();
    emailFocus = FocusNode();
    addressFocus = FocusNode();
    userNameFocus = FocusNode();
    locationFocus = FocusNode();
    nameController = TextEditingController(
        text: widget.customerProfile.name!.isEmpty
            ? ""
            : widget.customerProfile.name);
    userNameController =
        TextEditingController(text: widget.customerProfile.username);
    emailController = TextEditingController(text: widget.customerProfile.email);
    mobileController = TextEditingController(
        text: widget.customerProfile.mobile!.isEmpty
            ? ""
            : widget.customerProfile.mobile);
    addressController = TextEditingController(
        text: widget.customerProfile.address!.isEmpty
            ? ""
            : widget.customerProfile.address);
    locationController = TextEditingController(
        text: widget.customerProfile.location!.isEmpty
            ? ""
            : widget.customerProfile.location);
  }

  @override
  void dispose() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Edit Profile",
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Flexible(
                child: ListView(
              padding: EdgeInsets.all(size.width * .03),
              shrinkWrap: true,
              children: [
                Row(
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
                            : widget.customerProfile.profilePic!.isNotEmpty ==
                                    true
                                ? CircleAvatar(
                                    radius: size.width * 0.09,
                                    child: CircleAvatar(
                                      radius: size.width * 0.075,
                                      backgroundColor: AppColor.whiteColor,
                                      child: CircleAvatar(
                                        radius: size.width * 0.07,
                                        backgroundImage: NetworkImage(
                                            widget.customerProfile.profilePic!),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: size.width * 0.08,
                                    child: Image.asset(
                                      PngImages.profile,
                                    )),
                      );
                    }),
                    Constant.kWidth(width: size.width * .03),
                    InkWell(
                      onTap: () {
                        imageProvider.pickProfileImage();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * .27,
                        height: size.height * .04,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * .04),
                            border: Border.all(color: AppColor.green)),
                        child: const Text("Picture Upload"),
                      ),
                    )
                  ],
                ),
                Constant.kheight(height: size.width * .03),
                columnWidget(
                    context: context,
                    widgetOne: const Text("User Name"),
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
                  widgetOne: const Text("Name"),
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
                  widgetOne: const Text("Email"),
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
                  widgetOne: const Text("Mobile"),
                  widgetTwo: TextFieldWidget(
                      focusNode: mobileFocus,
                      controller: mobileController,
                      enabled: true,
                      hintText: "Mobile",
                      onFieldSubmitted: (p0) {
                        mobileFocus.unfocus();
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
                  widgetOne: const Text("Address"),
                  widgetTwo: TextFieldWidget(
                      focusNode: addressFocus,
                      controller: addressController,
                      textInputAction: TextInputAction.next,
                      maxLines: 6,
                      enabled: true,
                      onFieldSubmitted: (p0) {
                        emailFocus.unfocus();
                        FocusScope.of(context).requestFocus(locationFocus);
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
                  widgetOne: const Text("location"),
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
                Consumer<LocationProvider>(builder: (context, locProvider, _) {
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
                                  title: Text(locProvider
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
                        ? Text(
                            locProvider.locationError,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox();
                  }),
                ),
                Constant.kheight(height: size.width * .07),
                Consumer<ImagePickProvider>(builder: (context, imgProvider, _) {
                  return Consumer<LocationProvider>(
                      builder: (context, locProvider, _) {
                    return Consumer<ProfileProvider>(
                        builder: (context, profile, _) {
                      return profile.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DefaultButton(
                              text: "Update",
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  UpdateProfileModel updateModel =
                                      UpdateProfileModel(
                                          name: nameController.text
                                              .toString()
                                              .trim(),
                                          address: addressController.text
                                              .toString()
                                              .trim(),
                                          location: locationController.text,
                                          locationLatitude:
                                              locProvider.latitude,
                                          locationLongitude:
                                              locProvider.longitude,
                                          profileImage:
                                              imgProvider.imageFile.isEmpty
                                                  ? null
                                                  : imgProvider.imageFile[0]);
                                  await profileProvider.updateProfile(
                                      updateProfile: updateModel);
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                } else {}
                              },
                              radius: size.width * .04);
                    });
                  });
                }),
              ],
            ))
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
        Constant.kheight(height: size.width * .02),
        widgetOne,
        Constant.kheight(height: 5),
        widgetTwo,
      ],
    );
  }
}
