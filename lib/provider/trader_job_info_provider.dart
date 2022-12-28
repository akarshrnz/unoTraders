import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_req_info_model.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraderInfoProvider with ChangeNotifier {
  bool isLoading = false;
  List<TraderRequestInfoModel> traderJobInfo = [];
  String errorMessage = '';

  Future<void> getTraderJobInformation({required String jobId}) async {
    final userinfo = await SharedPreferences.getInstance();
    isLoading = true;
    traderJobInfo = [];
    notifyListeners();
    try {
      traderJobInfo = await JobServices.fetchTraderjobinfo(
          jobId: jobId, traderId: userinfo.getString('id').toString());
      print(traderJobInfo.length.toString());
    } catch (e) {
      traderJobInfo = [];
      print(e.toString());
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> sendQuoteReq({
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
    isLoading = true;
    notifyListeners();
    try {
      await JobServices.requestJobQuote(request: request);
      traderJobInfo = [];
      traderJobInfo = await JobServices.fetchTraderjobinfo(
          jobId: request.jobId.toString(),
          traderId: userinfo.getString('id').toString());
    } catch (e) {
      traderJobInfo = [];
      print(e.toString());
      Constant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }
}
