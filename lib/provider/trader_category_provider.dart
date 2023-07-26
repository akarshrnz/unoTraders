import 'package:codecarrots_unotraders/model/home_category.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';

import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class TraderCategoryProvider with ChangeNotifier {
  bool traderFetching = false;
  String traderFetchError = "";
  List<ProviderProfileModel> traderList = [];
  bool isLoading = false;
  String errorMessage = "";
  List<CategoryAndSubListModel> categoryList = [];
  List<Subcategories> subCategoryList = [];

  Future<void> getAllTraderCategory() async {
    // if (categoryList.isNotEmpty) return;
    isLoading = true;
    errorMessage = "";
    categoryList = [];

    notifyListeners();
    try {
      categoryList = await ApiServices.getHomeCatSub();
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  //sort sub category from category
  getSubCategoryFromCategory(List<ValueItem> options) {
    subCategoryList.clear();
    if (categoryList.isNotEmpty && options.isNotEmpty) {
      options.forEach((optionItem) {
        categoryList.forEach((category) {
          if (optionItem.value.toString() == category.id.toString()) {
            subCategoryList.addAll(category.subcategories ?? []);
          }
        });
      });
      notifyListeners();
    }
  }

  Future<void> findTraderCategory({required String id}) async {
    print("findTraderCategory");
    traderList = [];
    traderFetching = true;
    traderFetchError = "";

    notifyListeners();

    try {
      traderList = await ProfileServices.findTraderByCategory(id: id);

      //  if (traderList.isNotEmpty) {
      //   traderList.forEach((element) {  if (element.id.toString() == id && element.type == userType) {
      //     } else {
      //       traderList.add(element);
      //     }});

      //  }
    } catch (e) {
      traderFetchError = e.toString();
      // print(e.toString());
      // AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
    traderFetching = false;

    notifyListeners();
  }
}
