// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_search_model.dart';

import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
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

class ApiServices {
  static Future<List<BannerModel>> getBanner() async {
    // ignore: avoid_print
    print("inside future");
    var response = await http.get(
      Uri.parse(ApiServicesUrl.banners),
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);
    if (data["status"] == 200) {
      // ignore: avoid_print
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return BannerModel.bannerfromSnapshot(tempList);
    } else {
      throw Exception('Failed to load');
    }
  }

//trader category
  static Future<List<TradersCategoryModel>> getTraderCategory() async {
    print("categories fetched ");
    print(ApiServicesUrl.categories);
    try {
      var url = Uri.parse(ApiServicesUrl.categories);
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
        throw throw data["message"];
      }
    }
    //  on SocketException {
    //   throw Failure('No Internet connection');
    // } on HttpException {
    //   throw Failure("Couldn't find the post");
    // } on FormatException {
    //   throw Failure("Bad response format");
    // }
    catch (e) {
      print("error");
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  //sub category
  static Future<List<TraderSubCategory>> getTraderSubCategory(
      {required int id}) async {
    Map data = {};

    try {
      var url = Uri.parse('${ApiServicesUrl.subCategories}$id');
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

  static Future<List<TradersCategoryModel>> getTraderDetails() async {
    // ignore: avoid_print
    print("insdiede");
    var url = Uri.parse(ApiServicesUrl.categories);
    var response = await http.get(
      url,
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);

    // ignore: avoid_print
    print(response.body);

    if (data["status"] == 200) {
      // ignore: avoid_print
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

//remove
  static Future getProfile() async {
    // ignore: avoid_print
    print("inside future");

    var response;
    try {
      response = await http.get(
        Uri.parse(ApiServicesUrl.profile),
        headers: Header.header,
      );
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        // ignore: avoid_print
        print("progile customer");
        // ignore: avoid_print
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
    // ignore: avoid_print
  }

  static Future<List<BazaarModel>> getBazaarproducts() async {
    // ignore: avoid_print
    print("inside Bazaar");
    var response = await http.get(
      Uri.parse('${ApiServicesUrl.bazaarProduts}${ApiServicesUrl.id}'),
      headers: Header.header,
    );
    print(response.statusCode.toString());
    print(response.body);

    Map data = jsonDecode(response.body);
    if (data["status"] == 200) {
      // ignore: avoid_print
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return BazaarModel.bazaarListSnap(tempList);
    } else {
      throw Exception('Failed to load');
    }

    // ignore: avoid_print
  }

  static Future<List<BazaarCategories>> getBazaarCategories() async {
    // ignore: avoid_print
    print("inside Bazaar");
    print(ApiServicesUrl.bazaarCategories);
    var response = await http.get(
      Uri.parse(ApiServicesUrl.bazaarCategories),
      headers: Header.header,
    );
    print(response.body);
    Map data = jsonDecode(response.body);
    if (data["status"] == 200) {
      // ignore: avoid_print
      print(response.body);
      List tempList = [];
      for (var v in data["data"]) {
        tempList.add(v);
      }
      return BazaarCategories.bazaarCatListSnap(tempList);
    } else {
      throw Exception('Failed to load');
    }

    // ignore: avoid_print
  }

  //sell at bazaar
  static Future<void> sellAtBazaar({required SellAtBazaar sellAtBazaar}) async {
    var dio = Dio();

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
    // ignore: avoid_print
    print("inside search");
    final body = jsonEncode(search.toJson());

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/bazaar/bazaarsearch'),
          headers: Header.header,
          body: body);
      print("response");

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      if (data["status"] == 200) {
        // ignore: avoid_print
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return BazaarModel.bazaarListSnap(tempList);
      } else {
        throw data["error"] ?? "No results found";
      }
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
    print(ApiServicesUrl.id);
    // ignore: avoid_print
    print("inside Bazaar");
    print('${ApiServicesUrl.wishList}${ApiServicesUrl.id}');
    var response = await http.get(
      Uri.parse('${ApiServicesUrl.wishList}${ApiServicesUrl.id}'),
      headers: Header.header,
    );
    Map data = jsonDecode(response.body);
    try {
      if (data["status"] == 200) {
        // ignore: avoid_print
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return WishListModel.snapshot(tempList);
      } else {
        throw data["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  //add wishlist
  static Future<void> addWishlist({required AddWishListModel wishlist}) async {
    // ignore: avoid_print
    print("inside wishlist");
    final body = jsonEncode(wishlist.toJson());

    try {
      await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/bazaar/shortlist-product'),
          headers: Header.header,
          body: body);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> removeWishlist(
      {required AddWishListModel wishlist}) async {
    // ignore: avoid_print
    print("remove wishlist");
    final body = jsonEncode(wishlist.toJson());
    print(body);

    try {
      var res = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/bazaar/shortlist-remove'),
          headers: Header.header,
          body: body);

      print("Product removed sucess");
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
