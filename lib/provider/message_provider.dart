import 'package:codecarrots_unotraders/model/message/bazaar_store_message_model.dart';
import 'package:codecarrots_unotraders/model/message/message_list_model.dart';
import 'package:codecarrots_unotraders/model/message/send_message_model.dart';
import 'package:codecarrots_unotraders/services/message_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  bool isLoading = false;
  bool oneToOneLoading = false;

  String oneToOneMessageError = "";
  bool sendMsgLoading = false;
  String errorMessage = "";
  List<MessageListModel> allMessageList = [];
  List<MessageListModel> oneToOneChat = [];

  clear() {
    oneToOneChat = [];
    oneToOneLoading = false;

    allMessageList = [];
    oneToOneMessageError = "";
    isLoading = false;
    errorMessage = "";
    sendMsgLoading = false;
  }

  clearLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> gerMessageList() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await MessageServices.getAllMessageList();
      allMessageList = [];
      allMessageList = data;
      // ignore: avoid_print
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> sendMessage(
      {required SendMessageModel send,
      required SendMessageModel getAllMessage}) async {
    sendMsgLoading = true;
    notifyListeners();
    try {
      bool res = await MessageServices.sendMessage(send: send);
      if (res == true) {
        //call chat api
        final data =
            await MessageServices.getOneToOneMessage(postBody: getAllMessage);
        if (data.isNotEmpty) {
          // data.sort((a, b) => b.id ?? 0.compareTo(a.id ?? 0));
          data.sort((a, b) => a.id!.compareTo(b.id!));
        }

        oneToOneChat = [];

        oneToOneChat = data;
        oneToOneChat.sort((a, b) => a.id!.compareTo(b.id!));
      }
      sendMsgLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);

      sendMsgLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getOneToOneMessage({required SendMessageModel apiBody}) async {
    oneToOneChat = [];
    oneToOneLoading = true;
    oneToOneMessageError = "";
    notifyListeners();
    try {
      List<MessageListModel> data =
          await MessageServices.getOneToOneMessage(postBody: apiBody);
      if (data.isNotEmpty) {
        data.sort((a, b) => a.id!.compareTo(b.id!));
      }
      oneToOneChat = data;
      oneToOneChat.sort((a, b) => a.id!.compareTo(b.id!));
    } catch (e) {
      oneToOneMessageError = e.toString();
    }
    oneToOneLoading = false;
    notifyListeners();
  }

  // Future<bool> storeBazaarMessage(
  //     {required BazaarStoreMessageModel storeBazaar}) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     bool res =
  //         await MessageServices.storeBazaarMessage(storeBazaar: storeBazaar);
  //     if (res == true) {
  //       isLoading = false;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       notifyListeners();
  //       isLoading = false;
  //       return false;
  //     }
  //   } catch (e) {
  //     AppConstant.toastMsg(
  //         msg: "Something Went Wrong", backgroundColor: AppColor.red);
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }
  Future<void> bazaarMessage(
      {required SendMessageModel apiBody,
      required BazaarStoreMessageModel storeBazaar}) async {
    oneToOneChat = [];
    oneToOneLoading = true;
    oneToOneMessageError = "";
    notifyListeners();
    try {
      await MessageServices.storeBazaarMessage(storeBazaar: storeBazaar);
      List<MessageListModel> data =
          await MessageServices.getOneToOneMessage(postBody: apiBody);
      if (data.isNotEmpty) {
        data.sort((a, b) => a.id!.compareTo(b.id!));
      }
      oneToOneChat = data;
      oneToOneChat.sort((a, b) => a.id!.compareTo(b.id!));
    } catch (e) {
      oneToOneMessageError = e.toString();
    }
    oneToOneLoading = false;
    notifyListeners();
  }
}
