import 'dart:io';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';

import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostAnOfferDialog extends StatefulWidget {
  final TraderOfferListingModel? traderOffer;
  const PostAnOfferDialog({
    super.key,
    this.traderOffer,
  });

  @override
  State<PostAnOfferDialog> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<PostAnOfferDialog> {
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  late TextEditingController offerTitleController;
  late TextEditingController offerContentController;
  late TextEditingController fullPriceController;
  late TextEditingController offerPriceController;
  late TextEditingController validFromController;
  late TextEditingController validToController;
  FocusNode offerTitleFocus = FocusNode();
  FocusNode offerContentFocus = FocusNode();
  FocusNode validFromFocus = FocusNode();
  FocusNode validToFocus = FocusNode();
  FocusNode fullPriceFocus = FocusNode();
  FocusNode offerPriceFocus = FocusNode();
  FocusNode tempFocus = FocusNode();
  bool isLoading = false;
  DateTime? validFrom;
  DateTime? validTo;
  List<int> removeImagesId = [];
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    imagePickProvider.initialValues();
    controller();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeValues();
    });

    super.initState();
  }

  controller() {
    offerTitleController = TextEditingController(
        text:
            widget.traderOffer == null ? "" : widget.traderOffer!.title ?? "");
    offerContentController = TextEditingController(
        text: widget.traderOffer == null
            ? ""
            : widget.traderOffer!.description ?? "");
    fullPriceController = TextEditingController(
        text: widget.traderOffer == null
            ? ""
            : widget.traderOffer!.fullPrice ?? "");
    offerPriceController = TextEditingController(
        text: widget.traderOffer == null
            ? ""
            : widget.traderOffer!.discountPrice ?? "");
    validFromController = TextEditingController(
        text: widget.traderOffer == null
            ? ""
            : widget.traderOffer!.validFrom ?? "");
    validToController = TextEditingController(
        text: widget.traderOffer == null
            ? ""
            : widget.traderOffer!.validTo ?? "");
  }

  initializeValues() {
    if (widget.traderOffer != null) {
      imagePickProvider
          .addImageFromNetwork(widget.traderOffer!.traderofferimages);
    }
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
    tempFocus.dispose();
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
    return AlertDialog(
        content: Form(
      key: _formKey,
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
                    TextWidget(
                      data: "Post Offer",
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
                AppConstant.kheight(height: 8),
                AppConstant.kheight(height: 10),
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
                AppConstant.kheight(height: 10),
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
                AppConstant.kheight(height: 10),
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
                AppConstant.kheight(height: 10),

                TextFieldWidget(
                    focusNode: offerPriceFocus,
                    controller: offerPriceController,
                    hintText: "Discount Price",
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (p0) {
                      offerPriceFocus.unfocus();
                    },
                    onEditingComplete: () {
                      offerPriceFocus.unfocus();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                //valid from
                AppConstant.kheight(height: 10),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(tempFocus);
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
                    FocusScope.of(context).requestFocus(validFromFocus);

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
                AppConstant.kheight(height: 10),
                //valid to
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(tempFocus);
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
                    FocusScope.of(context).requestFocus(validToFocus);

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
                        FocusScope.of(context).requestFocus(validToFocus);
                      },
                      onEditingComplete: () {
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

                // selected images

                widget.traderOffer != null
                    ? Consumer<ImagePickProvider>(
                        builder: (context, imageProvider, _) {
                        return imageProvider.networkAndFileImages.isEmpty ==
                                true
                            ? AppConstant.kheight(height: 10)
                            : Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: imageProvider
                                            .networkAndFileImages.isEmpty ==
                                        true
                                    ? 0
                                    : 170,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:
                                      imageProvider.networkAndFileImages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final data = imageProvider
                                        .networkAndFileImages[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: data.isNetwork == false
                                                ? Image.file(
                                                    File(data.fileImage!.path),
                                                    height: 190,
                                                    width: 150,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    data.networkImage ?? "",
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
                                                  if (data.isNetwork!) {
                                                    removeImagesId.add(index);
                                                  }
                                                  imageProvider
                                                      .removeNetworkFileImage(
                                                          index);
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
                      })
                    : Consumer<ImagePickProvider>(
                        builder: (context, imageProvider, _) {
                        return imageProvider.images.isEmpty == true
                            ? AppConstant.kheight(height: 10)
                            : Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: imageProvider.images.isEmpty == true
                                    ? 0
                                    : 170,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: imageProvider.images.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Image.file(
                                              File(imageProvider
                                                  .images[index].path),
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
                    label: TextWidget(
                      data: "Choose Images",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(tempFocus);
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
                isLoading == true
                    ? AppConstant.circularProgressIndicator()
                    : widget.traderOffer == null
                        ? Consumer<ImagePickProvider>(
                            builder: (context, provider, _) {
                            return DefaultButton(
                              height: 50,
                              text: "Post Offer",
                              onPress: () async {
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;

                                if (_formKey.currentState!.validate() &&
                                    validFrom != null &&
                                    validTo != null &&
                                    provider.imageFile.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  PostOfferModel postOfferModel =
                                      PostOfferModel(
                                          offerTitle: offerTitleController.text
                                              .trim()
                                              .toString(),
                                          offerContent: offerContentController
                                              .text
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
                                          traderId: int.parse(id));
                                  // ignore: avoid_print
                                  print("valid");
                                  if (widget.traderOffer == null) {
                                    bool res =
                                        await profileProvider.postAnOffer(
                                            offerModel: postOfferModel);
                                    if (res == true) {
                                      profileProvider.getTraderOffers(
                                          urlUserType: 'trader', traderId: id);
                                      clearField();
                                    } else {}
                                  } else {
                                    List<File> imageFile = [];
                                    for (var element
                                        in provider.networkAndFileImages) {
                                      if (element.isNetwork == false) {
                                        imageFile.add(element.fileImage!);
                                      }
                                    }
                                    removeImagesId.forEach((element) {
                                      print("remove id");
                                      print(element);
                                    });
                                    postOfferModel.offerImages = imageFile;

                                    bool res =
                                        await profileProvider.updateOffer(
                                            removeImages: removeImagesId,
                                            offerId: widget.traderOffer!.id!,
                                            offerModel: postOfferModel);

                                    if (res == true) {
                                      removeImagesId = [];
                                      profileProvider.getTraderOffers(
                                          urlUserType: 'trader', traderId: id);
                                      clearField();
                                    } else {}
                                  }
                                  // await profileProvider
                                  //     .postAnOffer(offerModel: postOfferModel)
                                  //     .then((value) {
                                  // AppConstant.toastMsg(
                                  //     msg: "Offer posted sucessfully",
                                  //     backgroundColor: AppColor.green);

                                  // clearField();

                                  //   return;
                                  // }).onError((error, stackTrace) {
                                  //   print("errorr  message ");
                                  //   print(error.toString());
                                  // AppConstant.toastMsg(
                                  //     msg: error.toString(),
                                  //     backgroundColor: AppColor.red);

                                  //   return;
                                  // });
                                } else {
                                  AppConstant.toastMsg(
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
                          })
                        : Consumer<ImagePickProvider>(
                            builder: (context, provider, _) {
                            return DefaultButton(
                              height: 50,
                              text: "Update Offer",
                              onPress: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (_formKey.currentState!.validate() &&
                                    provider.networkAndFileImages.isNotEmpty) {
                                  final sharedPrefs =
                                      await SharedPreferences.getInstance();
                                  String id = sharedPrefs.getString('id')!;
                                  PostOfferModel postOfferModel =
                                      PostOfferModel(
                                          offerTitle: offerTitleController.text
                                              .trim()
                                              .toString(),
                                          offerContent: offerContentController
                                              .text
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
                                          traderId: int.parse(id));
                                  List<File> imageFile = [];
                                  for (var element
                                      in provider.networkAndFileImages) {
                                    if (element.isNetwork == false) {
                                      imageFile.add(element.fileImage!);
                                    }
                                  }
                                  removeImagesId.forEach((element) {
                                    print("remove id");
                                    print(element);
                                  });
                                  postOfferModel.offerImages = imageFile;

                                  bool res = await profileProvider.updateOffer(
                                      removeImages: removeImagesId,
                                      offerId: widget.traderOffer!.id!,
                                      offerModel: postOfferModel);

                                  if (res == true) {
                                    removeImagesId = [];
                                    profileProvider.getTraderOffers(
                                        urlUserType: 'trader', traderId: id);
                                    imagePickProvider.initialValues();
                                    clearField();
                                  } else if (res == false) {
                                    print("failed updates");
                                  }
                                } else {
                                  AppConstant.toastMsg(
                                      msg: "Please fill all Fields",
                                      backgroundColor: AppColor.green);
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
    ));
  }
}
