import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/search_results.dart';
import 'package:codecarrots_unotraders/screens/job/components/job_search_results.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';

import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import '../../../../provider/location_provider.dart';

class SearchJobBazaar extends StatefulWidget {
  final bool isJob;
  // final LocationData location;
  const SearchJobBazaar({
    super.key,
    required this.isJob,
    // required this.location,
  });

  @override
  State<SearchJobBazaar> createState() => _SearchBazaarState();
}

class _SearchBazaarState extends State<SearchJobBazaar> {
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  FocusNode locationFocus = FocusNode();
  late LocationProvider locationProvider;
  late JobProvider jobProvider;
  late BazaarProvider bazaarProvider;
  bool isLoading = false;
  double _value = 5.0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locationProvider = Provider.of<LocationProvider>(context, listen: false);
      jobProvider = Provider.of<JobProvider>(context, listen: false);
      bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
      bazaarProvider.clearCategories();
      locationProvider.initializeLocation();
      locationProvider.clearAll();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  clearField({
    required BazaarProvider provider,
  }) {
    locationProvider.clearAll();

    provider.clearCategories();
  }

  @override
  Widget build(BuildContext context) {
    print("pop up");
    final size = MediaQuery.of(context).size;

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
                      data: widget.isJob == false
                          ? "Search Products"
                          : "Search Job",
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        child: IconButton(
                            onPressed: () {
                              clearField(
                                provider: bazaarProvider,
                              );

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
                    controller: searchController,
                    hintText: widget.isJob == false
                        ? "Search for Product"
                        : "Search Jobs",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                AppConstant.kheight(height: 10),
                widget.isJob
                    ? Consumer<JobProvider>(builder: (context, provider, _) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: TextWidget(data: "Main Category"),
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
                              value: provider.selectedcategory,
                              items: provider.categoryErrorMessage.isNotEmpty
                                  ? [
                                      DropdownMenuItem(
                                        value: provider.categoryErrorMessage,
                                        child: TextWidget(
                                          data: provider.categoryErrorMessage,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ]
                                  : provider.categoryList.map((e) {
                                      return DropdownMenuItem(
                                        value: e.category,
                                        child: TextWidget(data: e.category!),
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                if (provider.categoryErrorMessage.isEmpty) {
                                  provider.changeCategory(
                                      categoryName: value.toString());
                                }
                              }),
                        );
                      })
                    : Consumer<BazaarProvider>(builder: (context, provid, _) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField(
                              hint: TextWidget(data: "Main Category"),
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
                                  child: TextWidget(data: e.category!),
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

                widget.isJob
                    ? Consumer<JobProvider>(builder: (context, provider, _) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: TextWidget(data: "Sub Category"),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.blackColor)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    provider
                                        .subCategoryErrorMessage.isNotEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              value: provider.selectedSubCategory,
                              items: provider.subCategoryErrorMessage.isNotEmpty
                                  ? [
                                      DropdownMenuItem(
                                        value: provider.subCategoryErrorMessage,
                                        child: TextWidget(
                                          data:
                                              provider.subCategoryErrorMessage,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ]
                                  : provider.subCategoryList.map((e) {
                                      return DropdownMenuItem(
                                        value: e.category,
                                        child: TextWidget(data: e.category!),
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                if (provider.subCategoryErrorMessage.isEmpty) {
                                  provider.changeSubCategory(
                                      categoryName: value.toString());
                                }
                              }),
                        );
                      })
                    : Consumer<BazaarProvider>(builder: (context, provider, _) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField(
                              hint: TextWidget(data: "Sub Category"),
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
                                  child: TextWidget(data: e.category!),
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
                                  title: TextWidget(
                                      data: locProvider
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
                        ? TextWidget(
                            data: locProvider.locationError,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox();
                  }),
                ),
                AppConstant.kheight(height: 10),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(data: "Location Range"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: SfSlider(
                                min: 0,
                                max: 50,
                                value: _value,
                                thumbIcon: Center(
                                  child: TextWidget(
                                    data: _value.toStringAsFixed(0).toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                edgeLabelPlacement: EdgeLabelPlacement.inside,
                                labelPlacement: LabelPlacement.betweenTicks,
                                interval: 1,
                                stepSize: 1,
                                showTicks: false,
                                showLabels: false,
                                enableTooltip: true,
                                minorTicksPerInterval: 0,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                            if (_formKey.currentState!.validate()) {
                              if (widget.isJob == false) {
                                bazaarProvider.searchBazaarProduct(
                                    distance: _value.toInt(),
                                    latitude:
                                        double.parse(locProvider.latitude),
                                    longitude:
                                        double.parse(locProvider.longitude),
                                    query: searchController.text
                                        .trim()
                                        .toString());

                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchResults(
                                        distance: _value.toInt(),
                                        latitude:
                                            double.parse(locProvider.latitude),
                                        longitude:
                                            double.parse(locProvider.longitude),
                                        query: searchController.text
                                            .trim()
                                            .toString(),
                                      ),
                                    ));
                              } else {
                                jobProvider.searchJob(
                                    distance: _value.toInt(),
                                    latitude:
                                        double.parse(locProvider.latitude),
                                    longitude:
                                        double.parse(locProvider.longitude),
                                    query: searchController.text
                                        .trim()
                                        .toString());

                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobSearchResults(
                                        distance: _value.toInt(),
                                        latitude:
                                            double.parse(locProvider.latitude),
                                        longitude:
                                            double.parse(locProvider.longitude),
                                        query: searchController.text
                                            .trim()
                                            .toString(),
                                      ),
                                    ));
                              }
                              // ignore: avoid_print
                              print("valid");
                            } else {
                              // ignore: avoid_print
                              print("in valid");
                            }
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
  // _getCurrentLocation() {
  //   Geolocator
  //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //     .then((Position position) {
  //       setState(() {
  //         _currentPosition = position;
  //         _getAddressFromLatLng();
  //       });
  //     }).catchError((e) {
  //       print(e);
  //     });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       _currentPosition!.latitude,
  //       _currentPosition!.longitude
  //     );

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
}
   

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: TextWidget(data:
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: TextWidget(data:'Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: TextWidget(data:
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) {
//       print("granted");
// return;
//     }
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//}
