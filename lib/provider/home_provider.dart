import 'package:codecarrots_unotraders/model/Trader%20Search/trader_search.dart';
import 'package:codecarrots_unotraders/model/banner_model.dart';
import 'package:codecarrots_unotraders/model/home_category.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool hasNext = true;
  bool filterHasNext = true;
  bool isSorting = false;
  bool isFetching = false;
  bool homeLoading = false;
  String errorMessage = "";
  bool traderLoading = false;
  bool traderFilterLoading = false;
  String traderErrorMessage = "";
  String traderFilterErrorMessage = "";
  bool isHomeLoaded = false;
  List<BannerModel> bannerList = [];
  List<ProviderProfileModel> traderSearchList = [];
  List<ProviderProfileModel> traderSearchFilterList = [];
  // List<AllSubCategoryModel> allSubCategoriesList = [];
  // List<TradersCategoryModel> serviceList = [];

  // List<TradersCategoryModel> traderCategoryList = [];
  List<CategoryAndSubListModel> allCatList = [];
  List<CategoryAndSubListModel> salesList = [];
  List<CategoryAndSubListModel> serviceList = [];

  clearHome() {
    isHomeLoaded = false;
    errorMessage = "";
    homeLoading = false;
    homeLoading = true;
    salesList = [];
    bannerList = [];
    serviceList = [];
    errorMessage = "";
    allCatList = [];
    notifyListeners();
  }

  Future<void> getHome() async {
    if (isHomeLoaded) return;
    homeLoading = true;
    salesList = [];
    bannerList = [];
    serviceList = [];
    errorMessage = "";
    allCatList = [];
    notifyListeners();

    try {
      bannerList = await ApiServices.getBanner();
      print("banner compl");
      // traderCategoryList = await ApiServices.getTraderCategory();

      allCatList = await ApiServices.getHomeCatSub();
      print(allCatList.length);
      if (allCatList.isNotEmpty) {
        allCatList.forEach((element) {
          if (element.mainCategory.toString().toLowerCase() == "service") {
            serviceList.add(element);
          } else {
            salesList.add(element);
          }
        });
      }
      isHomeLoaded = true;

      // parentCategory(parentCategory: "Service");
    } catch (e) {
      print("############################################");
      print(e.toString());
      errorMessage = "Something Went Wrong";
    }
    homeLoading = false;
    notifyListeners();
  }

  //search trader
  clearTraderSearch() {
    traderFilterErrorMessage = "";
    traderSearchFilterList = [];
    hasNext = true;
    filterHasNext = true;
    isSorting = false;
    isFetching = false;
    traderSearchList = [];
    traderFilterLoading = false;
    notifyListeners();
  }

  Future<void> searchTrader({required TraderSearch traderSearchModel}) async {
    if (hasNext == false) return;
    if (isFetching == true) return;
    traderLoading = true;
    traderErrorMessage = '';
    notifyListeners();

    try {
      traderSearchModel.offset = traderSearchList.length;
      print(traderSearchModel.toJson());
      final res =
          await ApiServices.searchTrader(traderSearchModel: traderSearchModel);
      traderSearchList.addAll(res);

      print(traderSearchList.length.toString());
      if (res.length < 20) {
        hasNext = false;
      }
    } catch (e) {
      print("############################################");
      print(e.toString());
      traderErrorMessage = e.toString();
    }
    traderLoading = false;
    notifyListeners();
  }

  clearTraderSearchFilter() {
    traderFilterErrorMessage = "";
    isSorting = false;
    traderSearchFilterList = [];
    traderFilterLoading = false;
    traderLoading = false;
    traderErrorMessage = '';
    filterHasNext = true;
    isFetching = false;
    isSorting = false;
    notifyListeners();
  }

  Future<void> filterSearchResults(
      {required TraderSearch traderSearchModel}) async {
    if (filterHasNext == false) return;
    if (isFetching == true) return;
    traderFilterLoading = true;
    traderFilterErrorMessage = '';
    isSorting = true;
    notifyListeners();

    try {
      traderSearchModel.offset = traderSearchFilterList.length;
      print(traderSearchModel.toJson());
      final res = await ApiServices.filterTraderSearchResults(
          traderSearchModel: traderSearchModel);
      traderSearchFilterList.addAll(res);

      print(traderSearchList.length.toString());
      if (res.length < 20) {
        filterHasNext = false;
      }
    } catch (e) {
      print("############################################");
      print(e.toString());
      traderFilterErrorMessage = e.toString();
    }

    traderFilterLoading = false;
    notifyListeners();
  }
}
