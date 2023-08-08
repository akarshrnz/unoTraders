import 'package:codecarrots_unotraders/model/customer_quote_action_model.dart';
import 'package:codecarrots_unotraders/model/trader_quote_request_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';

class CustomerJobActionProvider with ChangeNotifier {
  List<TraderQuoteReqModel> traderQuoteReqList = [];
  String errorMessage = "";
  bool isLoading = false;
  String moreDetailsErrorMessage = "";
  bool isMoreLoading = false;

  Future fetchTraderQuoteReq({required String jobId}) async {
    isMoreLoading = true;
    moreDetailsErrorMessage = "";
    traderQuoteReqList = [];
    notifyListeners();
    try {
      traderQuoteReqList = await JobServices.getTradersQuoteReq(jobId: jobId);
    } catch (e) {
      traderQuoteReqList = [];
      moreDetailsErrorMessage = e.toString();
    }
    isMoreLoading = false;
    notifyListeners();
  }

  clearAll() {
    isMoreLoading = true;
    moreDetailsErrorMessage = "";
    traderQuoteReqList = [];
    errorMessage = "";
    isLoading = false;
    notifyListeners();
  }

  // Future<void> customerQuoteReqAction(
  //     {required String jobQuoteID,
  //     required String status,
  //     required String traderId,
  //     required String jobId}) async {
  //   isMoreLoading = true;
  //   notifyListeners();
  //   CustomerQuoteActionModel action = CustomerQuoteActionModel(
  //       jobquoteId: jobQuoteID,
  //       status: status,
  //       userId: traderId,
  //       userType: "customer");
  //   try {
  //     await JobServices.addCustomerAction(action: action);
  //     // ignore: avoid_print

  //     final quoteList = await JobServices.getTradersQuoteReq(jobId: jobId);
  //     // ignore: avoid_print
  //     print("2 comp");
  //     traderQuoteReqList = [];
  //     traderQuoteReqList = quoteList;
  //   } catch (e) {
  //     print("error hapen");
  //     AppConstant.toastMsg(
  //         backgroundColor: AppColor.red, msg: "Something Went Wrong");
  //     print(e.toString());
  //   }
  //   isMoreLoading = false;
  //   notifyListeners();
  // }
}
