import 'dart:io';

import 'package:codecarrots_unotraders/model/home_category.dart';
import 'package:codecarrots_unotraders/model/profile/trader_edit_profile_existing.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/trader_services.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile/trader_update_profile.dart';

class TraderUpdateProfileProvider with ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";
  List<CategoryAndSubListModel> categoryList = [];
  List<Subcategories> subCategoryList = [];

  List<TraderServices> traderServicesList = [];
  bool showCategoryDropDown = false;
  bool showSubCategoryDropDown = false;
  bool showServiceCategoryDropDown = false;
  //List<String> selectedCategoryOptions = [];
  Map<int, String> selectedSubCategoryOptions = {};
  Map<int, String> serviceOptions = {};
  Map<int, String> selectedCategoryOptions = {};

  TraderEditProfileExistingdata? traderEditProfileExistingData;
  bool editProfileLoading = false;
  String editProfileError = "";

  Future<TraderProfileModel?> updateTraderProfilePageOne(
      {required TraderUpdateProfile edit}) async {
    try {
      final res =
          await ApiServices.updateTraderProfilePageOne(updateProfile: edit);
      if (res != null) {
        AppConstant.toastMsg(
            msg: "Trader Profile Updated Successfully",
            backgroundColor: AppColor.green);
        return res;
      } else {
        // AppConstant.toastMsg(
        //     msg: "Something went wrong", backgroundColor: AppColor.red);
        return null;
      }
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something went wrong", backgroundColor: AppColor.red);
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateTraderProfileLocationPage(
      {required TraderUpdateProfile edit}) async {
    try {
      bool res = await ApiServices.updateTraderProfileLocationPage(
          updateProfile: edit);
      if (res == true) {
        AppConstant.toastMsg(
            msg: "Trader Profile Updated Successfully",
            backgroundColor: AppColor.green);
        return true;
      } else {
        AppConstant.toastMsg(
            msg: "Something went wrong", backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something went wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  Future<bool> updateTraderProfileServicePage() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    print(id.toString());
    try {
      bool res = await ApiServices.updateTraderProfileServicePage(
          traderId: int.parse(id),
          serviceId: serviceOptions.keys.toList(),
          subCategoryId: selectedSubCategoryOptions.keys.toList());
      if (res == true) {
        AppConstant.toastMsg(
            msg: "Trader Profile Updated Successfully",
            backgroundColor: AppColor.green);
        return true;
      } else {
        AppConstant.toastMsg(
            msg: "Something went wrong", backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something went wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  Future<bool> updateTraderProfileCompletedPage(
      {required List<File> selectedImage,
      required List<int> removedImages}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    try {
      bool res = await ApiServices.updateTraderProfileCompletedPage(
          removedImages: removedImages,
          selectedImage: selectedImage,
          traderId: int.parse(id));
      if (res == true) {
        AppConstant.toastMsg(
            msg: "Trader Profile Updated Successfully",
            backgroundColor: AppColor.green);
        return true;
      } else {
        AppConstant.toastMsg(
            msg: "Something went wrong", backgroundColor: AppColor.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something went wrong", backgroundColor: AppColor.red);
      return false;
    }
  }

  //get trader details

  closeAllDropdown() {
    if (showCategoryDropDown == true ||
        showServiceCategoryDropDown == true ||
        showServiceCategoryDropDown == true) {
      showCategoryDropDown = false;
      showSubCategoryDropDown = false;
      showServiceCategoryDropDown = false;
      notifyListeners();
    }
  }

  clearAll() {
    subCategoryList = [];
    traderServicesList = [];
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    selectedCategoryOptions = {};
    selectedSubCategoryOptions = {};
    serviceOptions = {};
    notifyListeners();
  }

  showDropDown({
    required bool category,
    required bool subCategory,
    required bool serviceCategory,
  }) {
    showCategoryDropDown = category;
    showSubCategoryDropDown = subCategory;
    showServiceCategoryDropDown = serviceCategory;
    notifyListeners();
  }

  Future<void> addCategory(String value, int id) async {
    print(value);
    selectedCategoryOptions.putIfAbsent(id, () => value);
    print("selectedCategoryOptions.putIfAbsent(id, () => value)");
    print(selectedCategoryOptions.keys.toList().length);

    selectedSubCategoryOptions = {};
    traderServicesList = [];
    subCategoryList = [];
    serviceOptions = {};
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  addSubCategory(String value, int id) {
    print("inner>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(id);
    print(value);
    serviceOptions = {};
    traderServicesList = [];
    selectedSubCategoryOptions.putIfAbsent(id, () => value);
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  addServiceCategory(String value, int id) {
    serviceOptions.putIfAbsent(id, () => value);
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  removeCategory(int value) {
    selectedSubCategoryOptions = {};
    serviceOptions = {};
    traderServicesList = [];
    subCategoryList = [];
    print("remove before");
    print(selectedCategoryOptions.keys.toList().length);
    selectedCategoryOptions.remove(value);
    print("after before");
    print(selectedCategoryOptions.keys.toList().length);
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  removeSubCategory(int value) {
    serviceOptions = {};
    traderServicesList = [];
    selectedSubCategoryOptions.remove(value);
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  removeServiceCategory(int value) {
    serviceOptions.remove(value);
    showCategoryDropDown = false;
    showSubCategoryDropDown = false;
    showServiceCategoryDropDown = false;
    notifyListeners();
  }

  //called from trader profile screen
  //due to change in requirement new api created for category and sub
  //

  Future<void> getAllTraderCategory() async {
    //if (categoryList.isNotEmpty) return;
    categoryList = [];
    notifyListeners();
    try {
      final data = await ApiServices.getTraderCatSub();
      categoryList = [];
      categoryList = data;
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }

    notifyListeners();
  }

  //sort sub category from category
  getSubCategoryFromCategory(List<int> categoryId) {
    // selectedSubCategoryOptions.clear();
    //subCategoryList.clear();
    // traderServicesList.clear();
    if (categoryList.isNotEmpty && categoryId.isNotEmpty) {
      categoryId.forEach((optionItem) {
        categoryList.forEach((category) {
          if (optionItem.toString() == category.id.toString()) {
            // print("item id ${optionItem.value.toString()}");
            subCategoryList.addAll(category.subcategories ?? []);
          }
        });
      });
    }

    print("completed");

    notifyListeners();
  }

  Future<void> getServicesFromSubCategory(
      {required List<int> subCategoryId}) async {
    traderServicesList = [];
    notifyListeners();
    try {
      traderServicesList = await ApiServices.getServicesFromSubCategory(
          subCategoryId: subCategoryId);
      print(traderServicesList.length);
    } catch (e) {
      traderServicesList = [];
      print(e.toString());
      // AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }

    notifyListeners();
  }

  //get edit existing profile details,like categpry,completed work
  Future<void> traderEditProfileCurrentData() async {
    editProfileLoading = true;
    editProfileError = "";
    traderEditProfileExistingData = null;
    notifyListeners();
    try {
      traderEditProfileExistingData =
          await ApiServices.getTraderEditProfileCurrentDetails();
      if (traderEditProfileExistingData == null) {
        print("null");
      } else {
        print("not null");
      }

      print("  traderEditProfileExistingData = data;");
    } catch (e) {
      print(e.toString());
      editProfileError = e.toString();
    }
    editProfileLoading = false;
    notifyListeners();
  }

  Future<void> refreshEditPage() async {
    final data = await ApiServices.getTraderEditProfileCurrentDetails();
    if (traderEditProfileExistingData == null) {
      traderEditProfileExistingData = data;
      notifyListeners();
      print("null");
    } else {
      print("not null");
    }
  }

  addCompletedWorkImages({required File fileImage}) {
    print("file image is $fileImage");
    Providerworks value =
        Providerworks(fileImage: fileImage, isNetworkImage: false);
    traderEditProfileExistingData!.data!.providerworks!.add(value);
    notifyListeners();
  }

  removeCompletedWorkImages({required int id}) {
    traderEditProfileExistingData!.data!.providerworks!.removeAt(id);
    notifyListeners();
  }

  assignAllCategories() {
    if (traderEditProfileExistingData != null &&
        traderEditProfileExistingData!.data != null) {
      print("assign completed");
      assignCategory();
      assignSubCategory();
      assignServiceCategory();
    } else {
      print(" null");
    }
  }

  assignCategory() {
    //selectedCategoryOptions=
    if (traderEditProfileExistingData!.data!.providercategories != null &&
        traderEditProfileExistingData!.data!.providercategories!.isNotEmpty) {
      traderEditProfileExistingData!.data!.providercategories!
          .forEach((element) {
        selectedCategoryOptions.putIfAbsent(
            element.categoryId!, () => element.name!);
      });
    }
  }

  assignSubCategory() {
    //selectedCategoryOptions=
    if (traderEditProfileExistingData!.data!.providersubcategories != null &&
        traderEditProfileExistingData!
            .data!.providersubcategories!.isNotEmpty) {
      traderEditProfileExistingData!.data!.providersubcategories!
          .forEach((element) {
        selectedSubCategoryOptions.putIfAbsent(
            element.subCategoryId!, () => element.name!);
      });
    }
  }

  assignServiceCategory() {
    //selectedCategoryOptions=
    if (traderEditProfileExistingData!.data!.providerservices != null &&
        traderEditProfileExistingData!.data!.providerservices!.isNotEmpty) {
      traderEditProfileExistingData!.data!.providerservices!.forEach((element) {
        print("key values below");
                            print("key is ${element.serviceId} value is ${element.name}");
        serviceOptions.putIfAbsent(element.serviceId!, () => element.name!);
      });
    }
  }

  Map<int, String> getAssignedCategories() {
    return selectedCategoryOptions;
  }

  Map<int, String> getAssignedSubCategories() {
    return selectedSubCategoryOptions;
  }

  Map<int, String> getAssignedServiceCategories() {
    return serviceOptions;
  }
}
