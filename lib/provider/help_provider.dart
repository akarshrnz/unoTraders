import 'package:codecarrots_unotraders/model/add_diy_help.dart';
import 'package:codecarrots_unotraders/model/diy_help_listing_model.dart';
import 'package:codecarrots_unotraders/model/diy_help_post_reply_model.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpProvider with ChangeNotifier {
  String errorMessage = "";
  bool isLoading = false;
  bool isUploadLoading = false;
  List<DiyHelpListingModel> diyHelpListingModel = [];
  List<TextEditingController> mainReplyControllerList = [];
  List<TextEditingController> replyControllerList = [];
  List<bool> expandable = [];
  bool hasNext = true;
  bool isFetching = false;

  initialValue() {
    errorMessage = "";
    isLoading = false;
    isUploadLoading = false;
    diyHelpListingModel = [];
    mainReplyControllerList = [];
    replyControllerList = [];
    expandable = [];
    hasNext = true;
    isFetching = false;
    notifyListeners();
  }

  Future<void> getDiyHelp() async {
    if (hasNext == false) return;
    if (isFetching == true) return;

    isLoading = true;
    errorMessage = "";
    isFetching = true;
    notifyListeners();
    try {
      final res =
          await JobServices.getDiyHelp(offset: diyHelpListingModel.length);
      diyHelpListingModel = res;
      expandable = List.generate(diyHelpListingModel.length, (index) => false);
      mainReplyControllerList = List.generate(
          diyHelpListingModel.length, (index) => TextEditingController());
      print("length of diy help ${diyHelpListingModel.length}");
      if (res.length < 20) {
        hasNext = false;
      }
      print("completed");
    } catch (e) {
      print("error");
      print(e.toString());
      errorMessage = e.toString();
    }
    isLoading = false;
    isFetching = false;
    notifyListeners();
  }

  expandHideMainButton(int index) {
    diyHelpListingModel[index].isExpand = !diyHelpListingModel[index].isExpand!;
    notifyListeners();
  }

  expandHideReplyMainButton(int mainIndex, int subIndex) {
    diyHelpListingModel[mainIndex].comments![subIndex].isReplyExpand =
        !diyHelpListingModel[mainIndex].comments![subIndex].isReplyExpand!;
    notifyListeners();
  }
  //add main reply  comment for questions

  Future<bool> addMainReply(
      {required DiyHelpPostReplyModel diyHelpPostReplyModel,
      required int mainIndex}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? name = sharedPrefs.getString('userName');
    String? profilePic = sharedPrefs.getString('profilePic');
    try {
      final res = await JobServices.addMainReply(
          diyHelpPostReplyModel: diyHelpPostReplyModel);
      res.name = name;
      res.profilePic = profilePic;
      res.replies = [];
      print(profilePic);
      print(name);

      diyHelpListingModel[mainIndex].comments!.add(res);
      notifyListeners();
      return true;

      // if (res == true) {
      //   print("completed");
      //   AppConstant.toastMsg(msg: "Success", backgroundColor: AppColor.green);
      //   return true;
      // } else {
      //   AppConstant.toastMsg(
      //       msg: "Something Went Wrong", backgroundColor: AppColor.red);
      //   return false;
      // }
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      print(e.toString());
      return false;
    }
  }
//sub reply comment

  Future<bool> addSubReply(
      {required DiyHelpPostReplyModel diyHelpPostReplyModel,
      required mainIndex,
      required int subIndex}) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? name = sharedPrefs.getString('userName');
      String? profilePic = sharedPrefs.getString('profilePic');
      final res = await JobServices.addSubReply(
          diyHelpPostReplyModel: diyHelpPostReplyModel);
      res.name = name;
      res.profilePic = profilePic;
      diyHelpListingModel[mainIndex].comments![subIndex].replies!.add(res);
      notifyListeners();
      return true;

      // if (res == true) {
      //   print("completed");
      //   AppConstant.toastMsg(msg: "Success", backgroundColor: AppColor.green);
      //   return true;
      // } else {
      //   AppConstant.toastMsg(
      //       msg: "Something Went Wrong", backgroundColor: AppColor.red);
      //   return false;
      // }
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      print(e.toString());
      return false;
    }
  }

  Future<bool> addHelp({required AddDiyHelp helpModel}) async {
    isUploadLoading = true;
    notifyListeners();
    try {
      bool res = await JobServices.diyHelp(
        helpModel: helpModel,
      );
      if (res == true) {
        AppConstant.toastMsg(msg: "Success", backgroundColor: AppColor.green);
        isUploadLoading = false;
        notifyListeners();
        return true;
      } else {
        AppConstant.toastMsg(
            msg: "Something went wrong", backgroundColor: AppColor.red);
        isUploadLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("error");
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
      isUploadLoading = false;
      notifyListeners();
      return false;
    }
  }
}
