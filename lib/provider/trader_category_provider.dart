import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';

class TraderCategoryProvider with ChangeNotifier {
  bool traderFetching = false;
  String traderFetchError = "";
  List<ProviderProfileModel> traderList = [];
  bool isLoading = false;
  String errorMessage = "";
  List<TradersCategoryModel> traderCategoryList = [];
  List<TradersCategoryModel> serviceList = [];
  List<TradersCategoryModel> salesList = [];
  Future<void> getAllTraderCategory() async {
    if (traderCategoryList.isNotEmpty) return;
    isLoading = true;
    errorMessage = "";
    traderCategoryList = [];
    serviceList = [];
    salesList = [];
    notifyListeners();
    try {
      traderCategoryList = await ApiServices.getTraderCategory();
      serviceList = traderCategoryList;
      // if (traderCategoryList.isNotEmpty) {
      //   for (var element in traderCategoryList) {
      //     if (element.mainCategory == "Service") {
      //       serviceList.add(element);
      //     } else if (element.mainCategory == "Seller") {
      //       // salesList.add(element);
      //       serviceList.add(element);
      //     }
      //   }
      // }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> findTraderCategory({required String id}) async {
    traderList = [];
    traderFetching = true;
    traderFetchError = "";

    notifyListeners();
    try {
      traderList = await ProfileServices.getProviderProfile(id: id);
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
