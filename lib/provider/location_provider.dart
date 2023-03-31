import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:flutter/material.dart';

import 'package:google_place/google_place.dart';

class LocationProvider with ChangeNotifier {
  late GooglePlace googlePlace;
  AutocompletePrediction? selected;
  AutocompleteResponse? results;
  List<AutocompletePrediction> predictions = [];
  DetailsResult? detailsResult;
  String locationError = '';
  String latitude = '';
  String longitude = '';

  assignLocation({required String long, required String lat}) {
    latitude = lat;
    longitude = long;
    notifyListeners();
  }

  initializeLocation() {
    googlePlace = GooglePlace(Url.locationApiKey);
  }

  onSelected({required AutocompletePrediction value}) async {
    selected = value;
    String? placeId = value.placeId;
    fetchCoordinates(placeId: placeId);

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
}
