// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/add_diy_help.dart';
import 'package:codecarrots_unotraders/model/current_job_model.dart';
import 'package:codecarrots_unotraders/model/customer_quote_action_model.dart';
import 'package:codecarrots_unotraders/model/customer_seek_quote_model.dart';
import 'package:codecarrots_unotraders/model/diy_help_listing_model.dart';
import 'package:codecarrots_unotraders/model/diy_help_post_reply_model.dart';
import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
import 'package:codecarrots_unotraders/model/job_clarification_model.dart';
import 'package:codecarrots_unotraders/model/job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/job_search_model.dart';
import 'package:codecarrots_unotraders/model/post_job_model.dart';
import 'package:codecarrots_unotraders/model/post_job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/quote/get_quote_model.dart';
import 'package:codecarrots_unotraders/model/reply_job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_quote_request_model.dart';
import 'package:codecarrots_unotraders/model/trader_req_info_model.dart';
import 'package:codecarrots_unotraders/model/trader_request_more_details_model.dart';
import 'package:codecarrots_unotraders/model/update_job_model.dart';

import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/exception_handler.dart';
import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class JobServices {
  // get live job

  static Future<List<FetchJobModel>> fetchAllJob() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;

    String currentUserLatitude = sharedPrefs.getDouble("latitude").toString();
    String currentUserLongitude = sharedPrefs.getDouble("longitude").toString();

    print(">>>> all job>>>>>>>>>");
    print(currentUserLatitude);
    print(currentUserLongitude);
    Map<String, dynamic> postBody = {
      "trader_id": id,
      "location_latitude": currentUserLatitude,
      "location_longitude": currentUserLongitude
    };
    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/job/jobs'),
          headers: Header.header,
          body: jsonEncode(postBody));
      print("job fetched successfully");

      print(response.body);
      print(response.statusCode);
      Map body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return FetchJobModel.jobSnapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  static Future<List<FetchJobModel>> fetchAllJobQuoteRequests() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/job/traderjobsquoterequests/$id'),
        headers: Header.header,
      );
      print("job fetched successfully");

      print(response.body);
      print(response.statusCode);
      Map body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return FetchJobModel.jobSnapshot(tempList);
      } else {
        throw body["message"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  static Future<List<GetAcceptRejectModel>> getTraderJobStatus(
      {required String url, required String status}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    print('$url$id/$status');
    try {
      var response = await http.get(
        Uri.parse('$url$id/$status'),
        headers: Header.header,
      );
      print(response.body);
      Map body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return GetAcceptRejectModel.jobSnapshot(tempList);
      } else {
        return GetAcceptRejectModel.jobSnapshot([]);
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  // static Future<List<FetchJobModel>> getTraderOngoingCompletedJobStatus(
  //     {required String status}) async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse(
  //           'https://demo.unotraders.com/api/v1/job/traderjobsprogress/${ApiServicesUrl.id}/$status'),
  //       headers: Header.header,
  //     );
  //     print(response.body);
  //     Map body = jsonDecode(response.body);

  //     if (body["status"] == 200) {
  //       print("sucess");
  //       List tempList = [];
  //       for (var data in body["data"]) {
  //         tempList.add(data);
  //       }
  //       return FetchJobModel.jobSnapshot(tempList);
  //     } else {
  //       return FetchJobModel.jobSnapshot([]);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     throw Failure("Something Went Wrong");
  //   }
  // }

  static Future<List<FetchJobModel>> getCustomerJobStatus(
      {required String url, required String status}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    try {
      var response = await http.get(
        Uri.parse('$url$id/$status'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      print(body["data"]);

      if (body["status"] == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return FetchJobModel.jobSnapshot(tempList);
      } else {
        return FetchJobModel.jobSnapshot([]);
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  //get customer job accept reject list

  static Future<List<GetAcceptRejectModel>> getCustomerJobAcceptReject(
      {required String url, required String status}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    try {
      var response = await http.get(
        Uri.parse('$url$id/$status'),
        headers: Header.header,
      );
      print(response.body);
      Map body = jsonDecode(response.body);
      print(body["data"]);

      if (body["status"] == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return GetAcceptRejectModel.jobSnapshot(tempList);
      } else {
        return GetAcceptRejectModel.jobSnapshot([]);
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  static Future<List<FetchJobModel>> getJob(
      {required String endpoint, required String jobStatus}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    print('${Url.jobStatus}/$id/$endpoint');
    try {
      var response = await http.get(
        Uri.parse('${Url.jobStatus}/$id/$endpoint'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      print(response.body);

      if (body["status"] == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          if (jobStatus.isEmpty) {
            tempList.add(data);
          } else if (data['job_status'] == jobStatus && data['user_id'] == id) {
            tempList.add(data);
          }
        }
        return FetchJobModel.jobSnapshot(tempList);
      } else {
        return FetchJobModel.jobSnapshot([]);
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  //fetch job clarification req
  static Future<List<JobClarificationModel>>
      getJobClarificationRequest() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;

    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/job/jobclarificationlist/$id'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      print(response.body);

      if (body["status"] == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return JobClarificationModel.snapshot(tempList);
      } else {
        return JobClarificationModel.snapshot([]);
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  //trader fetch job

  //customer seek quote
  static Future<List<CustomerSeekQuoteModel>> getQuote(
      {required String jobId}) async {
    print('${Url.customerSeekQuote}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUserLatitude = prefs.getDouble("latitude").toString();
    String currentUserLongitude = prefs.getDouble("longitude").toString();

    Map<String, dynamic> postBody = {
      "job_id": jobId,
      "location_latitude": currentUserLatitude,
      "location_longitude": currentUserLongitude
    };
    print(postBody);
    print(Url.customerSeekQuote);

    try {
      var response = await http.post(Uri.parse('${Url.customerSeekQuote}'),
          headers: Header.header, body: jsonEncode(postBody));
      print(response.statusCode);
      Map body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return CustomerSeekQuoteModel.fromSnapshot(tempList);
      } else {
        throw body['message'] ?? "Something Went Wrong";
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
      throw Exception(e.toString());
    }
  }

  //post job
  static Future<String> postJob(
      {required PostJobModel postJob, required BuildContext context}) async {
    print("job services");
    var formData = FormData.fromMap({
      "customerId": postJob.customerId,
      "category": postJob.category,
      "subCategory": postJob.subCategory,
      "jobTitle": postJob.jobTitle,
      "jobDescription": postJob.jobDescription,
      "budget": postJob.budget,
      "timeForCompletion": postJob.timeForCompletion,
      "location": postJob.location,
      "locationLatitude": postJob.locationLatitude,
      "locationLongitude": postJob.locationLongitude,
      "materialsPurchased": postJob.materialPurchased,
      "jobImages[]": [],
      "jobStatus": postJob.jobStatus
    });
    for (var file in postJob.jobimages!) {
      formData.files.addAll([
        MapEntry("jobImages[]", await MultipartFile.fromFile(file.path)),
      ]);
    }
    print(formData.fields);
    var response;

    try {
      // print(formData.fields);
      print("1");

      response = await DioClient.dio.post(Url.postJob,
          data: formData,
          options: Options(
            sendTimeout: 20000,
            receiveTimeout: 20000,
            headers: Header.header,
          ));
      // print(response.data['status'].toString());
      // print(response.data['data']['id'].toString());
      print("2");
      if (response.data['status'].toString() == "200") {
        print("response after posting");
        print(response.data);
        return response.data['data']['id'].toString();
      } else {
        print("3");
        throw ExceptionHandler(
            statusCode: response.statusCode,
            message: response.data['message'] ?? "");

        // throw response.data['message'] ?? "Something Went Wrong";
      }
    } on SocketException catch (e) {
      throw Failure('No Internet connection');
    } on TimeoutException catch (e) {
      throw Failure("Request timed out");
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.response) {
        print('Error: ${e.response?.statusCode} ${e.response?.statusMessage}');
        print("dio");
        throw ExceptionHandler(
            statusCode: e.response?.statusCode ?? 22,
            message: "${e.response?.statusCode} ${e.response?.statusMessage}");
      } else if (e.type == DioErrorType.cancel) {
        throw Failure("Request Cancelled");
      } else {
        throw Failure("Something Went Wrong");
      }
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print(e.toString());

      throw Failure(e.toString());
    }
  }

//fetch current job details
  static Future<CurrentJobModel?> getCurrentJobDetails(
      {required String jobId}) async {
    print('${Url.customerSeekQuote}$jobId');
    try {
      var response = await http.get(
        Uri.parse('${Url.currentJobDetails}$jobId'),
        headers: Header.header,
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      // jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print("sucess");
        print(body);
        return CurrentJobModel.fromJson(body['data']);
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

//update job
  static Future<bool> updatePostedJob(
      {required UpdateJobModel upadatejob,
      required BuildContext context}) async {
    var formData = FormData.fromMap({
      "id": upadatejob.id,
      "category_id": upadatejob.categoryId,
      "sub_category_id": upadatejob.subCategoryId,
      "title": upadatejob.title,
      "description": upadatejob.description,
      "budget": upadatejob.budget,
      "job_completion": upadatejob.jobCompletion,
      "job_location": upadatejob.jobLocation,
      "material_purchased": upadatejob.materialPurchased,
      "loc_latitude": upadatejob.latitude,
      "job_images[]": [],
      "loc_longitude": upadatejob.longitude
    });
    // for (int i = 0; i < upadatejob.jobImages!.length; i++) {
    //   print(upadatejob.jobImages![i].path);
    //   formData.files.addAll([
    //     MapEntry("job_images[]",
    //         await MultipartFile.fromFile(upadatejob.jobImages![i].path))
    //   ]);
    // }
    for (var file in upadatejob.jobImages ?? []) {
      formData.files.addAll([
        MapEntry("job_images[]", await MultipartFile.fromFile(file.path)),
      ]);
    }

    try {
      var response;
      response = await DioClient.dio.post(Url.updatePostedJob,
          data: formData,
          options: Options(
            headers: Header.header,
            sendTimeout: 10000,
            receiveTimeout: 10000,
          ));
      print(response.statusCode);
      print(response.data);

      if (response.statusCode.toString() == "200") {
        print("success");
        return true;
      } else {
        throw ExceptionHandler(
            statusCode: response.statusCode,
            message: response.data['message'] ?? "");
      }
    } on SocketException catch (e) {
      throw Failure('No Internet connection');
    } on TimeoutException catch (e) {
      throw Failure("Request timed out");
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.response) {
        throw ExceptionHandler(
            statusCode: e.response?.statusCode ?? 22,
            message: "${e.response?.statusCode} ${e.response?.statusMessage}");
      } else if (e.type == DioErrorType.cancel) {
        throw Failure("Request Cancelled");
      } else {
        throw Failure("Something Went Wrong");
      }
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // customer job Action *
  static Future<List<TraderQuoteReqModel>> getTradersQuoteReq(
      {required String jobId}) async {
    print('list all trader req');
    print('${Url.tradersQuoteReq}$jobId');
    try {
      var response = await http.get(
        Uri.parse('${Url.tradersQuoteReq}$jobId'),
        headers: Header.header,
      );
      print(response.body);
      Map body = jsonDecode(response.body);
      print("2 body");
      print(body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return TraderQuoteReqModel.fromSnapshot(tempList);
      } else {
        return TraderQuoteReqModel.fromSnapshot([]);
      }
    } on SocketException {
      throw "No Internet connection";
    } on FormatException {
      throw "Bad response format ";
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  static Future<void> addCustomerAction(
      {required CustomerQuoteActionModel action}) async {
    print(action.toJson());
    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/job/updatejobquote'),
          headers: Header.header,
          body: jsonEncode(action.toJson()));
      Map body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        print("sucess");
        // List tempList = [];
        // // for (var data in body["data"]) {
        // //   tempList.add(data);
        // // }
      } else {
        throw ExceptionHandler(statusCode: response.statusCode);
      }
    } on SocketException {
      throw "No Internet connection";
    } on FormatException {
      throw "Bad response format ";
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  //job serach by location
  static Future<List<FetchJobModel>> jobSearch(
      {required JobSearchModel search}) async {
    // ignore: avoid_print
    print("inside job search");
    print(search.toJson());
    final body = jsonEncode(search.toJson());

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/job/jobssearch'),
          headers: Header.header,
          body: body);
      print("response");

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return FetchJobModel.jobSnapshot(tempList);
      } else {
        throw data["error"] ?? "No results found";
      }
    } on http.ClientException {
      throw Failure('Failed to establish connection');
    } on RedirectException {
      throw Failure('Failed to redirect');
    } on TimeoutException {
      throw Failure('Request timed out');
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("404 The requested resource could not be found");
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      print("error search");
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  static Future<void> customerUpdateJobStatus(
      {required String jobId, required String endPoints}) async {
    print('${Url.changeJobStatus}$jobId/$endPoints');
    try {
      var response = await http.get(
        Uri.parse('${Url.changeJobStatus}$jobId/$endPoints'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
      } else {
        throw ExceptionHandler(
            statusCode: response.statusCode, message: body['message'] ?? "");
      }
    } on SocketException {
      throw "No Internet connection";
    } on FormatException {
      throw "Bad response format ";
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }
  //delete job

  static Future<bool> deleteJob({
    required String jobId,
  }) async {
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/job/delete/$jobId'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw "No Internet connection";
    } on FormatException {
      throw "Bad response format ";
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  //request job quote

  static Future<bool> requestJobQuote(
      {required RequestJobQuoteModel request}) async {
    // ignore: avoid_print
    print("sending job quote...");
    print(request.toJson());

    final body = jsonEncode(request.toJson());
    print(body);

    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/job/traderquotejob'),
          headers: Header.header,
          body: body);
      print("response");
      print(response.body);

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        // ignore: avoid_print
        AppConstant.toastMsg(
            msg: data["message"] ?? "", backgroundColor: AppColor.green);
        print(response.body);
        // List tempList = [];
        // for (var v in data["data"]) {
        //   tempList.add(v);
        // }
        return true;
      } else {
        AppConstant.toastMsg(
            msg: data["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);

        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> requestMoreDetails(
      {required TraderReqMoreModel request}) async {
    // ignore: avoid_print
    print("sending job quote...");

    final body = jsonEncode(request.toJson());
    print(body);

    try {
      var response = await http.post(
          Uri.parse(
              'https://demo.unotraders.com/api/v1/job/addjobrequestdetails'),
          headers: Header.header,
          body: body);
      print("response");
      print(response.body);

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("sucess ..sended  more details");
        print(response.body);
        // ignore: avoid_print
        AppConstant.toastMsg(
            msg: data["message"] ?? "Success", backgroundColor: AppColor.green);
        print(response.body);
        return true;
        // List tempList = [];
        // for (var v in data["data"]) {
        //   tempList.add(v);
        // }
      } else {
        AppConstant.toastMsg(
            msg: data["message"] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);

        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  //trader job ifo fetch
  static Future<List<TraderRequestInfoModel>> fetchTraderjobinfo(
      {required String jobId, required String traderId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    // ignore: avoid_print
    print("inside job trader info request more details page fetch");
    print(
        "https://demo.unotraders.com/api/v1/job/jobquotedetails/$jobId/$traderId");

    try {
      var response = await http.get(
        Uri.parse(
            'https://demo.unotraders.com/api/v1/job/jobquotedetails/$jobId/$traderId'),
        headers: Header.header,
      );
      print("response");

      print(response.statusCode.toString());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      List tempList = [];

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response.body);
        List tempList = [];
        for (var v in data["data"]) {
          tempList.add(v);
        }
        return TraderRequestInfoModel.jobSnapshot(tempList);
      } else {
        return [];
      }
    } catch (e) {
      print("error fetch");
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> customerGetQuote(
      {required GetQuoteModel getQuote}) async {
    print(Url.customerGetQuote);
    print(jsonEncode(getQuote.toJson()));
    try {
      var response = await http.post(Uri.parse(Url.customerGetQuote),
          headers: Header.header, body: jsonEncode(getQuote.toJson()));
      Map body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        AppConstant.toastMsg(
            msg: body['message'], backgroundColor: AppColor.green);
      } else {
        AppConstant.toastMsg(
            msg: body['message'] ?? "Something Went Wrong",
            backgroundColor: AppColor.red);
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
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
  }

  //get job more details
  static Future<JobMoreDetailsModel> getJobMoreDetails(
      {required PostJobMoreDetailsModel jobDetailsModel}) async {
    print(Url.jobMoreDetails);
    print(jsonEncode(jobDetailsModel.toJson()));
    try {
      var response = await http.post(Uri.parse(Url.jobMoreDetails),
          headers: Header.header, body: jsonEncode(jobDetailsModel.toJson()));
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        return JobMoreDetailsModel.fromJson(body['data']);
      } else {
        throw "Something Went Wrong";
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
      print("service errpr");
      throw Failure(e.toString());
    }
  }

  static Future<List<Details>> postJobMoreDetailsReplyComment(
      {required ReplyMoreDetailsModel reply}) async {
    print(reply.toJson());
    print(reply.toJson());
    try {
      var response = await http.post(
          Uri.parse('https://demo.unotraders.com/api/v1/job/quotereply'),
          headers: Header.header,
          body: jsonEncode(reply.toJson()));
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
      List tempList = [];

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response.body);
        List tempList = [];
        for (var v in body["data"] ?? []) {
          tempList.add(v);
        }
        return Details.snapshot(tempList);
      } else {
        return [];
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
      print("service errpr");
      throw Failure(e.toString());
    }
  }

//diy help
  static Future<bool> diyHelp({
    required AddDiyHelp helpModel,
  }) async {
    // var formData = FormData.fromMap({
    // "title": helpModel.title,
    // "diy_help": helpModel.diyHelp,
    // "user_id": helpModel.userId,
    // "user_type": helpModel.userType,
    //   "diy_help_images": []
    // });
    // print("length of images ${helpModel.images!.length}");

    // for (var file in helpModel.images ?? []) {
    //   formData.files.addAll([
    //     MapEntry("diy_help_images", await MultipartFile.fromFile(file.path)),
    //   ]);
    // }
    List<MultipartFile> files = [];
    for (int i = 0; i < helpModel.images!.length; i++) {
      File imageFile = helpModel.images![i];
      String fileName = imageFile.path.split('/').last;
      files.add(
          await MultipartFile.fromFile(imageFile.path, filename: fileName));
    }

    FormData formData = FormData.fromMap({
      "title": helpModel.title,
      "diy_help": helpModel.diyHelp,
      "user_id": helpModel.userId,
      "user_type": helpModel.userType,
      'diy_help_images[]': files,
    });

    // Print FormData fields and contents
    print('FormData: values ');
    formData.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });

    // Print image file paths
    // Print image file paths
    print('Image files:');
    formData.files.forEach((file) {
      print(file.value.filename);
    });

    try {
      var response;
      response = await DioClient.dio.post(Url.diyHelp,
          data: formData,
          options: Options(
            headers: Header.header,
            sendTimeout: 10000,
            receiveTimeout: 10000,
          ));
      print(response.statusCode);
      print(response.data);

      if (response.statusCode.toString() == "200") {
        print("success");
        return true;
      } else {
        throw ExceptionHandler(
            statusCode: response.statusCode,
            message: response.data['message'] ?? "");
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on TimeoutException {
      throw Failure("Request timed out");
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Failure("Request timed out");
      } else if (e.type == DioErrorType.response) {
        throw ExceptionHandler(
            statusCode: e.response?.statusCode ?? 22,
            message: "${e.response?.statusCode} ${e.response?.statusMessage}");
      } else if (e.type == DioErrorType.cancel) {
        throw Failure("Request Cancelled");
      } else {
        throw Failure("Something Went Wrong");
      }
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print(e.toString());
      throw Failure(e.toString());
    }
  }

  static Future<List<DiyHelpListingModel>> getDiyHelp(
      {required int offset}) async {
    print("getDiyHelp");
    print('${Url.getDiyHelp}$offset');

    try {
      var response = await http.get(
        Uri.parse('${Url.getDiyHelp}$offset'),
        headers: Header.header,
      );
      print(response.statusCode);
      Map body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"] ?? []) {
          tempList.add(data);
        }
        return DiyHelpListingModel.fromSnapshot(tempList);
      } else {
        throw body['message'] ?? "Something Went Wrong";
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
      throw Exception(e.toString());
    }
  }

  static Future<Comments> addMainReply(
      {required DiyHelpPostReplyModel diyHelpPostReplyModel}) async {
    print(Url.addDiyMainComment);
    print(jsonEncode(diyHelpPostReplyModel.toJson()));
    try {
      var response = await http.post(Uri.parse(Url.addDiyMainComment),
          headers: Header.header,
          body: jsonEncode(diyHelpPostReplyModel.toJson()));
      print(response.statusCode);
      Map<String, dynamic> body = jsonDecode(response.body);

      print(body);

      if (response.statusCode == 200) {
        print("sucess");

        return Comments.fromJson(body['data']);
      } else {
        throw Failure(body['message'] ?? "Something went wrong ");
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
      throw Failure(e.toString());
    }
  }

  static Future<Replies> addSubReply(
      {required DiyHelpPostReplyModel diyHelpPostReplyModel}) async {
    print(Url.addDiyReplyComment);
    print(jsonEncode(diyHelpPostReplyModel.toJson()));
    try {
      var response = await http.post(Uri.parse(Url.addDiyReplyComment),
          headers: Header.header,
          body: jsonEncode(diyHelpPostReplyModel.toJson()));
      Map<String, dynamic> body = jsonDecode(response.body);
      print(response.statusCode);
      print(body);

      if (response.statusCode == 200) {
        Replies replies = Replies.fromJson(body['data']);

        print("sucess");
        return replies;
      } else {
        throw Failure(body['message'] ?? "Something went wrong ");
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
      throw Failure(e.toString());
    }
  }
}
