import 'dart:convert';

import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

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
    required UpdateProfileModel updareProfile,
  }) async {
    print("update");
    var formData = FormData.fromMap({
      "name": updareProfile.name,
      "address": updareProfile.address,
      "location": updareProfile.location,
      "locationLatitute": updareProfile.locationLatitute,
      "locationLongitude": updareProfile.locationLongitude,
      "profileImage": "",
    });
    formData.files.addAll([
      MapEntry("profileImage",
          await MultipartFile.fromFile(updareProfile.profileImage!.path)),
    ]);
    print(formData.fields);

    var response;
    response = await DioClient.dio.put(ApiServicesUrl.updateCustomerProfile,
        data: formData, options: Options(headers: Header.header));

    if (response.data['status'].toString() == "200") {
      print(response.data['status'].toString());
      print(response.data['message'].toString());
    } else {
      throw Exception();
    }
    print(response.data['status'].toString());
  }

  //trader profile
  static Future<TraderProfileModel> getTrderProfile(
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

}
