import 'dart:convert';

import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_cust_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices {
  static Future<CustomerProfileModel> getCustomerProfile(
      {required String id}) async {
    print('${ApiServicesUrl.customerProfile}$id');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.customerProfile}$id'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      if (body["status"] == 200) {
        print("sucess");

        return CustomerProfileModel.fromJson(body["data"]);
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  //update profile
  static Future<void> updateProfile({
    required UpdateProfileModel updateProfile,
  }) async {
    var formData;
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    print("update $id");
    if (updateProfile.profileImage == null) {
      formData = FormData.fromMap({
        "id": id,
        "name": updateProfile.name,
        "address": updateProfile.address,
        "location": updateProfile.location,
        "locationLatitude": updateProfile.locationLatitude,
        "locationLongitude": updateProfile.locationLongitude,
      });
    } else {
      formData = FormData.fromMap({
        "id": id,
        "name": updateProfile.name,
        "address": updateProfile.address,
        "location": updateProfile.location,
        "locationLatitude": updateProfile.locationLatitude,
        "profileImage": await MultipartFile.fromFile(
          updateProfile.profileImage!.path,
        ),
        "locationLongitude": updateProfile.locationLongitude,
      });
    }

    // print(updateProfile.profileImage!.path);
    // print(formData.fields);
    // formData.files.addAll([
    //   MapEntry("profileImage",
    //       await MultipartFile.fromFile(updateProfile.profileImage!.path)),
    // ]);

    // Uint8List bytes = updateProfile.profileImage!.readAsBytesSync();
    // String base64Image = base64Encode(bytes);
    // List<int> imageBytes = updateProfile.profileImage!.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);
    // print(base64Image);
    // UpdateCusProfileModel up = UpdateCusProfileModel(
    //     name: updateProfile.name,
    //     address: updateProfile.address,
    //     location: updateProfile.location,
    //     locationLatitude: updateProfile.locationLatitude,
    //     locationLongitude: updateProfile.locationLongitude,
    //     profileImage: base64Image);
    // print(up.toJson());

    // var request = http.MultipartRequest(
    //     "POST",
    //     Uri.parse(
    //         "https://demo.unotraders.com/api/v1/customer/update-profile/$id"));
    // //add text fields
    // request.fields["name"] = updateProfile.name!;
    // request.fields["address"] = updateProfile.address!;
    // request.fields["location"] = updateProfile.location!;
    // request.fields["locationLatitude"] = updateProfile.locationLatitude!;
    // request.fields["locationLongitude"] = updateProfile.locationLongitude!;
    // //create multipart using filepath, string or bytes
    // var pic = await http.MultipartFile.fromPath(
    //     "profileImage", updateProfile.profileImage!.path);
    // request.headers.addAll(Header.header);
    // //add multipart to request
    // request.files.add(pic);

    try {
      // var response = await http.put(
      //     Uri.parse(
      //         'https://demo.unotraders.com/api/v1/customer/update-profile/$id'),
      //     headers: Header.header,
      //     body: jsonEncode(up.toJson()));
      var response;
      response = await DioClient.dio.post(
          'https://demo.unotraders.com/api/v1/customer/update-profile',
          data: formData,
          options: Options(headers: Header.header));
      print(response.statusCode.toString());
      // print(response.body);
      if (response.statusCode.toString() == '200') {
        // print(response.body);
        // print(response.body['status'].toString());
        // print(response.body['message'].toString());
      } else {
        throw "Something went Wrong";
      }
    } catch (e) {
      print("########################################");
      print(e.toString());
    }
  }

  //trader profile
  static Future<TraderProfileModel> getTraderProfile(
      {required String id}) async {
    print('${ApiServicesUrl.traderProfile}$id');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.traderProfile}$id'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      if (body["status"] == 200) {
        print("sucess");

        return TraderProfileModel.fromJson(body["data"]);
      } else {
        throw body["message"];
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  //provider profile
  static Future<List<ProviderProfileModel>> getProviderProfile(
      {required String id}) async {
    print('https://demo.unotraders.com/api/v1/subcategory/$id');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/subcategory/$id'),
        headers: Header.header,
      );
      print(response.body);
      body = jsonDecode(response.body);
      if (body["status"] == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return ProviderProfileModel.snapshot(tempList);
      } else {
        throw body["message"];
      }
    } catch (e) {
      print(e.toString());
      throw body.isNotEmpty ? body["message"] : Exception();
    }
  }

  //add post
  static Future<void> addPost({required AddPostModel addPost}) async {
    var dio = Dio();

    print("add post");
    var formData = FormData.fromMap({
      "traderId": addPost.traderId,
      "postTitle": addPost.postTitle,
      "postContent": addPost.postContent,
      "postImages[]": []
    });
    for (var file in addPost.postImages!) {
      formData.files.addAll([
        MapEntry("postImages[]", await MultipartFile.fromFile(file.path)),
      ]);
    }
    var resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/add-post',
          data: formData,
          options: Options(headers: Header.header));
    } catch (e) {
      throw e.toString();
    }
    print("sataus");
    print(resp.data["status"]);
  }

  //add offer
  static Future<void> postoffer({required PostOfferModel postOffer}) async {
    var dio = Dio();

    print("add post");
    var formData = FormData.fromMap({
      "traderId": postOffer.traderId,
      "offerTitle": postOffer.offerTitle,
      "offerContent": postOffer.offerContent,
      "fullPrice": postOffer.fullPrice,
      "offerPrice": postOffer.offerPrice,
      "validFrom": postOffer.validFrom,
      "validTo": postOffer.validTo,
      "offerImages[]": []
    });
    for (var file in postOffer.offerImages!) {
      formData.files.addAll([
        MapEntry("offerImages[]", await MultipartFile.fromFile(file.path)),
      ]);
    }
    var resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/add-offer',
          data: formData,
          options: Options(headers: Header.header));
    } catch (e) {
      throw e.toString();
    }
    print("sataus");
    print(resp.data["status"]);
  }

  //fetch trader by using sub category id

  //fetch feeds
  static Future<List<TraderFeedModel>> getFeeds() async {
    print('feeds');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/trader/posts'),
        headers: Header.header,
      );
      print(response.body);
      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return TraderFeedModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<TraderOfferListingModel>> getOfferList() async {
    print('feeds');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/trader/offers'),
        headers: Header.header,
      );
      print(response.body);
      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("offer sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return TraderOfferListingModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
