// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:codecarrots_unotraders/model/current_job_model.dart';
import 'package:codecarrots_unotraders/model/customer_quote_action_model.dart';
import 'package:codecarrots_unotraders/model/customer_seek_quote_model.dart';
import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
import 'package:codecarrots_unotraders/model/job_search_model.dart';
import 'package:codecarrots_unotraders/model/post_job_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_quote_request_model.dart';
import 'package:codecarrots_unotraders/model/trader_req_info_model.dart';
import 'package:codecarrots_unotraders/model/update_job_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/services/helper/dio_client.dart';
import 'package:codecarrots_unotraders/services/helper/exception_handler.dart';
import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/header.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class JobServices {
  // get live job

  static Future<List<FetchJobModel>> fetchAllJob() async {
    try {
      var response = await http.get(
        Uri.parse('https://demo.unotraders.com/api/v1/jobs'),
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
        throw body["message"];
      }
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  static Future<List<GetAcceptRejectModel>> getTraderJobStatus(
      {required String url, required String status}) async {
    print('$url${ApiServicesUrl.id}/$status');
    try {
      var response = await http.get(
        Uri.parse('$url${ApiServicesUrl.id}/$status'),
        headers: Header.header,
      );
      print(response.body);
      Map body = jsonDecode(response.body);

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
    try {
      var response = await http.get(
        Uri.parse('$url${ApiServicesUrl.id}/$status'),
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
    print('url = $url${ApiServicesUrl.id}/$status');
    try {
      var response = await http.get(
        Uri.parse('$url${ApiServicesUrl.id}/$status'),
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
    print(ApiServicesUrl.id);
    print('${ApiServicesUrl.jobStatus}$endpoint');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.jobStatus}$endpoint'),
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
          } else if (data['job_status'] == jobStatus &&
              data['user_id'] == ApiServicesUrl.id) {
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

  //trader fetch job

  //customer seek quote
  static Future<List<CustomerSeekQuoteModel>> getQuote(
      {required String jobId}) async {
    print('${ApiServicesUrl.customerSeekQuote}$jobId');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.customerSeekQuote}$jobId'),
        headers: Header.header,
      );
      Map body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("sucess");
        List tempList = [];
        for (var data in body["data"]) {
          tempList.add(data);
        }
        return CustomerSeekQuoteModel.fromSnapshot(tempList);
      } else {
        throw CustomerSeekQuoteModel.fromSnapshot([]);
      }
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

    try {
      // print(formData.fields);
      var response;
      response = await DioClient.dio.post(
          "https://demo.unotraders.com/api/v1/jobs/post-job",
          data: formData,
          options: Options(headers: Header.header));
      // print(response.data['status'].toString());
      // print(response.data['data']['id'].toString());

      if (response.data['status'].toString() == "200") {
        return response.data['data']['id'].toString();
      } else {
        throw response.data['message'];
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      throw Failure("Something Went Wrong");
    }
  }

//fetch current job details
  static Future<CurrentJobModel?> getCurrentJobDetails(
      {required String jobId}) async {
    print('${ApiServicesUrl.customerSeekQuote}$jobId');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.currentJobDetails}$jobId'),
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
  static Future<void> updatePostedJob(
      {required UpdateJobModel upadatejob,
      required BuildContext context}) async {
    print("update services");
    print(upadatejob.jobImages);
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
      "loc_longitude": upadatejob.longitude
    });
    for (int i = 0; i < upadatejob.jobImages!.length; i++) {
      print(upadatejob.jobImages![i].path);
      formData.files.addAll([
        MapEntry("job_images[]",
            await MultipartFile.fromFile(upadatejob.jobImages![i].path))
      ]);
    }
    // for (var file in upadatejob.jobImages!) {
    //   formData.files.addAll([
    //     MapEntry("job_images", await MultipartFile.fromFile(file.path)),
    //   ]);
    // }
    // for (var file in upadatejob.jobImages!) {
    //   formData.files.addAll([
    //     MapEntry("job_images", await MultipartFile.fromFile(file.path)),
    //   ]);
    // }
    // formData.fields.forEach((element) {
    //   print(element.key);
    // });

    try {
      // print(formData.fields);
      var response;
      response = await DioClient.dio.post(
          "https://demo.unotraders.com/api/v1/job/updatecustomerjob",
          data: formData,
          options: Options(headers: Header.header));
      // print(response.data['status'].toString());
      // print(response.data['data']['id'].toString());
      print(response.data);
      print(response.statusCode);
      if (response.data['status'].toString() == "200") {
        print("success");
        print(response.data);
      } else {
        print(response.data);
        throw response.data['message'];
      }
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      print(e.toString());
      throw Failure("Something Went Wrong");
    }
  }

  // customer job Action
  static Future<List<TraderQuoteReqModel>> getTradersQuoteReq(
      {required String jobId}) async {
    print('list all trader req');
    print('${ApiServicesUrl.tradersQuoteReq}$jobId');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.tradersQuoteReq}$jobId'),
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

      if (data["status"] == 200) {
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
    } catch (e) {
      print("error search");
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<void> customerUpdateJobStatus(
      {required String jobId, required String endPoints}) async {
    print('${ApiServicesUrl.changeJobStatus}$jobId/$endPoints');
    try {
      var response = await http.get(
        Uri.parse('${ApiServicesUrl.changeJobStatus}$jobId/$endPoints'),
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

  //request job quote

  static Future<void> requestJobQuote(
      {required RequestJobQuoteModel request}) async {
    // ignore: avoid_print
    print("sending job quote...");

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

      if (data["status"] == 200) {
        print("sucess");
        // ignore: avoid_print
        Constant.toastMsg(
            msg: data["message"], backgroundColor: AppColor.green);
        print(response.body);
        // List tempList = [];
        // for (var v in data["data"]) {
        //   tempList.add(v);
        // }

      } else {
        throw data["error"] ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  //trader job ifo fetch
  static Future<List<TraderRequestInfoModel>> fetchTraderjobinfo(
      {required String jobId, required String traderId}) async {
    // ignore: avoid_print
    print("inside job trader info fetch");

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
}
