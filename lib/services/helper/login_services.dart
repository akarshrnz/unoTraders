import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:codecarrots_unotraders/model/login_model.dart';
import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';

class LoginServices {
  // static Future<void> postJob1(
  //     {required String email, required String pass}) async {

  //   try {
  //     // print(formData.fields);
  // var response;
  // response = await DioClient.dio.post(
  //     "https://demo.unotraders.com/api/v1/login",

  //  );
  //     // print(response.data['status'].toString());
  //     // print(response.data['data']['id'].toString());

  //     if (response.data['status'].toString() == "200") {
  //       return response.data['data'];
  //     } else {
  //       throw ;
  //     }
  // }
  // on SocketException {
  //   throw Failure('No Internet connection');
  // } on HttpException {
  //   throw Failure("Couldn't find the post");
  // } on FormatException {
  //   throw Failure("Bad response format");
  // } catch (e) {
  //     throw Failure("Something Went Wrong");
  //   }
  // }
  static Future<void> postJob(
      {required String email, required String pass}) async {
    LoginModel login = LoginModel(email: email, password: pass);
    // ignore: avoid_print
    print("inside login");
    final body = jsonEncode(login.toJson());
    final param = {"email": "sod@mailinator.com", "password": "Akarsh@12345"};

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/login'),
          body: jsonEncode(param),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
      print("completed");
      print(response.statusCode);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw e.toString();
    }
  }
}
