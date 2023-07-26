// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/message/bazaar_store_message_model.dart';
import 'package:codecarrots_unotraders/model/message/message_list_model.dart';
import 'package:codecarrots_unotraders/model/message/send_message_model.dart';
import 'package:codecarrots_unotraders/model/notification%20model/notification_model.dart';

import 'package:codecarrots_unotraders/services/helper/url.dart';

import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessageServices {
  static Future<List<MessageListModel>> getAllMessageList() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }

    print("message getting........");
    print(Url.messageList);

    final body = {"user_id": id, "user_type": userType};

    print(body);

    try {
      var response = await http.post(Uri.parse(Url.messageList),
          headers: Header.header, body: jsonEncode(body));
      print(response.statusCode.toString());
      print("response");

      print(response.body);

      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"] ?? []) {
          tempList.add(v);
        }
        return MessageListModel.snapshot(tempList);
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  static Future<bool> sendMessage({required SendMessageModel send}) async {
    print("sending message ........");

    try {
      var response = await http.post(Uri.parse(Url.sendMessage),
          headers: Header.header, body: jsonEncode(send.toJson()));
      print(response.statusCode.toString());
      print("response");

      print(response.body);

      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  static Future<List<MessageListModel>> getOneToOneMessage(
      {required SendMessageModel postBody}) async {
    print("body");
    print(postBody.toJson());
    try {
      var response = await http.post(Uri.parse(Url.getOneToOneMessage),
          headers: Header.header, body: jsonEncode(postBody.toJson()));
      print(response.statusCode.toString());
      print("response");

      print(response.body);

      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"] ?? []) {
          tempList.add(v);
        }
        return MessageListModel.snapshot(tempList);
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }

  static Future<List<NotificationModel>> getNotification() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }
    String url = Url.notification + userType + "/$id";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: Header.header,
      );
      print(response.statusCode.toString());
      print("response");

      print(response.body);

      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        print(response.body);
        List tempList = [];
        for (var v in data["data"] ?? []) {
          tempList.add(v);
        }
        return NotificationModel.snapshot(tempList);
      } else {
        throw data["message"] ?? "Something Went Wrong";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> storeBazaarMessage(
      {required BazaarStoreMessageModel storeBazaar}) async {
    print("body");
    print(jsonEncode(storeBazaar.toJson()));
    try {
      var response = await http.post(Uri.parse(Url.storeBazaarMessage),
          headers: Header.header, body: jsonEncode(storeBazaar.toJson()));
      print(response.statusCode.toString());
      print("response");

      // Map<String, dynamic> data =
      //     jsonDecode(response.body) as Map<String, dynamic>;
      // print(data['success'].toString());
      // print("response message");

      if (response.statusCode == 200) {
        return true;
        // if (data['success'].toString() == "success") {
        //   print("successs");
        //   return true;
        // } else {
        //   return false;
        // }
      } else {
        throw "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw "Something Went Wrong";
    }
  }
}
