import 'dart:io';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../provider/location_provider.dart';

class BazaarPopUp extends StatefulWidget {
  const BazaarPopUp({
    super.key,
  });

  @override
  State<BazaarPopUp> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<BazaarPopUp> {
  late ImagePickProvider imagePickProvider;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  FocusNode categoryFocus = FocusNode();
  FocusNode subCategoryFocus = FocusNode();
  FocusNode productFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode locationFocus = FocusNode();
  late LocationProvider locationProvider;
  bool isLoading = false;

  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<File> imageFile = [];
  static final _formKey = GlobalKey<FormState>();

  Widget _buildButton(BuildContext context, String text, IconData icon,
      VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
            ),
            const SizedBox(width: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(
      BuildContext context, ImagePickProvider imagePickProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              _buildButton(context, 'Capture with Camera', Icons.camera_alt,
                  () {
                imagePickProvider.pickImageFromCamera();
                Navigator.pop(context);
              }),
              SizedBox(height: 16.0),
              _buildButton(context, 'Pick from Gallery', Icons.photo_library,
                  () {
                imagePickProvider.pickImage();
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locationProvider = Provider.of<LocationProvider>(context, listen: false);
      imagePickProvider.clearImage();
      locationProvider.initializeLocation();
      locationProvider.clearAll();
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    priceController.dispose();
    productController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    locationFocus.dispose();
    categoryFocus.dispose();
    subCategoryFocus.dispose();
    productFocus.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  clearField(
      {required BazaarProvider provider,
      required ImagePickProvider imagePickProvider}) {
    locationProvider.clearAll();
    imagePickProvider.clearImage();
    provider.clearCategories();
    textEditingController.clear();
    priceController.clear();
    productController.clear();
    descriptionController.clear();
    locationController.clear();
    locationFocus.unfocus();
    categoryFocus.unfocus();
    subCategoryFocus.unfocus();
    productFocus.unfocus();
    priceFocus.unfocus();
    descriptionFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);

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
                      "Sell at Bazaar",
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
                Consumer<BazaarProvider>(builder: (context, provid, _) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField(
                        hint: const Text("Category"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.blackColor)),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "This field is required";
                          }
                          return null;
                        },
                        value: provid.selectedcategory,
                        items: provid.bazaarCategoriesList.map((e) {
                          return DropdownMenuItem(
                            value: e.category,
                            child: Text(e.category!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          bazaarProvider.changeCategory(
                              categoryName: value.toString());
                        }),
                  );
                }),
                AppConstant.kheight(height: 10),
                //sub category
                Consumer<BazaarProvider>(builder: (context, provider, _) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField(
                        hint: const Text("Sub category"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.blackColor)),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "This field is required";
                          }
                          return null;
                        },
                        value: provider.selectedSubCategory,
                        items: provider.subCategoriesList.map((e) {
                          return DropdownMenuItem(
                            value: e.category,
                            child: Text(e.category!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          bazaarProvider.changeSubCategory(
                              categoryName: value.toString());
                        }),
                  );
                }),
                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: productFocus,
                    controller: productController,
                    hintText: "Product",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      productFocus.unfocus();
                      FocusScope.of(context).requestFocus(priceFocus);
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
                    focusNode: priceFocus,
                    controller: priceController,
                    hintText: "Price",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      priceFocus.unfocus();
                      FocusScope.of(context).requestFocus(descriptionFocus);
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
                    focusNode: descriptionFocus,
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 9,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      descriptionFocus.unfocus();
                      FocusScope.of(context).requestFocus(locationFocus);
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

                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    label: Text(
                      "Choose Images",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    onPressed: () {
                      AppConstant.showImagePicker(context, imagePickProvider);
                      // _showImagePicker(context, imagePickProvider);
                      // imagePickProvider.pickImage();
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
                //       Provider.of<ImagePickProvider>(context, listen: true)
                //         .images
                //         .isEmpty ==
                //     true
                // ? const SizedBox(
                //     height: 10,
                //   )
                // : const SizedBox(),
                AppConstant.kheight(height: 10),
                isLoading == true
                    ? AppConstant.circularProgressIndicator()
                    : Consumer<LocationProvider>(
                        builder: (context, locProvider, _) {
                        return DefaultButton(
                          height: 50,
                          text: "Sell at Bazaar",
                          onPress: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              // ignore: avoid_print
                              print("valid");
                              bool res = await bazaarProvider.addBazaarProduct(
                                  userType: sp!.getString('userType')!,
                                  userId: int.parse(sp!.getString('id')!),
                                  productTitle:
                                      productController.text.toString(),
                                  price: priceController.text.toString(),
                                  description:
                                      descriptionController.text.toString(),
                                  location: locationController.text.toString(),
                                  locationLatitude: locProvider.latitude,
                                  locationLongitude: locProvider.longitude,
                                  productImages: imagePickProvider.imageFile);
                              if (res == true) {
                                AppConstant.toastMsg(
                                    msg: "Product added successfully",
                                    backgroundColor: AppColor.green);
                                clearField(
                                    provider: bazaarProvider,
                                    imagePickProvider: imagePickProvider);
                                bazaarProvider.fetchBazaarProducts();
                              } else {
                                AppConstant.toastMsg(
                                    msg: "Something Went Wrong",
                                    backgroundColor: AppColor.red);
                              }

                              //     then((value) {
                              // AppConstant.toastMsg(
                              //     msg: "Product added successfully",
                              //     backgroundColor: AppColor.green);
                              // clearField(
                              //     provider: bazaarProvider,
                              //     imagePickProvider: imagePickProvider);
                              //   return;

                              // }).onError((error, stackTrace) {
                              // AppConstant.toastMsg(
                              //     msg: error.toString(),
                              //     backgroundColor: AppColor.red);

                              //   return;
                              // });
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
