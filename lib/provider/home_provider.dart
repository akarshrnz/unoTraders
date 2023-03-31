import 'package:codecarrots_unotraders/model/all_sub_category_model.dart';
import 'package:codecarrots_unotraders/model/banner_model.dart';
import 'package:codecarrots_unotraders/model/home_category.dart';
import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool homeLoading = false;
  String errorMessage = "";
  bool isHomeLoaded = false;
  List<BannerModel> bannerList = [];
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

      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& list ");
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
}
