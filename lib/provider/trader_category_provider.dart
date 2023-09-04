

import 'package:codecarrots_unotraders/model/provider_profile_model.dart';

import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:flutter/material.dart';

class TraderCategoryProvider with ChangeNotifier {
  bool traderFetching = false;
  String traderFetchError = "";
  List<ProviderProfileModel> traderList = [];
  // bool isLoading = false;
  // String errorMessage = "";
  // List<CategoryAndSubListModel> categoryList = [];
  // List<Subcategories> subCategoryList = [];

  // List<TraderServices> traderServicesList = [];
  // bool showCategoryDropDown = false;
  // bool showSubCategoryDropDown = false;
  // bool showServiceCategoryDropDown = false;
  // //List<String> selectedCategoryOptions = [];
  // Map<int, String> selectedSubCategoryOptions = {};
  // Map<int, String> serviceOptions = {};
  // Map<int, String> selectedCategoryOptions = {};

  // TraderEditProfileExistingdata? traderEditProfileExistingData;
  // bool editProfileLoading = false;
  // String editProfileError = "";

  //used in category screen

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

  // closeAllDropdown() {
  //   if (showCategoryDropDown == true ||
  //       showServiceCategoryDropDown == true ||
  //       showServiceCategoryDropDown == true) {
  //     showCategoryDropDown = false;
  //     showSubCategoryDropDown = false;
  //     showServiceCategoryDropDown = false;
  //     notifyListeners();
  //   }
  // }

  // clearAll() {
  //   subCategoryList = [];
  //   traderServicesList = [];
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   selectedCategoryOptions = {};
  //   selectedSubCategoryOptions = {};
  //   serviceOptions = {};
  //   notifyListeners();
  // }

  // showDropDown({
  //   required bool category,
  //   required bool subCategory,
  //   required bool serviceCategory,
  // }) {
  //   showCategoryDropDown = category;
  //   showSubCategoryDropDown = subCategory;
  //   showServiceCategoryDropDown = serviceCategory;
  //   notifyListeners();
  // }

  // Future<void> addCategory(String value, int id) async {
  //   print(value);
  //   selectedCategoryOptions.putIfAbsent(id, () => value);
  //   print("selectedCategoryOptions.putIfAbsent(id, () => value)");
  //   print(selectedCategoryOptions.keys.toList().length);

  //   selectedSubCategoryOptions = {};
  //   traderServicesList = [];
  //   subCategoryList = [];
  //   serviceOptions = {};
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // addSubCategory(String value, int id) {
  //   print("inner>>>>>>>>>>>>>>>>>>>>>>>>>");
  //   print(id);
  //   print(value);
  //   serviceOptions = {};
  //   traderServicesList = [];
  //   selectedSubCategoryOptions.putIfAbsent(id, () => value);
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // addServiceCategory(String value, int id) {
  //   serviceOptions.putIfAbsent(id, () => value);
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // removeCategory(int value) {
  //   selectedSubCategoryOptions = {};
  //   serviceOptions = {};
  //   traderServicesList = [];
  //   subCategoryList = [];
  //   print("remove before");
  //   print(selectedCategoryOptions.keys.toList().length);
  //   selectedCategoryOptions.remove(value);
  //   print("after before");
  //   print(selectedCategoryOptions.keys.toList().length);
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // removeSubCategory(int value) {
  //   serviceOptions = {};
  //   traderServicesList = [];
  //   selectedSubCategoryOptions.remove(value);
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // removeServiceCategory(int value) {
  //   serviceOptions.remove(value);
  //   showCategoryDropDown = false;
  //   showSubCategoryDropDown = false;
  //   showServiceCategoryDropDown = false;
  //   notifyListeners();
  // }

  // //called from trader profile screen
  // //due to change in requirement new api created for category and sub
  // //

  // Future<void> getAllTraderCategory() async {
  //   //if (categoryList.isNotEmpty) return;
  //   categoryList = [];
  //   notifyListeners();
  //   try {
  //     final data = await ApiServices.getTraderCatSub();
  //     categoryList = [];
  //     categoryList = data;
  //   } catch (e) {
  //     print(e.toString());
  //     AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
  //   }

  //   notifyListeners();
  // }

  // //sort sub category from category
  // getSubCategoryFromCategory(List<int> categoryId) {
  //   // selectedSubCategoryOptions.clear();
  //   //subCategoryList.clear();
  //   // traderServicesList.clear();
  //   if (categoryList.isNotEmpty && categoryId.isNotEmpty) {
  //     categoryId.forEach((optionItem) {
  //       categoryList.forEach((category) {
  //         if (optionItem.toString() == category.id.toString()) {
  //           // print("item id ${optionItem.value.toString()}");
  //           subCategoryList.addAll(category.subcategories ?? []);
  //         }
  //       });
  //     });
  //   }

  //   print("completed");

  //   notifyListeners();
  // }

  // Future<void> getServicesFromSubCategory(
  //     {required List<int> subCategoryId}) async {
  //   traderServicesList = [];
  //   notifyListeners();
  //   try {
  //     traderServicesList = await ApiServices.getServicesFromSubCategory(
  //         subCategoryId: subCategoryId);
  //     print(traderServicesList.length);
  //   } catch (e) {
  //     traderServicesList = [];
  //     print(e.toString());
  //     // AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
  //   }

  //   notifyListeners();
  // }

  // //used in category screen

  // Future<void> findTraderCategory({required String id}) async {
  //   print("findTraderCategory");
  //   traderList = [];
  //   traderFetching = true;
  //   traderFetchError = "";

  //   notifyListeners();

  //   try {
  //     traderList = await ProfileServices.findTraderByCategory(id: id);

  //     //  if (traderList.isNotEmpty) {
  //     //   traderList.forEach((element) {  if (element.id.toString() == id && element.type == userType) {
  //     //     } else {
  //     //       traderList.add(element);
  //     //     }});

  //     //  }
  //   } catch (e) {
  //     traderFetchError = e.toString();
  //     // print(e.toString());
  //     // AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
  //   }
  //   traderFetching = false;

  //   notifyListeners();
  // }

  // //get edit existing profile details,like categpry,completed work
  // Future<void> traderEditProfileCurrentData() async {
  //   editProfileLoading = true;
  //   editProfileError = "";
  //   traderEditProfileExistingData = null;
  //   notifyListeners();
  //   try {
  //     traderEditProfileExistingData =
  //         await ApiServices.getTraderEditProfileCurrentDetails();
  //     if (traderEditProfileExistingData == null) {
  //       print("null");
  //     } else {
  //       print("not null");
  //     }

  //     print("  traderEditProfileExistingData = data;");
  //   } catch (e) {
  //     print(e.toString());
  //     editProfileError = e.toString();
  //   }
  //   editProfileLoading = false;
  //   notifyListeners();
  // }

  // addCompletedWorkImages({required File fileImage}) {
  //   Providerworks value =
  //       Providerworks(fileImage: fileImage, isNetworkImage: false);
  //   traderEditProfileExistingData!.data!.providerworks!.add(value);
  //   notifyListeners();
  // }

  // removeCompletedWorkImages({required int id}) {
  //   traderEditProfileExistingData!.data!.providerworks!.removeAt(id);
  //   notifyListeners();
  // }

  // assignAllCategories() {
  //   if (traderEditProfileExistingData != null &&
  //       traderEditProfileExistingData!.data != null) {
  //     print("assign completed");
  //     assignCategory();
  //     assignSubCategory();
  //     assignServiceCategory();
  //   } else {
  //     print(" null");
  //   }
  // }

  // assignCategory() {
  //   //selectedCategoryOptions=
  //   if (traderEditProfileExistingData!.data!.providercategories != null &&
  //       traderEditProfileExistingData!.data!.providercategories!.isNotEmpty) {
  //     traderEditProfileExistingData!.data!.providercategories!
  //         .forEach((element) {
  //       selectedCategoryOptions.putIfAbsent(
  //           element.categoryId!, () => element.name!);
  //     });
  //   }
  // }

  // assignSubCategory() {
  //   //selectedCategoryOptions=
  //   if (traderEditProfileExistingData!.data!.providersubcategories != null &&
  //       traderEditProfileExistingData!
  //           .data!.providersubcategories!.isNotEmpty) {
  //     traderEditProfileExistingData!.data!.providersubcategories!
  //         .forEach((element) {
  //       selectedSubCategoryOptions.putIfAbsent(
  //           element.subCategoryId!, () => element.name!);
  //     });
  //   }
  // }

  // assignServiceCategory() {
  //   //selectedCategoryOptions=
  //   if (traderEditProfileExistingData!.data!.providerservices != null &&
  //       traderEditProfileExistingData!.data!.providerservices!.isNotEmpty) {
  //     traderEditProfileExistingData!.data!.providerservices!.forEach((element) {
  //       serviceOptions.putIfAbsent(element.serviceId!, () => element.name!);
  //     });
  //   }
  // }

  // Map<int, String> getAssignedCategories() {
  //   return selectedCategoryOptions;
  // }

  // Map<int, String> getAssignedSubCategories() {
  //   return selectedSubCategoryOptions;
  // }

  // Map<int, String> getAssignedServiceCategories() {
  //   return serviceOptions;
  // }
}
