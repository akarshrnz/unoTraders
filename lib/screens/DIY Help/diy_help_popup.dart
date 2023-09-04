import 'dart:io';
import 'package:codecarrots_unotraders/model/add_diy_help.dart';
import 'package:codecarrots_unotraders/provider/help_provider.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/location_provider.dart';

class DiyPopUp extends StatefulWidget {
  const DiyPopUp({
    super.key,
  });

  @override
  State<DiyPopUp> createState() => _DiyPopUpState();
}

class _DiyPopUpState extends State<DiyPopUp> {
  late HelpProvider provider;
  late ImagePickProvider imagePickProvider;
  static final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode commentFocus = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    provider = Provider.of<HelpProvider>(context, listen: false);
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imagePickProvider.clearImage();
    });

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    commentController.dispose();
    locationController.dispose();
    titleFocus.dispose();
    commentFocus.dispose();
    super.dispose();
  }

  clearField({required ImagePickProvider imagePickProvider}) {
    imagePickProvider.clearImage();
    titleController.clear();
    commentController.clear();
    locationController.clear();
    unFocusAll();
  }

  unFocusAll() {
    titleFocus.unfocus();
    commentFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Consumer<HelpProvider>(builder: (context, helpProvider, _) {
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
                        "DIY Help",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          child: IconButton(
                              onPressed: () {
                                clearField(
                                    imagePickProvider: imagePickProvider);
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
                  TextFieldWidget(
                      focusNode: titleFocus,
                      controller: titleController,
                      hintText: "Title",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        titleFocus.unfocus();
                        FocusScope.of(context).requestFocus(commentFocus);
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

                  TextFieldWidget(
                      focusNode: commentFocus,
                      controller: commentController,
                      hintText: "Comment",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        commentFocus.unfocus();
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

                  // selected images

                  Consumer<ImagePickProvider>(
                      builder: (context, imageProvider, _) {
                    return imageProvider.images.isEmpty == true
                        ? AppConstant.kheight(height: 10)
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height:
                                imageProvider.images.isEmpty == true ? 0 : 170,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              // gridDelegate:
                              //     const SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 2,
                              // ),
                              itemCount: imageProvider.images.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Image.file(
                                          File(
                                              imageProvider.images[index].path),
                                          height: 190,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              imageProvider.remove(index);
                                            },
                                            icon: const Icon(
                                                Icons.cancel_outlined)),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  }),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      label: Text(
                        "Choose Images",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      onPressed: () {
                        imagePickProvider.pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: AppColor.whiteColor),
                      icon: const FaIcon(
                        FontAwesomeIcons.images,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  AppConstant.kheight(height: 10),
                  helpProvider.isUploadLoading
                      ? SizedBox(
                          width: size.width,
                          child: Center(
                              child: AppConstant.circularProgressIndicator()))
                      : Consumer<LocationProvider>(
                          builder: (context, locProvider, _) {
                          return DefaultButton(
                            height: 50,
                            text: "Submit",
                            onPress: () async {
                              titleFocus.unfocus();
                              commentFocus.unfocus();
                              // setState(() {
                              //   isLoading = true;
                              // });
                              final sharedPrefs =
                                  await SharedPreferences.getInstance();
                              String id = sharedPrefs.getString('id')!;
                              String userType =
                                  sharedPrefs.getString('userType')!;

                              if (_formKey.currentState!.validate()) {
                                AddDiyHelp helpModel = AddDiyHelp(
                                    title: titleController.text,
                                    diyHelp: commentController.text,
                                    images: imagePickProvider.imageFile,
                                    userId: int.parse(id),
                                    userType: userType);
                                bool res = await provider.addHelp(
                                    helpModel: helpModel);
                                if (res == true) {
                                  clearField(
                                      imagePickProvider: imagePickProvider);

                                  //          setState(() {
                                  //   isLoading = false;
                                  // });
                                  // if (!mounted) return;
                                  // Navigator.pop(context);
                                }
                                // ignore: avoid_print
                                // print("valid");
                                // bool res = await bazaarProvider.addBazaarProduct(
                                //     userType: sp!.getString('userType')!,
                                //     userId: int.parse(sp!.getString('id')!),
                                //     productTitle:
                                //         commentController.text.toString(),
                                //     price: priceController.text.toString(),
                                //     description:
                                //         descriptionController.text.toString(),
                                //     location: locationController.text.toString(),
                                //     locationLatitude: locProvider.latitude,
                                //     locationLongitude: locProvider.longitude,
                                //     productImages: imagePickProvider.imageFile);
                                // if (res == true) {
                                //   AppConstant.toastMsg(
                                //       msg: "Product added successfully",
                                //       backgroundColor: AppColor.green);
                                //   clearField(
                                //       provider: bazaarProvider,
                                //       imagePickProvider: imagePickProvider);
                                //   bazaarProvider.fetchBazaarProducts();
                                // } else {
                                //   AppConstant.toastMsg(
                                //       msg: "Something Went Wrong",
                                //       backgroundColor: AppColor.red);
                                // }
                              } else {
                                // ignore: avoid_print
                                print("in valid");
                              }
                              // setState(() {
                              //   isLoading = false;
                              // });
                            },
                            radius: 5,
                            backgroundColor: Colors.green,
                          );
                        }),
                ],
              ),
            ),
          )
        ]);
      }),
    ));
  }
}
