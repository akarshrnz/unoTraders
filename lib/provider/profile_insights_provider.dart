import 'package:codecarrots_unotraders/model/block_unblock_trader.dart';
import 'package:codecarrots_unotraders/model/blocked_trader_model.dart';
import 'package:codecarrots_unotraders/model/profile%20insights/profile_visitors_model.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInsightsProvider with ChangeNotifier {
  bool isVisitorLoading = false;
  bool hasNext = true;
  bool isFetching = false;
  String visitorErrorMessage = "";
  List<ProfileVisitorsModel> ProfileVisitorsModelList = [];
  List<BlockedTraderModel> blockedTraderModelList = [];
  clear() {
    hasNext = true;
    isFetching = false;
    visitorErrorMessage = "";
    ProfileVisitorsModelList = [];
    blockedTraderModelList = [];
    isVisitorLoading = false;
    notifyListeners();
  }

  Future<void> getProfileVisitors({required String endPoints}) async {
    print("start first");
    if (hasNext == false) return;
    if (isFetching == true) return;
    if (ProfileVisitorsModelList.isEmpty) {
      isVisitorLoading = true;
    }
    isFetching = true;

    notifyListeners();
    try {
      print("fetch first");
      final data = await ProfileServices.getProfileVisitors(
          endPoints: endPoints, index: ProfileVisitorsModelList.length);
      ProfileVisitorsModelList.addAll(data);
      print("fetch compl");
      if (data.length < 20) {
        hasNext = false;
      }
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>length");
      print(ProfileVisitorsModelList.length);
    } catch (e) {
      print("error");
      print(e.toString());
      // AppConstant.toastMsg(backgroundColor: AppColor.red, msg: e.toString());
      // print(e.toString());
      visitorErrorMessage = e.toString();
    }
    isFetching = false;
    isVisitorLoading = false;
    notifyListeners();
  }

  Future<void> getBlockedTrader() async {
    isFetching = true;
    blockedTraderModelList = [];
    visitorErrorMessage = "";
    notifyListeners();
    try {
      print("fetch first");
      blockedTraderModelList = await ProfileServices.getBlockedTraders();
    } catch (e) {
      visitorErrorMessage = e.toString();
    }
    isFetching = false;
    notifyListeners();
  }

  //status 1 for block , 0 for unblock

  Future<void> blockUnBlockTrader(
      {required int status, required int traderId, int? index}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    BlockUnBlockTraderModel block = BlockUnBlockTraderModel(
        userId: int.parse(id),
        userType: "customer",
        status: status,
        traderId: traderId);
    isFetching = true;
    notifyListeners();
    try {
      print("fetch first");
      bool res = await ProfileServices.blockUnBlockTrader(block: block);
      if (res == true && index != null) {
        blockedTraderModelList.removeAt(index);
      }
    } catch (e) {
      AppConstant.toastMsg(
          backgroundColor: AppColor.red, msg: "Something Went Wrong");
    }
    isFetching = false;
    notifyListeners();
  }
}
