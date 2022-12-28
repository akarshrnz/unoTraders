import 'dart:io';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';

import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../provider/location_provider.dart';

class PostAnOfferDialog extends StatefulWidget {
  const PostAnOfferDialog({
    super.key,
  });

  @override
  State<PostAnOfferDialog> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<PostAnOfferDialog> {
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  TextEditingController offerTitleController = TextEditingController();
  TextEditingController offerContentController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController validFromController = TextEditingController();
  TextEditingController validToController = TextEditingController();
  FocusNode offerTitleFocus = FocusNode();
  FocusNode offerContentFocus = FocusNode();
  FocusNode validFromFocus = FocusNode();
  FocusNode validToFocus = FocusNode();
  FocusNode fullPriceFocus = FocusNode();
  FocusNode offerPriceFocus = FocusNode();
  bool isLoading = false;
  DateTime? validFrom;
  DateTime? validTo;
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    imagePickProvider.initialValues();
    super.initState();
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
  void dispose() {
    validFromController.dispose();
    validToController.dispose();
    offerTitleController.dispose();
    fullPriceController.dispose();
    offerContentController.dispose();
    offerPriceController.dispose();
    offerTitleFocus.dispose();
    validFromFocus.dispose();
    validToFocus.dispose();
    offerContentFocus.dispose();
    fullPriceFocus.dispose();
    offerPriceFocus.dispose();
    super.dispose();
  }

  unfocus() {
    offerTitleFocus.unfocus();
    offerContentFocus.unfocus();
    fullPriceFocus.unfocus();
    validFromFocus.unfocus();
    validToFocus.unfocus();
    offerPriceFocus.unfocus();
  }

  clearField() {
    validFrom = null;
    validTo = null;
    imagePickProvider.clearImage();
    offerTitleController.clear();
    validFromController.clear();
    validToController.clear();
    fullPriceController.clear();
    offerContentController.clear();
    offerPriceController.clear();
    offerTitleFocus.unfocus();
    offerContentFocus.unfocus();
    fullPriceFocus.unfocus();
    validFromFocus.unfocus();
    validToFocus.unfocus();
    offerPriceFocus.unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final imagePickProvider =
        Provider.of<ImagePickProvider>(context, listen: false);

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Listener(onPointerDown: (event) {
    FocusManager.instance.primaryFocus?.unfocus();
  },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  //heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const Text(
                        "Post Offer",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          child: IconButton(
                              onPressed: () {
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
                  Constant.kheight(height: 8),
                  Constant.kheight(height: 10),
                  //offer title
                  TextFieldWidget(
                      focusNode: offerTitleFocus,
                      controller: offerTitleController,
                      hintText: "Product Title",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        offerTitleFocus.unfocus();
                        FocusScope.of(context).requestFocus(offerContentFocus);
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  Constant.kheight(height: 10),
                  //offer content
                  TextFieldWidget(
                      focusNode: offerContentFocus,
                      controller: offerContentController,
                      hintText: "Description",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        offerContentFocus.unfocus();
                        FocusScope.of(context).requestFocus(fullPriceFocus);
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  Constant.kheight(height: 10),
                  TextFieldWidget(
                      focusNode: fullPriceFocus,
                      controller: fullPriceController,
                      hintText: "Full Price",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        fullPriceFocus.unfocus();
                        FocusScope.of(context).requestFocus(offerPriceFocus);
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  Constant.kheight(height: 10),
      
                  TextFieldWidget(
                      focusNode: offerPriceFocus,
                      controller: offerPriceController,
                      hintText: "Discount Price",
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (p0) {
                        offerPriceFocus.unfocus();
                        FocusScope.of(context).requestFocus(validFromFocus);
                      },
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      }),
                  //valid from
                  Constant.kheight(height: 10),
                  InkWell(
                    onTap: () async {
                      final date = await pickDate();
                      if (date == null) return;
                      final time = await picktime();
                      if (time == null) return;
      
                      validFrom = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      final amPm = DateFormat('hh:mm a').format(validFrom!);
                      String dateRes =
                          "${date.day}-${date.month}-${date.year} $amPm";
                      validFromController.text = dateRes;
      
                      setState(() {});
                    },
                    child: TextFieldWidget(
                        enabled: false,
                        focusNode: validFromFocus,
                        controller: validFromController,
                        hintText: "Valid From",
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.none,
                        onFieldSubmitted: (p0) {
                          unfocus();
                          validFromFocus.unfocus();
      
                          FocusScope.of(context).requestFocus(validToFocus);
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Constant.kheight(height: 10),
                  //valid to
                  InkWell(
                    onTap: () async {
                      final date = await pickDate();
                      if (date == null) return;
                      final time = await picktime();
                      if (time == null) return;
      
                      validTo = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      print(validTo.toString());
                      final amPm = DateFormat('hh:mm a').format(validFrom!);
                      String dateRes =
                          "${date.day}-${date.month}-${date.year} $amPm";
                      validToController.text = dateRes;
      
                      setState(() {});
                    },
                    child: TextFieldWidget(
                        enabled: false,
                        keyboardType: TextInputType.none,
                        focusNode: validToFocus,
                        controller: validToController,
                        hintText: "Valid To",
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                      
                          validToFocus.unfocus();
                          unfocus();
                        },
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                  ),
      
                  // selected images
      
                  Consumer<ImagePickProvider>(
                      builder: (context, imageProvider, _) {
                    return imageProvider.images.isEmpty == true
                        ? Constant.kheight(height: 10)
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
                              itemCount: imageProvider.images.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black)),
                                        child: Image.file(
                                          File(imageProvider.images[index].path),
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
      
      //images
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
      
                  Constant.kheight(height: 10),
                  isLoading == true
                      ? Constant.circularProgressIndicator()
                      : Consumer<ImagePickProvider>(
                          builder: (context, provider, _) {
                          return DefaultButton(
                            height: 50,
                            text: "Post Offer",
                            onPress: () async {
                              if (_formKey.currentState!.validate() &&
                                  validFrom != null &&
                                  validTo != null &&
                                  provider.imageFile.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                PostOfferModel postOfferModel = PostOfferModel(
                                    offerTitle: offerTitleController.text
                                        .trim()
                                        .toString(),
                                    offerContent: offerContentController.text
                                        .trim()
                                        .toString(),
                                    fullPrice: fullPriceController.text
                                        .trim()
                                        .toString(),
                                    offerPrice: offerPriceController.text
                                        .trim()
                                        .toString(),
                                    offerImages: provider.imageFile,
                                    validFrom: validFromController.text,
                                    validTo: validToController.text,
                                    traderId: int.parse(ApiServicesUrl.id));
                                // ignore: avoid_print
                                print("valid");
                                await profileProvider
                                    .postAnOffer(offerModel: postOfferModel)
                                    .then((value) {
                                  Constant.toastMsg(
                                      msg: "Offer posted sucessfully",
                                      backgroundColor: AppColor.green);
      
                                  clearField();
      
                                  return;
                                }).onError((error, stackTrace) {
                                  print("errorr  message ");
                                  print(error.toString());
                                  Constant.toastMsg(
                                      msg: error.toString(),
                                      backgroundColor: AppColor.red);
      
                                  return;
                                });
                              } else {
                                Constant.toastMsg(
                                    msg: "Please fill all Fields",
                                    backgroundColor: AppColor.green);
                                // ignore: avoid_print
                                print("in valid");
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            radius: 5,
                            backgroundColor: Colors.green,
                          );
                        }),
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
