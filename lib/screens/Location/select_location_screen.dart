import 'package:codecarrots_unotraders/model/User%20Location/user_location_data.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserLocationScreen extends StatefulWidget {
  static const routeName = '/selectUserLocationScreen';
  const SelectUserLocationScreen({super.key});

  @override
  State<SelectUserLocationScreen> createState() =>
      _SelectUserLocationScreenState();
}

class _SelectUserLocationScreenState extends State<SelectUserLocationScreen> {
  TextEditingController locationController = TextEditingController();
  FocusNode locationFocus = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late LocationProvider locationProvider;
  late final Box<UserLocationDb> box;
  bool unFocusNode = false;

  @override
  void initState() {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    box = Hive.box<UserLocationDb>('location-box');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locationProvider.initializeLocation();
      locationProvider.clearAll();
    });

    super.initState();
  }

  @override
  void dispose() {
    locationFocus.dispose();

    locationController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissionAndStoreLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle if permission is denied
      print('Location permission denied');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle if permission is permanently denied
      print('Location permission permanently denied');
      // await _openAppSettings();
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      getLocationName(position.latitude, position.longitude);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);

      locationProvider.assignCurrentLocation();
      setState(() {});
      locationController.selection =
          TextSelection.collapsed(offset: locationController.text.length);
    }
  }

  Future<void> _openAppSettings() async {
    bool isOpened = await openAppSettings();
    if (!isOpened) {
      print('Could not open app settings');
    }
  }

  Future<void> getLocationName(double userlat, double userlong) async {
    print("getLocationName lat $userlat");
    print("getLocationName longitude $userlong");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(userlat, userlong);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      locationController.text = placemark.locality ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final routes = ModalRoute.of(context)!.settings.arguments as bool;
    if (routes == true && unFocusNode == false) {
      FocusScope.of(context).requestFocus(locationFocus);
    }
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Container(
              color: AppColor.secondaryColor,
              // height: 70,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColor.whiteColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 8, right: 35),
                      child: TextFieldWidget(
                          focusNode: locationFocus,
                          controller: locationController,
                          hintText: "Choose Location",
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              locationProvider.autocompleteSearch(
                                  search: value);
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
                    ),
                  ),
                ],
              ),
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
                                  fromHomeScreen: true,
                                  value: locProvider.predictions[index]);
                              locationController.text =
                                  locProvider.selected!.description.toString();
                              locationProvider.clearPrediction();
                              Navigator.pop(context);
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
            Flexible(
              child: ValueListenableBuilder<Box<UserLocationDb>>(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const SizedBox();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        var box = value;
                        var getData = box.getAt(index);

                        return getData == null
                            ? SizedBox()
                            : ListTile(
                                onTap: () {
                                  locationFocus.unfocus();
                                  locationController.text =
                                      getData.locationName.toString();
                                  locationProvider.assignDataFromLocalDb(
                                      lat: getData.latitude,
                                      long: getData.longitude,
                                      name: getData.locationName);
                                  Navigator.pop(context);
                                },
                                leading: Icon(Icons.location_on),
                                title: Text(getData.locationName),

                                // trailing: IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(Icons.delete),
                                // ),
                              );
                      },
                    );
                  }
                },
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(left: 39, top: 5),
            //   child: InkWell(
            //     onTap: () {
            //       _requestPermissionAndStoreLocation();
            //     },
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Image.asset(PngImages.navigation),
            //         ),
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Use current location",
            //               style: TextStyle(
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.w500,
            //                   color: Colors.grey.shade900),
            //             ),
            //             Text(
            //               "Enable location",
            //               style: TextStyle(
            //                   fontSize: 12, color: Colors.grey.shade900),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            ,
          ],
        ),
      ),
    );
  }

  Column columnWidget({required Widget widgetOne, required Widget widgetTwo}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstant.kheight(height: 5),
        widgetOne,
        AppConstant.kheight(height: 3),
        widgetTwo,
      ],
    );
  }
}
