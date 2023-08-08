import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_place/google_place.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/User Location/user_location_data.dart';

class LocationProvider with ChangeNotifier {
  late GooglePlace googlePlace;
  var box = Hive.box<UserLocationDb>('location-box');
  AutocompletePrediction? selected;
  AutocompleteResponse? results;
  List<AutocompletePrediction> predictions = [];
  DetailsResult? detailsResult;
  String locationError = '';
  String latitude = '';
  String longitude = '';

  double? currentUserLatitude;
  double? currentUserLongitude;
  String currentLocationName = '';
  String currentLocationState = '';
  String currentLocationAddress = '';
  bool openSetting = false;
  bool permissionAllowed = false;
  bool retryButton = false;
  bool isLoading = false;

  @override
  void dispose() {
    closeBox(); // Close the box when the provider is disposed
    super.dispose();
  }

  Future<void> closeBox() async {
    await box.close();
  }

//get user current location
  Future<void> requestPermissionAndStoreLocation() async {
    print("Location fetch");
    permissionAllowed = false;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getDouble("latitude") == null ||
          prefs.getDouble("longitude") == null) {
        isLoading = true;
        notifyListeners();
        LocationPermission permission = await Geolocator.requestPermission();
        print("location  null");
        if (permission == LocationPermission.denied) {
          // Handle if permission is denied
          print('Location permission denied');
          retryButton = true;
          notifyListeners();
        } else if (permission == LocationPermission.deniedForever) {
          // Handle if permission is permanently denied
          print('Location permission permanently denied');
          await _openAppSettings();
          retryButton = true;
          openSetting = true;
          notifyListeners();
        } else {
          print("getCurrentPosition");
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          prefs.setDouble('latitude', position.latitude);
          prefs.setDouble('longitude', position.longitude);
          currentUserLatitude = position.latitude;
          currentUserLongitude = position.longitude;
          print("latitude $currentUserLatitude");
          print("longitude $currentUserLongitude");
          getLocationName(currentUserLatitude!, currentUserLongitude!);
          permissionAllowed = true;
          notifyListeners();
        }
      } else {
        print("not null");
        currentUserLatitude = prefs.getDouble("latitude");
        currentUserLongitude = prefs.getDouble("longitude");
        print(prefs.getDouble("latitude"));
        print(prefs.getDouble("longitude"));
        getLocationName(currentUserLatitude!, currentUserLongitude!);
        permissionAllowed = true;
        notifyListeners();
      }
    } catch (e) {
      retryButton = true;
      openSetting = true;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> _openAppSettings() async {
    bool isOpened = await openAppSettings();
    if (!isOpened) {
      print('Could not open app settings');
    }
  }

  assignCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserLatitude = prefs.getDouble("latitude");
    currentUserLongitude = prefs.getDouble("longitude");
    getLocationName(currentUserLatitude!, currentUserLongitude!);
    notifyListeners();
  }

  //convert lat & long to city name
  Future<void> getLocationName(double userlat, double userlong) async {
    print("getLocationName lat $userlat");
    print("getLocationName longitude $userlong");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(userlat, userlong);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      // currentLocationName = placemark.street ?? '';
      currentLocationName = placemark.locality ?? '';
      String state = placemark.administrativeArea ?? '';
      String country = placemark.country ?? '';
      print("address");
      print(currentLocationName);
      print("city");

      print("state");
      print(state);

      notifyListeners();
      addToCart(
          userLocationDb: UserLocationDb(
              latitude: userlat.toString(),
              longitude: userlong.toString(),
              locationName: currentLocationName));
    }
  }

  //fetch location by user input

  assignLocation({required String long, required String lat}) {
    latitude = lat;
    longitude = long;
    notifyListeners();
  }

  initializeLocation() {
    googlePlace = GooglePlace(Url.locationApiKey);
  }

  onSelected(
      {required AutocompletePrediction value, bool? fromHomeScreen}) async {
    selected = value;
    String? placeId = value.placeId;
    await fetchCoordinates(placeId: placeId);
    if (fromHomeScreen != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      currentUserLatitude = latitude.isEmpty ? null : double.parse(latitude);
      currentUserLongitude = longitude.isEmpty ? null : double.parse(longitude);
      if (currentUserLatitude != null && currentUserLongitude != null) {
        prefs.setDouble('latitude', currentUserLatitude!);
        prefs.setDouble('longitude', currentUserLongitude!);
        getLocationName(currentUserLatitude!, currentUserLongitude!);
      }
    }

    notifyListeners();
  }

  Future<void> fetchCoordinates({required String? placeId}) async {
    try {
      var result = await googlePlace.details.get(placeId!);
      if (result != null && result.result != null) {
        detailsResult = result.result;
        if (detailsResult != null &&
            detailsResult!.geometry != null &&
            detailsResult!.geometry!.location != null) {
          latitude = detailsResult!.geometry!.location!.lat.toString();
          longitude = detailsResult!.geometry!.location!.lng.toString();
          print("lat");
          print(latitude);
          print("long");
          print(longitude);
        } else {
          predictions = [];
          selected = null;
          locationError = "Error Occured";
        }
      } else {
        predictions = [];
        selected = null;
        locationError = "Error Occured";
      }
    } catch (e) {
      predictions = [];
      selected = null;
      locationError = e.toString();
    }

    notifyListeners();
  }

  clearPrediction() {
    predictions = [];
    notifyListeners();
  }

  clearAll() {
    latitude = '';
    longitude = '';
    locationError = '';
    predictions = [];
    selected = null;
    results = null;

    notifyListeners();
  }

  clearData() {
    latitude = '';
    longitude = '';
    locationError = '';
    predictions = [];
    selected = null;
    results = null;
  }

  autocompleteSearch({required String search}) async {
    // if (search == null) {
    //
    // }
    predictions = [];
    try {
      if (search.isNotEmpty) {
        results = await googlePlace.autocomplete.get(search);
        // var results = await googlePlace.autocomplete.get(search);
        if (results != null && results!.predictions != null) {
          predictions = results!.predictions!;
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      predictions = [];
    }
    notifyListeners();
  }

  //add to local database
  Future<void> addToCart({required UserLocationDb userLocationDb}) async {
    try {
      List<UserLocationDb> allLocations = box.values.toList();

      bool isLocationExists = allLocations.any((existingLocation) =>
          existingLocation.locationName == userLocationDb.locationName &&
          existingLocation.latitude == userLocationDb.latitude &&
          existingLocation.longitude == userLocationDb.longitude);
      if (!isLocationExists) {
        if (allLocations.length >= 15) {
          box.deleteAt(0);
        }
        await box.add(userLocationDb);
        print("add sucess");
        print("item count ${box.keys.length}");
      } else {
        print("already exists");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  assignDataFromLocalDb(
      {required String lat, required String long, required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', double.parse(lat));
    prefs.setDouble('longitude', double.parse(long));
    currentLocationName = name;
    notifyListeners();
  }
}
