import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
import 'package:codecarrots_unotraders/model/job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/post_job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/reply_job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_req_info_model.dart';
import 'package:codecarrots_unotraders/model/trader_request_more_details_model.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer_quote_action_model.dart';

class TraderInfoProvider with ChangeNotifier {
  bool traderJobLoading = false;
  String traderJobErrorMessage = '';
  bool isLoading = false;
  bool traderMoreLoading = false;
  List<TraderRequestInfoModel> traderJobInfo = [];
  String errorMessage = '';
  String traderMoreErrorMessage = '';
  JobMoreDetailsModel? jobDetailsModel;
  List<Quotes> quoteList = [];
  List<TextEditingController> replyControllerList = [];
  bool hasNext = true;
  bool isFetching = false;
  List<GetAcceptRejectModel> traderJobList = [];

  clearGetJobMoreDetails() {
    traderMoreErrorMessage = '';
    traderMoreLoading = false;
    jobDetailsModel = null;
    quoteList = [];
    hasNext = true;
    isFetching = false;
    replyControllerList = [];
    notifyListeners();
  }

  Future<void> getJobMoreDetails({required String jobId}) async {
    if (hasNext == false) return;
    if (isFetching == true) return;
    traderMoreLoading = true;
    traderMoreErrorMessage = '';
    isFetching = true;
    notifyListeners();

    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    PostJobMoreDetailsModel postJobDetailsModel = PostJobMoreDetailsModel(
        jobId: int.parse(jobId),
        userId: int.parse(id),
        userType: userType,
        offset: quoteList.length);
    try {
      print("start");
      final data = await JobServices.getJobMoreDetails(
          jobDetailsModel: postJobDetailsModel);
      jobDetailsModel = data;
      print("fetch");
      if (jobDetailsModel == null) {
      } else {
        print("not null");

        quoteList.addAll(jobDetailsModel!.quotes ?? []);
        replyControllerList =
            List.generate(quoteList.length, (index) => TextEditingController());
        if (jobDetailsModel!.quotes!.length < 20) {
          hasNext = false;
        }
        print("comple");
      }
    } catch (e) {
      print("eroor catch");
      print(e.toString());
      traderMoreErrorMessage = e.toString();
    }
    traderMoreLoading = false;
    isFetching = false;
    notifyListeners();
  }

  Future<void> postJobMoreDetailsReplyComment(
      {required ReplyMoreDetailsModel reply, required int index}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    // PostJobMoreDetailsModel postJobDetailsModel = PostJobMoreDetailsModel(
    //     jobId: int.parse(jobId),
    //     userId: int.parse(id),
    //     userType: userType,
    //     offset: quoteList.length);
    try {
      final data =
          await JobServices.postJobMoreDetailsReplyComment(reply: reply);
      if (data.isNotEmpty) {
        quoteList[index].details = data;
        replyControllerList[index].text = "";
      }
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }

    notifyListeners();
  }

  viewAllReply(int index) {
    quoteList[index].isExpanded = !quoteList[index].isExpanded!;
    notifyListeners();
  }

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

  Future<bool> sendQuoteReq(
      {required RequestJobQuoteModel request,
      required callMessage,
      String? jobId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    // print(request.quotePrice.toString());
    // print(request.quoteReason.toString());
    // print(request.jobId.toString());
    // print(request.userId.toString());
    // print(request.userType.toString());
    // print(request.traderId.toString());
    // print(request.name.toString());

    try {
      bool res = await JobServices.requestJobQuote(request: request);

      // final data = await JobServices.fetchTraderjobinfo(
      //     jobId: request.jobId.toString(),
      //     traderId: userinfo.getString('id').toString());
      // traderJobInfo = [];
      // traderJobInfo = data;
      if (callMessage == true && res == true) {
        print(">>>>>>>>>>>>>>>>>>>>>........fetch");
        print(jobId.toString());

        PostJobMoreDetailsModel postJobDetailsModel = PostJobMoreDetailsModel(
            jobId: int.parse(jobId ?? "0"),
            userId: int.parse(id),
            userType: userType,
            offset: 0);
        print("start");
        final data = await JobServices.getJobMoreDetails(
            jobDetailsModel: postJobDetailsModel);
        jobDetailsModel = data;
        print("fetch");
        if (jobDetailsModel == null) {
        } else {
          print("not null");
          quoteList = [];

          quoteList.addAll(jobDetailsModel!.quotes ?? []);
          replyControllerList = [];
          replyControllerList = List.generate(
              quoteList.length, (index) => TextEditingController());
          if (jobDetailsModel!.quotes!.length < 20) {
            hasNext = false;
          }
          print("comple");
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendRequestMoreDetails(
      {required TraderReqMoreModel request,
      required callMessage,
      String? jobId}) async {
    final userinfo = await SharedPreferences.getInstance();

    try {
      bool res = await JobServices.requestMoreDetails(request: request);
      print(res);
      print(callMessage);
      print(quoteList.isEmpty);

      if (callMessage == true && res == true) {
        print(">>>>>>>>>>>>>>>>>>>>>........fetch");
        final sharedPrefs = await SharedPreferences.getInstance();
        String id = sharedPrefs.getString('id')!;
        String userType = sharedPrefs.getString('userType')!;
        PostJobMoreDetailsModel postJobDetailsModel = PostJobMoreDetailsModel(
            jobId: int.parse(jobId ?? "0"),
            userId: int.parse(id),
            userType: userType,
            offset: 0);
        print("start");
        final data = await JobServices.getJobMoreDetails(
            jobDetailsModel: postJobDetailsModel);
        jobDetailsModel = data;
        print("fetch");
        if (jobDetailsModel == null) {
        } else {
          print("not null");
          quoteList = [];

          quoteList.addAll(jobDetailsModel!.quotes ?? []);
          replyControllerList = [];
          replyControllerList = List.generate(
              quoteList.length, (index) => TextEditingController());
          if (jobDetailsModel!.quotes!.length < 20) {
            hasNext = false;
          }
          print("comple");
        }
      }

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

  Future<void> traderJobTypeByStatus(
      {required String url, required String status}) async {
    traderJobLoading = true;
    String traderJobErrorMessage = '';
    traderJobList = [];
    notifyListeners();
    try {
      traderJobList =
          await JobServices.getTraderJobStatus(url: url, status: status);
    } catch (e) {
      traderJobErrorMessage = e.toString();
    }
    traderJobLoading = false;

    notifyListeners();
  }

  Future<void> customerQuoteReqAction(
      {required String jobQuoteID,
      required String status,
      required String traderId,
      required String jobId,
      required int index}) async {
    CustomerQuoteActionModel action = CustomerQuoteActionModel(
        jobquoteId: jobQuoteID,
        status: status,
        userId: traderId,
        userType: "customer");
    try {
      await JobServices.addCustomerAction(action: action);
      // ignore: avoid_print
      if (jobDetailsModel != null) {
        print("not null");
        if (status.toLowerCase() == "accept") {
          print("Acceptl");
          jobDetailsModel!.quotes![index].status = "Accepted";
        } else if (status.toLowerCase() == "reject") {
          print("Rejected");
          jobDetailsModel!.quotes![index].status = "Rejected";
        }
      } else {}
    } catch (e) {
      print("error hapen");
      AppConstant.toastMsg(
          backgroundColor: AppColor.red, msg: "Something Went Wrong");
      print(e.toString());
    }

    notifyListeners();
  }
}
