import 'dart:io';
import 'package:codecarrots_unotraders/model/Trader%20Search/trader_search.dart';
import 'package:codecarrots_unotraders/screens/homepage/trader_search_result_screen.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/location_provider.dart';

class TraderSearchPopUp extends StatefulWidget {
  const TraderSearchPopUp({
    super.key,
  });

  @override
  State<TraderSearchPopUp> createState() => _TraderSearchPopUpState();
}

class _TraderSearchPopUpState extends State<TraderSearchPopUp> {
  TextEditingController traderTitleController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  FocusNode traderTitleFocus = FocusNode();
  FocusNode distanceFocus = FocusNode();

  FocusNode locationFocus = FocusNode();
  late LocationProvider locationProvider;
  bool isLoading = false;

  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<File> imageFile = [];
  static final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locationProvider = Provider.of<LocationProvider>(context, listen: false);
      locationProvider.initializeLocation();
      locationProvider.clearAll();
    });
    super.initState();
  }

  @override
  void dispose() {
    distanceController.dispose();
    traderTitleController.dispose();

    locationController.dispose();
    locationFocus.dispose();

    traderTitleFocus.dispose();
    distanceFocus.dispose();

    super.dispose();
  }

  clearField(
      {required BazaarProvider provider,
      required ImagePickProvider imagePickProvider}) {
    locationProvider.clearAll();
    imagePickProvider.clearImage();
    provider.clearCategories();

    distanceController.clear();
    traderTitleController.clear();

    locationController.clear();
    locationFocus.unfocus();

    traderTitleFocus.unfocus();
    distanceFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
    final imagePickProvider =
        Provider.of<ImagePickProvider>(context, listen: false);

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                      "Search",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        child: IconButton(
                            onPressed: () {
                              clearField(
                                  provider: bazaarProvider,
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
                    focusNode: traderTitleFocus,
                    controller: traderTitleController,
                    hintText: "Trader (e.g. Electrician)",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      traderTitleFocus.unfocus();
                      FocusScope.of(context).requestFocus(distanceFocus);
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
                    focusNode: locationFocus,
                    controller: locationController,
                    hintText: "Location",
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        locationProvider.autocompleteSearch(search: value);
                      } else {
                        locationProvider.clearAll();
                      }
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (p0) {
                      locationFocus.unfocus();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),

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
                                onTap: () async {
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
                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: distanceFocus,
                    controller: distanceController,
                    hintText: "Distance in kms",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (p0) {
                      distanceFocus.unfocus();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                Container(
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

                AppConstant.kheight(height: 10),
                isLoading == true
                    ? AppConstant.circularProgressIndicator()
                    : Consumer<LocationProvider>(
                        builder: (context, locProvider, _) {
                        return DefaultButton(
                          height: 50,
                          text: "Search",
                          onPress: () async {
                            final sharedPref =
                                await SharedPreferences.getInstance();
                            String id = sharedPref.getString('id')!;
                            String userType = sharedPref.getString('userType')!;
                            setState(() {
                              isLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              TraderSearch traderSearch = TraderSearch(
                                  distance: double.parse(
                                          distanceController.text.toString())
                                      .toInt(),
                                  lat: double.parse(locProvider.latitude),
                                  long: double.parse(locProvider.longitude),
                                  userId: int.parse(id),
                                  userType: userType,
                                  trade: traderTitleController.text.toString());
                              // ignore: avoid_print
                              print("valid");
                              print(traderSearch.toJson());
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TraderSearchResultsScreen(
                                        traderSearchModel: traderSearch,
                                      )));

                              // bool res = await bazaarProvider.addBazaarProduct(
                              //     userType: sp!.getString('userType')!,
                              //     userId: int.parse(sp!.getString('id')!),
                              //     productTitle:
                              //         traderTitleController.text.toString(),
                              //     price: distanceController.text.toString(),
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
