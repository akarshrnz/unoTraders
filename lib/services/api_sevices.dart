// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/Trader%20Search/trader_search.dart';
import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/all_sub_category_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_detail_post_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_detal_get_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_search_model.dart';
import 'package:codecarrots_unotraders/model/home_category.dart';

import 'package:codecarrots_unotraders/model/profile/trader_edit_profile_existing.dart';
import 'package:codecarrots_unotraders/model/profile/trader_update_profile.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/trader_services.dart';

import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/services/helper/exception_handler.dart';

import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:codecarrots_unotraders/model/banner_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_categories.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/sell_at_bazaar.dart';
import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static Future<List<BannerModel>> getBanner() async {
    try {
      var response = await http.get(
        Uri.parse(Url.banners),
        headers: Header.header,
      );
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return BannerModel.bannerfromSnapshot(tempList);
      } else {
        throw Failure('Failed to load');
      }
    } on SocketException catch (_) {
      throw Failure("Please check your network connection");
    } catch (e) {
      throw Failure('Something went wrong');
    }
  }

//trader category
  static Future<List<TradersCategoryModel>> getTraderCategory() async {
    print("categories fetched ");
    print(Url.categories);
    try {
      var url = Uri.parse(Url.categories);
      var response = await http.get(
        url,
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print("category");
      print(response.body.toString());
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return TradersCategoryModel.categoryfromSnapshot(tempList);
      } else {
        throw throw data["message"] ?? "Something Went Wrong";
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("error");
      print(e.toString());
      throw Failure(e.toString());
    }
  }

//all sub category
  static Future<List<AllSubCategoryModel>> getAllSubCategory() async {
    print("all categories fetched ");

    try {
      var url = Uri.parse('https://demo.unotraders.com/api/v1/subcategorylist');
      var response = await http.get(
        url,
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print("category");
      print(response.body.toString());
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return AllSubCategoryModel.snapshot(tempList);
      } else {
        return AllSubCategoryModel.snapshot([]);
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("error");
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  //sub category
  static Future<List<TraderSubCategory>> getTraderSubCategory(
      {required int id}) async {
    Map data = {};

    try {
      var url = Uri.parse('${Url.subCategories}$id');
      var response = await http.get(
        url,
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print("sub category");
      print(response.body);
      data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return TraderSubCategory.subCategoryfromSnapshot(tempList);
      } else {
        return TraderSubCategory.subCategoryfromSnapshot([]);
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print(e.toString());
      throw Failure("Something went Wrong");
    }
  }

  //serach trader
  static Future<List<ProviderProfileModel>> searchTrader({
    required TraderSearch traderSearchModel,
  }) async {
    print(Url.searchTraders);
    print("start searching");
    Map body = {};
    try {
      // var response = await http.get(
      //   Uri.parse('https://demo.unotraders.com/api/v1/subcategory/$id'),
      //   headers: Header.header,
      // );
      var response = await http.post(Uri.parse(Url.searchTraders),
          headers: Header.header, body: jsonEncode(traderSearchModel.toJson()));
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

  //filter search results
  static Future<List<ProviderProfileModel>> filterTraderSearchResults({
    required TraderSearch traderSearchModel,
  }) async {
    print(Url.filterTradersSearchResults);
    print("start searching filtering");
    print(jsonEncode(traderSearchModel.toJson()));
    Map body = {};
    try {
      // var response = await http.get(
      //   Uri.parse('https://demo.unotraders.com/api/v1/subcategory/$id'),
      //   headers: Header.header,
      // );
      var response = await http.post(Uri.parse(Url.filterTradersSearchResults),
          headers: Header.header, body: jsonEncode(traderSearchModel.toJson()));
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

  static Future<List<TradersCategoryModel>> getTraderDetails() async {
    print("insdiede");
    var url = Uri.parse(Url.categories);
    var response = await http.get(
      url,
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);

    print(response.body);

    if (data["status"] == 200) {
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return TradersCategoryModel.categoryfromSnapshot(tempList);
    } else {
      throw Exception('Failed to load');
    }
  }
  //get trdser existing data for edit profile

  static Future<TraderEditProfileExistingdata>
      getTraderEditProfileCurrentDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    print("trader edit data");
    print("${Url.traderEditProfileExistingData}$id");
    var url = Uri.parse("${Url.traderEditProfileExistingData}$id");

    try {
      var response = await http.get(
        url,
        headers: Header.header,
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.statusCode);
      print(data);

      if (response.statusCode == 200) {
        if (data['data'] != null) {
          print("trader edit data Sucess");
          return TraderEditProfileExistingdata.fromJson(data);
        } else {
          throw Exception('Something Went Wrong');
        }
      } else {
        throw Exception('Something Went Wrong');
      }
    } catch (e) {
      throw Exception('Something Went Wrong');
    }
  }

  //update trader profile page one
  // static Future<TraderProfileModel?> updateTraderProfilePageOne(
  //     {required TraderUpdateProfile updateProfile}) async {
  //   try {
  //     print(jsonEncode(updateProfile.toJson()));
  //     print(Url.updateTraderProfilePageOne);
  //     Map<String, dynamic> body = {};
  //     var url = Uri.parse(Url.updateTraderProfilePageOne);
  //     var response = await http.post(url,
  //         headers: Header.header, body: jsonEncode(updateProfile.toJson()));
  //     print(response.statusCode);
  //     print(response.body);
  //     body = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       print("sucess");
  //       if (body["data"] != null) {
  //         return TraderProfileModel.fromJson(body["data"]);
  //       } else {
  //         return null;
  //       }
  //     } else {
  //       throw body["message"] ?? "Something Went Wrong";
  //     }
  //   } catch (e) {
  //     print("error message");
  //     print(e.toString());
  //     throw Exception(e.toString());
  //   }
  // }

  static Future<TraderProfileModel?> updateTraderProfilePageOne(
      {required TraderUpdateProfile updateProfile}) async {
    print("sell at bazaar");
    var formData = FormData.fromMap({
      'main_category': updateProfile.mainCategory,
      'type': updateProfile.type,
      'name': updateProfile.name,
      'country_code': updateProfile.countryCode,
      'service_location_radius': updateProfile.serviceLocationRadius,
      'available_time_from': updateProfile.availableTimeFrom,
      'available_time_to': updateProfile.availableTimeTo,
      'handyman': updateProfile.handyman,
      'web_url': updateProfile.webUrl,
      'address': updateProfile.address,
      'mobile': updateProfile.mobile,
      'email': updateProfile.email,
      ' is_available': updateProfile.isAvailable,
      'appointment': updateProfile.appointment,
      'reference': updateProfile.reference,
      'user_type': updateProfile.userType,
      'trader_id': updateProfile.traderId,
      'profile_image': updateProfile.profilePic == null
          ? null
          : await MultipartFile.fromFile(updateProfile.profilePic!.path)
    });

    try {
      print("1");
      var response = await DioClient.dio.post(Url.updateTraderProfilePageOne,
          data: formData, options: Options(headers: Header.header));
      print("2");

      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          return TraderProfileModel.fromJson(response.data["data"]);
        } else {
          return null;
        }
      } else {
        print("4");
        throw Failure(response.data['message'] ?? "Something went wrong");
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("5");

      throw Failure("Something Went Wrong");
    }
  }

  //update trader profile location page
  static Future<bool> updateTraderProfileLocationPage(
      {required TraderUpdateProfile updateProfile}) async {
    try {
      print(jsonEncode(updateProfile.toJson()));
      print(Url.updateTraderProfileLocationPage);
      Map<String, dynamic> body = {};
      var url = Uri.parse(Url.updateTraderProfileLocationPage);
      var response = await http.post(url,
          headers: Header.header, body: jsonEncode(updateProfile.toJson()));
      print(response.statusCode);
      print(response.body);
      body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print("error message");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<bool> updateTraderProfileServicePage(
      {required List<int> subCategoryId,
      required List<int> serviceId,
      required int traderId}) async {
    try {
      print(Url.updateTraderProfileServicePage);

      Map<String, dynamic> postBody = {
        "trader_id": traderId,
        "category": subCategoryId,
        "services": serviceId
      };
      print(jsonEncode(postBody));
      Map<String, dynamic> body = {};
      var url = Uri.parse(Url.updateTraderProfileServicePage);
      var response = await http.post(url,
          headers: Header.header, body: jsonEncode(postBody));
      print(response.statusCode);

      body = jsonDecode(response.body);
      print(body);

      if (response.statusCode == 200) {
        print("sucess");

        return true;
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print("error message");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<bool> updateTraderProfileCompletedPage(
      {required List<File> selectedImage,
      required List<int> removedImages,
      required int traderId}) async {
    List<MultipartFile> files = [];
    for (int i = 0; i < selectedImage.length; i++) {
      File imageFile = selectedImage[i];
      String fileName = imageFile.path.split('/').last;
      files.add(
          await MultipartFile.fromFile(imageFile.path, filename: fileName));
    }

    FormData formData = FormData.fromMap({
      "trader_id": traderId,
      "removeImg[]": removedImages,
      'completed_images[]': files,
    });
    print(Url.updateTraderProfileCompletedPage);
    // Print FormData fields and contents
    print('FormData: values ');
    formData.fields.forEach((field) {
      print('${field.key}:');
    });
    print(formData);

    // Print image file paths
    // Print image file paths
    print(formData);
    formData.files.forEach((file) {
      print(file.value.filename);
    });

    try {
      var response;
      response = await DioClient.dio.post(Url.updateTraderProfileCompletedPage,
          data: formData,
          options: Options(
            headers: Header.header,
            sendTimeout: 10000,
            receiveTimeout: 10000,
          ));
      print(response.statusCode);
      print(response.data);

      if (response.statusCode.toString() == "200") {
        print("success");
        return true;
      } else {
        throw ExceptionHandler(
            statusCode: response.statusCode,
            message: response.data['message'] ?? "");
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on TimeoutException {
      throw Failure("Request timed out");
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.response) {
        throw ExceptionHandler(
            statusCode: e.response?.statusCode ?? 22,
            message: "${e.response?.statusCode} ${e.response?.statusMessage}");
      } else if (e.type == DioErrorType.cancel) {
        throw Failure("Request Cancelled");
      } else {
        throw Failure("Something Went Wrong");
      }
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

//home cat and sub
  static Future<List<CategoryAndSubListModel>> getHomeCatSub() async {
    //'https://demo.unotraders.com/api/v1/categorylist'
    var url = Uri.parse(Url.homerCategoriesSubCategories);
    var response = await http.get(
      url,
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return CategoryAndSubListModel.snapshot(tempList);
    } else {
      throw Exception('Failed to load');
    }
  }

  //trader profile edit category and sub category
  static Future<List<CategoryAndSubListModel>> getTraderCatSub() async {
    var url = Uri.parse(Url.traderCategories);
    var response = await http.get(
      url,
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return CategoryAndSubListModel.snapshot(tempList);
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<List<TraderServices>> getServicesFromSubCategory(
      {required List<int> subCategoryId}) async {
    try {
      Map<String, List<int>> postBody = {"sub_categories": subCategoryId};
      print(jsonEncode(postBody));
      print(Url.getServicesFromSubCategory);
      Map<String, dynamic> body = {};
      var url = Uri.parse(Url.getServicesFromSubCategory);
      var response = await http.post(url,
          headers: Header.header, body: jsonEncode(postBody));
      print(response.statusCode);
      print(response.body);
      body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return TraderServices.snapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//remove
  static Future getProfile() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    print("inside future");

    var response;
    try {
      response = await http.get(
        Uri.parse("${Url.profile}$id"),
        headers: Header.header,
      );
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        print("progile customer");

        print(response.body);
        // List tempList = [];
        // for (var v in data["data"]) {
        //   tempList.add(v);
        // }
      } else {
        throw data["message"];
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      throw Failure("Something Went Wrong");
    }
  }

  static Future<List<BazaarModel>> getBazaarproducts() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    print("inside Bazaar");
    print('${Url.bazaarProduts}$id');
    var response = await http.get(
      Uri.parse('${Url.bazaarProduts}$id'),
      headers: Header.header,
    );
    print(response.statusCode.toString());
    print(response.body);

    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return BazaarModel.bazaarListSnap(tempList);
    } else {
      throw Failure('Something Went Wrong');
    }
  }

  static Future<List<BazaarCategories>> getBazaarCategories() async {
    print("inside Bazaar");
    print(Url.bazaarCategories);
    var response = await http.get(
      Uri.parse(Url.bazaarCategories),
      headers: Header.header,
    );
    print(response.body);
    Map data = jsonDecode(response.body);
    if (data["status"] == 200) {
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return BazaarCategories.bazaarCatListSnap(tempList);
    } else {
      throw Exception('Failed to load');
    }
  }

  //sell at bazaar
  static Future<void> sellAtBazaar({required SellAtBazaar sellAtBazaar}) async {
    print("sell at bazaar");
    var formData = FormData.fromMap({
      "userType": sellAtBazaar.userType,
      "userId": sellAtBazaar.userId,
      "category": sellAtBazaar.category,
      "subCategory": sellAtBazaar.subCategory,
      "productTitle": sellAtBazaar.productTitle,
      "price": sellAtBazaar.price,
      "description": sellAtBazaar.description,
      "location": sellAtBazaar.location,
      "locationLatitude": sellAtBazaar.locationLatitude,
      "locationLongitude": sellAtBazaar.locationLongitude,
      "productImages[]": []
    });
    for (var file in sellAtBazaar.productImages!) {
      formData.files.addAll([
        MapEntry("productImages[]", await MultipartFile.fromFile(file.path)),
      ]);
    }

    var response;
    try {
      print("1");
      response = await DioClient.dio.post(
          'https://demo.unotraders.com/api/v1/bazaar/sell-at-bazaar',
          data: formData,
          options: Options(headers: Header.header));
      print("2");

      if (response.data['status'].toString() == "200") {
        print("3");
      } else {
        print("4");
        throw Failure(response.data['message']);
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("5");
      print(response.data['message']);
      throw Failure("Something Went Wrong");
    }
  }

  //bazaar search
  static Future<List<BazaarModel>> bazaarSearch(
      {required BazaarSearchModel search}) async {
    print("inside search");
    print(search.toJson());
    final body = jsonEncode(search.toJson());

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/bazaar/bazaarsearch'),
          headers: Header.header,
          body: body);

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.body);

      if (data["status"] == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return BazaarModel.bazaarListSnap(tempList);
      } else {
        throw data["error"] ?? "No results found";
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("error search");
      print(e.toString());
      throw e.toString();
    }
  }

  //wishlist
//post wishlist

  //getWishlist
  static Future<List<WishListModel>> getWishlist() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    var response = await http.get(
      Uri.parse('${Url.wishList}$id'),
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);
    print(data);
    try {
      if (response.statusCode == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return WishListModel.snapshot(tempList);
      } else {
        return WishListModel.snapshot([]);
      }
    } on SocketException catch (_) {
      throw Failure("Please check your network connection");
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  //add wishlist
  static Future<void> addWishlist({required AddWishListModel wishlist}) async {
    print("inside wishlist");
    final body = jsonEncode(wishlist.toJson());

    try {
      var res = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/bazaar/shortlist-product'),
          headers: Header.header,
          body: body);
      if (res.statusCode == 200) {
        print("Product added");
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> removeWishlist(
      {required AddWishListModel wishlist}) async {
    print("remove wishlist");
    final body = jsonEncode(wishlist.toJson());
    print(body);

    try {
      var res = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/bazaar/shortlist-remove'),
          headers: Header.header,
          body: body);
      if (res.statusCode == 200) {
        print("Product removed sucess");
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<BazaarDetailGetModel> getBazaarDetails(
      {required BazaarDetailPostModel postBody}) async {
    print("inside details");
    print(postBody.toJson());
    final body = jsonEncode(postBody.toJson());

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/bazaar/details'),
          headers: Header.header,
          body: body);

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.body);

      if (response.statusCode == 200) {
        print(response.body);

        return BazaarDetailGetModel.fromJson(data['data']);
      } else {
        throw data["message"] ?? "No results found";
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print("error search");
      print(e.toString());
      throw e.toString();
    }
  }
}
