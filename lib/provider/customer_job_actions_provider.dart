import 'package:codecarrots_unotraders/model/customer_quote_action_model.dart';
import 'package:codecarrots_unotraders/model/trader_quote_request_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomerJobActionProvider with ChangeNotifier {
  List<TraderQuoteReqModel> traderQuoteReqList = [];
  String errorMessage = "";
  bool isLoading = false;

  Future fetchTraderQuoteReq({required String jobId}) async {
    isLoading = true;
    notifyListeners();
    try {
      traderQuoteReqList = await JobServices.getTradersQuoteReq(jobId: jobId);
    } catch (e) {
      traderQuoteReqList = [];
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  clearAll() {
    traderQuoteReqList = [];
    errorMessage = "";
    isLoading = false;
    notifyListeners();
  }

  Future<void> customerQuoteReqAction(
      {required String jobQuoteID,
      required String status,
      required String traderId,
      required String jobId}) async {
    isLoading = true;
    notifyListeners();
    CustomerQuoteActionModel action = CustomerQuoteActionModel(
        jobquoteId: jobQuoteID,
        status: status,
        userId: traderId,
        userType: "customer");
    try {
      await JobServices.addCustomerAction(action: action);
      // ignore: avoid_print

      final quoteList = await JobServices.getTradersQuoteReq(jobId: jobId);
      // ignore: avoid_print
      print("2 comp");
      traderQuoteReqList = [];
      traderQuoteReqList = quoteList;
    } catch (e) {
      print("error hapen");
      Constant.toastMsg(backgroundColor: AppColor.red, msg: e.toString());
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
