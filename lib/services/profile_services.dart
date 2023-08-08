import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/Feeds/feed_body.dart';
import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/add_review_comment_model.dart';
import 'package:codecarrots_unotraders/model/add_review_model.dart';
import 'package:codecarrots_unotraders/model/appointments/appointmenst_model.dart';
import 'package:codecarrots_unotraders/model/appointments/change_appoint_status_model.dart';
import 'package:codecarrots_unotraders/model/appointments/get_customer_appointment_model.dart';
import 'package:codecarrots_unotraders/model/appointments/reshedule_model.dart';
import 'package:codecarrots_unotraders/model/block_unblock_trader.dart';
import 'package:codecarrots_unotraders/model/blocked_trader_model.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment_reply.dart';
import 'package:codecarrots_unotraders/model/comment/comment_model.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/feed_reaction_model.dart';
import 'package:codecarrots_unotraders/model/follow/follow_list.dart';
import 'package:codecarrots_unotraders/model/follow/follow_model.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/profile%20insights/profile_insights_model.dart';
import 'package:codecarrots_unotraders/model/profile%20insights/profile_visitors_model.dart';
import 'package:codecarrots_unotraders/model/profile/url_profile_visit_model.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/model/receipt%20model/add_receipt_model.dart';
import 'package:codecarrots_unotraders/model/receipt%20model/receipt_model.dart';
import 'package:codecarrots_unotraders/model/receipt%20model/remove_receipt.dart';
import 'package:codecarrots_unotraders/model/report_feed-model.dart';
import 'package:codecarrots_unotraders/model/reset%20password/reset_password_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';

import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/model/view_customer_review_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';

import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/appointments/get_trader_appointmenys-modl.dart';

class ProfileServices {
  static Future<bool> resetPassword({required ResetPasswordModel reset}) async {
    print(reset.toJson());

    try {
      var response = await http.post(Uri.parse(Url.resetPassword),
          headers: Header.header, body: jsonEncode(reset.toJson()));
      Map body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body.toString());

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<CustomerProfileModel> getCustomerProfile(
      {required String id}) async {
    print('${Url.customerProfile}$id');
    try {
      var response = await http.get(
        Uri.parse('${Url.customerProfile}$id'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      if (body["status"] == 200) {
        return CustomerProfileModel.fromJson(body["data"]);
      } else {
        throw body['message'] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  //update profile
  static Future<void> updateProfile(
      {required UpdateProfileModel updateProfile,
      required BuildContext context}) async {
    CurrentUserProvider userProvider =
        Provider.of<CurrentUserProvider>(context, listen: false);
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

    print(updateProfile.toJson());
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
        SharedPreferences? sharedPreferance =
            await SharedPreferences.getInstance();
        sharedPreferance.setString("userName", response.data['data']['name']);
        sharedPreferance.setString("mobile", response.data['data']['mobile']);
        sharedPreferance.setString(
            "profilePic", response.data['data']['profile_pic']);
        userProvider.initializeSharedPreference();
        print("update sucess>>>>>>>");
        print(response.data);
        // print(response.body);
        // print(response.body['status'].toString());
        // print(response.body['message'].toString());
      } else {
        throw "Something went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something went Wrong";
    }
  }

  //trader profile
  static Future<TraderProfileModel> getTraderProfile(
      {required String id, String? customerId, String? customerType}) async {
    //here id is trader id
    //whaen trader visit his profile customerId and customerType is null
    print('${Url.traderProfile}');
    Map postBody = {
      "trader_id": int.parse(id),
      "user_id": customerId == null ? customerId : int.parse(customerId),
      "user_type": customerType
    };
    print(postBody);
    try {
      var response = await http.post(Uri.parse('${Url.traderProfile}'),
          headers: Header.header, body: jsonEncode(postBody));
      Map body = jsonDecode(response.body);
      if (body["status"] == 200) {
        print("profile sucess");

        return TraderProfileModel.fromJson(body["data"]);
      } else {
        throw body["message"] ?? "Something went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

//here username is trader username
//fetch user name from qr code scanner
  static Future<TraderProfileModel> getTraderProfileByUserName(
      {required String userName}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    print(' url ........${Url.traderProfile}$userName');
    UrlProfileVisitModel model = UrlProfileVisitModel(
        username: userName, userId: int.parse(id), userType: userType);
    print(model.toJson());

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/traderprofile'),
          headers: Header.header,
          body: jsonEncode(model.toJson()));
      Map body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body.toString());

        return TraderProfileModel.fromJson(body["data"]);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  //findTraderCategory
  static Future<List<ProviderProfileModel>> findTraderByCategory({
    required String id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUserLatitude = prefs.getDouble("latitude").toString();
    String currentUserLongitude = prefs.getDouble("longitude").toString();

    Map<String, dynamic> postBody = {
      "subcategory_id": id,
      "location_latitude": currentUserLatitude,
      "location_longitude": currentUserLongitude
    };
    print('https://demo.unotraders.com/api/v1/subcategory');
    print(postBody);
    Map body = {};
    try {
      // var response = await http.get(
      //   Uri.parse('https://demo.unotraders.com/api/v1/subcategory/$id'),
      //   headers: Header.header,
      // );
      var response = await http.post(Uri.parse(Url.findTraderByCategory),
          headers: Header.header, body: jsonEncode(postBody));
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
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  //add post
  static Future<void> addPost({
    required AddPostModel addPost,
    required String endPoints,
  }) async {
    //endpoints
    //add-post for adding post
    //update-post for update post
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
    print(formData.fields);
    print('https://demo.unotraders.com/api/v1/trader/$endPoints');
    var resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/$endPoints',
          data: formData,
          options: Options(headers: Header.header));
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
    print("sataus");
    print(resp.data["status"]);
    print(resp.data);
  }

  static Future<void> updatePost(
      {required AddPostModel addPost,
      required String endPoints,
      required int postId}) async {
    //endpoints
    //add-post for adding post
    //update-post for update post
    var dio = Dio();
    print(postId.toString());

    print("add post");
    var formData = FormData.fromMap({
      "id": postId,
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
    print(formData.fields);
    print('https://demo.unotraders.com/api/v1/trader/$endPoints');
    var resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/$endPoints',
          data: formData,
          options: Options(headers: Header.header));
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
    print("sataus");
    print(resp.data["status"]);
    print(resp.data);
  }

  //add offer
  static Future<bool> postoffer({required PostOfferModel postOffer}) async {
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
    Response resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/add-offer',
          data: formData,
          options: Options(headers: Header.header));
      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e.toString();
    }
    // print("sataus");
    // print(resp.data["status"]);
  }

  static Future<bool> updateoffer({required PostOfferModel postOffer}) async {
    var dio = Dio();

    print("add offer");
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
    Response resp;
    try {
      resp = await dio.post(
          'https://demo.unotraders.com/api/v1/trader/add-offer',
          data: formData,
          options: Options(headers: Header.header));
      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw "Something Went Wrong";
    }
    // print("sataus");
    // print(resp.data["status"]);
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

  static Future<List<TraderFeedModel>> getTraderFeeds(
      {required String urlUserType, String? traderId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String currentUserId = sharedPrefs.getString('id')!;
    String currentUserType = sharedPrefs.getString('userType')!;
    if (currentUserType != "customer") {
      currentUserType = "provider";
    }
    print(' trader feeds service');
    print('https://demo.unotraders.com/api/v1/$urlUserType/posts');

    FeedsBodyModel feedBody = FeedsBodyModel(
        traderId: traderId == null ? null : int.tryParse(traderId),
        userId: int.tryParse(currentUserId),
        userType: currentUserType);
    print("input");
    print(jsonEncode(feedBody.toJson()));
    Map body = {};
    try {
      // var response = await http.get(
      //   Uri.parse('https://demo.unotraders.com/api/v1/$userType/posts/$id'),
      //   headers: Header.header,
      // );
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/$urlUserType/posts'),
          headers: Header.header,
          body: jsonEncode(feedBody.toJson()));
      print("status code ${response.statusCode.toString()}");
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

  //report feed
  static Future<bool> reportFeed({required ReportFeedModel report}) async {
    print(' report feeds');
    print(Url.reportFeed);
    print(jsonEncode(report.toJson()));

    Map body = {};
    try {
      var response = await http.post(Uri.parse(Url.reportFeed),
          headers: Header.header, body: jsonEncode(report.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  //reaction
  static Future<bool> postCustomerReaction(
      {required FeedReactionModel reaction,
      required String reactionEndpoints}) async {
    Map body = {};
    print("reaction start");
    print("https://demo.unotraders.com/api/v1/trader/$reactionEndpoints");
    print(reaction.toJson());

    try {
      var response = await http.post(
          Uri.parse(
              "https://demo.unotraders.com/api/v1/trader/$reactionEndpoints"),
          headers: Header.header,
          body: jsonEncode(reaction.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print("reaction failed>>>>>>>");
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  //get reviews
  static Future<List<ViewCustomerReviewModel>> getTraderAllReviews(
      {required String traderId}) async {
    print(' trader review fetching....');
    print('https://demo.unotraders.com/api/v1/trader/reviewlist/$traderId');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/trader/reviewlist/$traderId'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return ViewCustomerReviewModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  //get bad review
  static Future<List<ViewCustomerReviewModel>> getTraderBadReviews(
      {required String traderId}) async {
    print(' trader review fetching....');
    print('https://demo.unotraders.com/api/v1/trader/reviewlist/$traderId');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/trader/badreviewlist/$traderId'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return ViewCustomerReviewModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  //add review by customer visiting trader profile or trader by own profile

  static Future<bool> addMainReview(
      {required AddReviewCommentModel addMainReview,
      required String url}) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = 'trader';
    }
    print("fetch start inside service");
    print(jsonEncode(addMainReview.toJson()));
    print(url);

    Map body = {};

    try {
      var response = await http.post(Uri.parse(url),
          headers: Header.header, body: jsonEncode(addMainReview.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  //get offer

  static Future<List<TraderOfferListingModel>> getTraderOffer(
      {required String urlUserType, String? traderId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String currentUserId = sharedPrefs.getString('id')!;
    String currentUserType = sharedPrefs.getString('userType')!;
    if (currentUserType != "customer") {
      currentUserType = "provider";
    }
    FeedsBodyModel feedBody = FeedsBodyModel(
        traderId: traderId == null ? null : int.tryParse(traderId),
        userId: int.tryParse(currentUserId),
        userType: currentUserType);
    print(' offer');
    print("https://demo.unotraders.com/api/v1/$urlUserType/offers");
    print("input");
    print(jsonEncode(feedBody.toJson()));
    Map body = {};
    try {
      // var response = await http.get(
      //   Uri.parse('https://demo.unotraders.com/api/v1/$userType/offers'),
      //   headers: Header.header,
      // );
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/$urlUserType/offers'),
          headers: Header.header,
          body: jsonEncode(feedBody.toJson()));
      print("status code ${response.statusCode.toString()}");
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
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

  static Future<List<CommentModel>> getComments({
    required String postId,
    required String endPoint,
  }) async {
    print('https://demo.unotraders.com/api/v1/$endPoint/$postId');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/$endPoint/$postId'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return CommentModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> addComment(
      {required AddCommentModel comment, required String url}) async {
    print(url);
    print(jsonEncode(comment.toJson()));
    Map body = {};
    try {
      var response = await http.post(Uri.parse(url),
          headers: Header.header, body: jsonEncode(comment.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> addCommentReply(
      {required AddCommentReplyModel reply,
      required String postCommentReplyUrl}) async {
    print(postCommentReplyUrl);

    print(jsonEncode(reply.toJson()));
    Map body = {};
    try {
      var response = await http.post(Uri.parse(postCommentReplyUrl),
          headers: Header.header, body: jsonEncode(reply.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<ReceiptModel>> getReceiptList() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String endPoint = sharedPrefs.getString('userType')!;
    if (endPoint.toLowerCase() == 'provider') {
      endPoint = "trader";
    }
    print("user id = $id");
    print(' receipt');
    Map body = {};
    print('https://demo.unotraders.com/api/v1/$endPoint/receipts/$id');
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/$endPoint/receipts/$id'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return ReceiptModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> removeReceipt({required String receiptId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String endPoint = sharedPrefs.getString('userType')!;
    if (endPoint.toLowerCase() == 'provider') {
      endPoint = "trader";
    }
    print("user id = $id");
    print(' receipt');
    RemoveReceipt removereceipt = RemoveReceipt(
        receiptId: int.parse(receiptId),
        userId: int.parse(id),
        userType: endPoint);

    print(removereceipt.toJson());
    Map body = {};
    print('https://demo.unotraders.com/api/v1/$endPoint/removereceipt');
    try {
      var response = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/$endPoint/removereceipt'),
          headers: Header.header,
          body: jsonEncode(removereceipt.toJson()));
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> addReceipt({required AddReceiptModel receipt}) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == 'provider') {
      userType = "trader";
    }
    print("user type = $userType");
    var formData = FormData.fromMap({
      "userId": receipt.userId,
      "title": receipt.title,
      "remarks": receipt.remarks,
      "receiptImage": await MultipartFile.fromFile(receipt.receiptImage!.path)
    });

    Map body = {};
    try {
      var response;
      response = await DioClient.dio.post(
          'https://demo.unotraders.com/api/v1/$userType/add-receipt',
          data: formData,
          options: Options(headers: Header.header));
      // var response = await http.post(
      //     Uri.parse('https://demo.unotraders.com/api/v1/$userType/add-receipt'),
      //     headers: Header.header,
      //     body: jsonEncode(receipt.toJson()));
      print("sataus");

      body = response.data;
      print(body);
      if (response.statusCode == 200) {
        print(body);
        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> traderFollowUnfollow({required int traderId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = 'trader';
    }

    TraderFollow follow = TraderFollow(
        traderId: traderId, userId: int.parse(id), userType: userType);

    Map body = {};

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/traderfollow'),
          headers: Header.header,
          body: jsonEncode(follow.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  static Future<bool> traderFavouriteUnfavourite(
      {required int traderId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = 'trader';
    }

    TraderFollow follow = TraderFollow(
        traderId: traderId, userId: int.parse(id), userType: userType);

    Map body = {};

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/traderfavourite'),
          headers: Header.header,
          body: jsonEncode(follow.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  static Future<bool> addAppointment(
      {required AddAppointmentModel appointments}) async {
    Map body = {};

    try {
      var response = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/customer/book-appointment'),
          headers: Header.header,
          body: jsonEncode(appointments.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body);
        AppConstant.toastMsg(
            msg: "Appointment booked", backgroundColor: AppColor.green);

        return true;
      } else {
        print(body);
        AppConstant.toastMsg(
            msg: body["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  static Future<bool> rescheduleCancelAppointment({
    required RescheduleModel appointments,
  }) async {
    Map body = {};

    try {
      var response = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/customer/change-appointment'),
          headers: Header.header,
          body: jsonEncode(appointments.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body);
        AppConstant.toastMsg(
            msg: "Appointment ${appointments.status}",
            backgroundColor: AppColor.green);

        return true;
      } else {
        print(body);
        AppConstant.toastMsg(
            msg: body["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  static Future<List<GetCustomerAppointmentsModel>>
      getCustomerAppointments() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }
    print("appointments");
    print('https://demo.unotraders.com/api/v1/$userType/appointments/$id');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/$userType/appointments/$id'),
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
        return GetCustomerAppointmentsModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<GetTraderAppointmentModel>> getTraderAppointments() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }

    print("appointments");
    print('https://demo.unotraders.com/api/v1/$userType/appointments/$id');
    Map body = {};
    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/$userType/appointments/$id'),
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
        return GetTraderAppointmentModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> changeAppointmentStatus({
    required ChangeAppointmentStatusModel changeStatus,
  }) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }

    Map body = {};
    print(changeStatus.toJson().toString());

    try {
      var response = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/$userType/change-appointment'),
          headers: Header.header,
          body: jsonEncode(changeStatus.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("appointment sucess");
        print(body);
        AppConstant.toastMsg(
            msg: "Appointment status changed successfully",
            backgroundColor: AppColor.green);

        return true;
      } else {
        print(body);
        AppConstant.toastMsg(
            msg: body["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  static Future<List<FollowListModel>> getFollowersList(
      {required String endPoints}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    print(' follow >>https://demo.unotraders.com/api/v1/$endPoints/$id');
    print('https://demo.unotraders.com/api/v1/$endPoints/$id');
    Map body = {};

    var response;
    try {
      response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/$endPoints/$id'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return FollowListModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('${response.statusCode} Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<FollowListModel>> getFavouriteList(
      {required String endPoints}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    print(' fav');
    print(' fav >>https://demo.unotraders.com/api/v1/$endPoints/$id');

    Map body = {};
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/$endPoints/$id'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return FollowListModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  //add review

  static Future<bool> addReview({
    required AddReviewModel add,
  }) async {
    print('https://demo.unotraders.com/api/v1/trader/add-review');
    print(add.toJson().toString());

    Map body = {};

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/trader/add-review'),
          headers: Header.header,
          body: jsonEncode(add.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body);
        AppConstant.toastMsg(
            msg: "Review added successfully", backgroundColor: AppColor.green);

        return true;
      } else {
        print(body);
        AppConstant.toastMsg(
            msg: body["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  static Future<ProfileInsightsModel> getProfileInsightts() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    Map body = {};

    var response;
    try {
      response = await http.get(
        Uri.parse('${Url.profileInsights}/$id'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ProfileInsightsModel.fromJson(body['data']);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('${response.statusCode} Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<ProfileVisitorsModel>> getProfileVisitors(
      {required int index, required String endPoints}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    Map body = {};

    var response;
    try {
      response = await http.get(
        Uri.parse('$endPoints/$id/$index'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return ProfileVisitorsModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('${response.statusCode} Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<List<BlockedTraderModel>> getBlockedTraders() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    Map body = {};

    var response;
    try {
      response = await http.get(
        Uri.parse('${Url.getBlockedTraders}$id'),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print(response.body);

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return BlockedTraderModel.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('${response.statusCode} Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> blockUnBlockTrader({
    required BlockUnBlockTraderModel block,
  }) async {
    Map body = {};

    try {
      var response = await http.post(Uri.parse(Url.blockUnBlockTraders),
          headers: Header.header, body: jsonEncode(block.toJson()));
      print(response.statusCode.toString());

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        print(body);
        AppConstant.toastMsg(
            msg: body["message"] ?? "Trader Blocked Successfully",
            backgroundColor: AppColor.green);

        return true;
      } else {
        print(body);
        throw "Something Went Wrong";
      }
    } catch (e) {
      throw "Something Went Wrong";
    }
  }
}
