import 'dart:io';

import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_search_model.dart';

import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/model/sell_at_bazaar.dart';
import 'package:codecarrots_unotraders/model/bazaar_categories.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BazaarProvider with ChangeNotifier {
  List<BazaarModel> _bazaarProductsList = [];
  bool _error = false;
  String _errorMessage = "";
  bool searchError = false;
  String searchErrorMessage = "";
  String _categoryErrorMessage = "";
  String get categoryErrorMessage => _categoryErrorMessage;
  String get errorMessage => _errorMessage;
  bool get error => _error;
  List<BazaarModel> get bazaarProductsList => _bazaarProductsList;
  List<BazaarModel> bazaarSearchList = [];
  List<BazaarCategories> bazaarCategoriesList = [];
  List<Subcategories> subCategoriesList = [];
  String? selectedcategory;
  String? selectedSubCategory;
  int? selectedcategoryId;
  int? selectedSubCategoryId;
  bool isLoading = false;
  List<WishListModel> wishList = [];

  void changeCategory({
    required String categoryName,
  }) {
    subCategoriesList = [];
    selectedSubCategory = null;
    selectedcategory = null;
    selectedcategory = categoryName;
    fetchCategoryId(categoryName: categoryName);
    for (var element in bazaarCategoriesList) {
      if (element.category == categoryName) {
        fetchSubcategory(subcategories: element.subcategories);
      }
    }
    notifyListeners();
  }

  fetchCategoryId({required categoryName}) {
    for (var element in bazaarCategoriesList) {
      if (element.category == categoryName) {
        selectedcategoryId = element.id;
      }
    }
  }

  void changeSubCategory({
    required String categoryName,
  }) {
    selectedSubCategory = categoryName;
    fetchSubCategoryId(categoryName: categoryName);
    notifyListeners();
  }

  clearCategories() {
    selectedcategory = null;
    selectedSubCategory = null;
    notifyListeners();
  }

  fetchSubCategoryId({required categoryName}) {
    for (var element in subCategoriesList) {
      if (element.category == categoryName) {
        // ignore: avoid_print
        print(element.id);
        selectedSubCategoryId = element.id;
      }
    }
  }

  Future<void> fetchBazaarProducts() async {
    _bazaarProductsList = [];
    try {
      var data = await ApiServices.getBazaarproducts();
      _bazaarProductsList = data;
      // ignore: avoid_print
      print(_bazaarProductsList.length.toString());
      _error = false;
    } catch (e) {
      _error = true;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<List<BazaarModel>> fetchBazaarProd() async {
    try {
      var data = await ApiServices.getBazaarproducts();
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchCategory() async {
    try {
      bazaarCategoriesList = await ApiServices.getBazaarCategories();
    } catch (e) {
      print(e.toString());
      _categoryErrorMessage = e.toString();
    }
    notifyListeners();
  }

  fetchSubcategory({required List<Subcategories>? subcategories}) {
    subCategoriesList = [];
    if (subcategories != null) {
      subCategoriesList = subcategories;
    } else {
      subCategoriesList = [];
    }
  }

  Subcategories fetchSingleSub({required String id}) {
    late Subcategories cat;
    for (var element in subCategoriesList) {
      if (element.id.toString() == id) {
        cat = element;
      }
    }

    return cat;
  }

  BazaarCategories fetchSingleCat({required String id}) {
    late BazaarCategories cat;
    for (var element in bazaarCategoriesList) {
      if (element.id.toString() == id) {
        cat = element;
      }
    }

    return cat;
  }

  //add bazaar
  Future<void> addBazaarProduct(
      {required String userType,
      required int userId,
      required String productTitle,
      required String price,
      required String description,
      required String location,
      required String locationLatitude,
      required String locationLongitude,
      required List<File> productImages}) async {
    SellAtBazaar sellAtBazaar = SellAtBazaar(
        userType: userType,
        userId: userId,
        category: selectedcategoryId,
        subCategory: selectedSubCategoryId,
        productTitle: productTitle,
        price: price,
        description: description,
        location: location,
        locationLatitude: locationLatitude,
        locationLongitude: locationLongitude,
        productImages: productImages);
    // ignore: avoid_print
    print(sellAtBazaar.userType);
    // ignore: avoid_print
    print(sellAtBazaar.userId);
    // ignore: avoid_print
    print(sellAtBazaar.category.toString());
    // ignore: avoid_print
    print(sellAtBazaar.subCategory);
    // ignore: avoid_print
    print(sellAtBazaar.productTitle);
    // ignore: avoid_print
    print(sellAtBazaar.description);
    // ignore: avoid_print
    print(sellAtBazaar.location);
    // ignore: avoid_print
    print(sellAtBazaar.locationLatitude);
    // ignore: avoid_print
    print(sellAtBazaar.locationLongitude);
    // ignore: avoid_print
    print(sellAtBazaar.productImages!.length);
    // ignore: avoid_print
    print(sellAtBazaar.toJson());

    try {
      await ApiServices.sellAtBazaar(
        sellAtBazaar: sellAtBazaar,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> searchBazaarProduct(
      {required String query,
      required double latitude,
      required double longitude,
      required int distance,
      int? sortBy}) async {
    BazaarSearchModel searchModel = BazaarSearchModel(
        product: query,
        category: selectedcategoryId,
        subcategory: selectedSubCategoryId,
        latitude: latitude,
        longitude: longitude,
        distance: distance,
        sortBy: sortBy ?? 1);

    // ignore: avoid_print
    print(searchModel.category);
    // ignore: avoid_print
    print(searchModel.subcategory);
    // ignore: avoid_print
    print(searchModel.distance);
    // ignore: avoid_print
    print(searchModel.latitude);
    // ignore: avoid_print
    print(searchModel.longitude);
    // ignore: avoid_print
    print(searchModel.product);
    // ignore: avoid_print
    isLoading = true;
    searchError = false;
    searchErrorMessage = "";
    notifyListeners();

    try {
      bazaarSearchList = await ApiServices.bazaarSearch(
        search: searchModel,
      );
    } catch (e) {
      searchError = true;
      searchErrorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  //wishlist
  Future<List<WishListModel>> fetchWishlist() async {
    wishList = [];

    try {
      wishList = await ApiServices.getWishlist();
      // ignore: avoid_print
      print("wishList");
      // ignore: avoid_print
      print(wishList.length.toString());

      return wishList;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //add wishlist
  Future<void> addWishlist({required AddWishListModel wishlist}) async {
    try {
      await ApiServices.addWishlist(wishlist: wishlist);
      // ignore: avoid_print
      print("wishList");
      // ignore: avoid_print
      print(wishList.length.toString());
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  removeFetchWishList({required AddWishListModel wishlist}) async {
    isLoading = true;
    notifyListeners();
    try {
      await ApiServices.removeWishlist(wishlist: wishlist);
      final data = await ApiServices.getWishlist();
      wishList = [];
      wishList = data;
      Constant.toastMsg(
          msg: "Product Removed from Wishlist",
          backgroundColor: AppColor.green);
      // ignore: avoid_print
      print("wishList");
      // ignore: avoid_print
      print(wishList.length.toString());
    } catch (e) {
      print(e.toString());
      Constant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  //remove wishlist
  Future<void> removeWishlist({required AddWishListModel wishlist}) async {
    try {
      await ApiServices.removeWishlist(wishlist: wishlist);
      // ignore: avoid_print
      print("wishList");
      // ignore: avoid_print
      print(wishList.length.toString());
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  void intialValue() {
    searchError = false;
    searchErrorMessage = "";
    bazaarCategoriesList = [];
    subCategoriesList = [];
    _bazaarProductsList = [];
    _error = false;
    _errorMessage = "";
    _categoryErrorMessage = "";
  }
}
