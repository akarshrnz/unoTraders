import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_req_info_model.dart';
import 'package:codecarrots_unotraders/model/trader_request_more_details_model.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraderInfoProvider with ChangeNotifier {
  bool isLoading = false;
  bool traderMoreLoading = false;
  List<TraderRequestInfoModel> traderJobInfo = [];
  String errorMessage = '';
  String traderMoreErrorMessage = '';

  Future<void> getTraderJobInformation({required String jobId}) async {
    final userinfo = await SharedPreferences.getInstance();
    traderMoreErrorMessage = '';
    traderMoreLoading = true;
    traderJobInfo = [];
    notifyListeners();
    try {
      traderJobInfo = await JobServices.fetchTraderjobinfo(
          jobId: jobId, traderId: userinfo.getString('id').toString());
      print(traderJobInfo.length.toString());
    } catch (e) {
      traderJobInfo = [];
      print(e.toString());
      traderMoreErrorMessage = e.toString();
    }
    traderMoreLoading = false;

    notifyListeners();
  }

  Future<bool> sendQuoteReq({
    required RequestJobQuoteModel request,
  }) async {
    final userinfo = await SharedPreferences.getInstance();
    print(request.quotePrice.toString());
    print(request.quoteReason.toString());
    print(request.jobId.toString());
    print(request.userId.toString());
    print(request.userType.toString());
    print(request.traderId.toString());
    print(request.name.toString());

    try {
      await JobServices.requestJobQuote(request: request);

      final data = await JobServices.fetchTraderjobinfo(
          jobId: request.jobId.toString(),
          traderId: userinfo.getString('id').toString());
      traderJobInfo = [];
      traderJobInfo = data;
      notifyListeners();
      return true;
    } catch (e) {
      traderJobInfo = [];
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendRequestMoreDetails({
    required TraderReqMoreModel request,
  }) async {
    final userinfo = await SharedPreferences.getInstance();

    try {
      await JobServices.requestMoreDetails(request: request);

      // final data = await JobServices.fetchTraderjobinfo(
      //     jobId: request.jobId.toString(),
      //     traderId: userinfo.getString('id').toString());
      // traderJobInfo = [];
      // traderJobInfo = data;
      notifyListeners();
      return true;
    } catch (e) {
      traderJobInfo = [];
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
      notifyListeners();
      return false;
    }
  }
}
