// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:codecarrots_unotraders/model/current_job_model.dart';
import 'package:codecarrots_unotraders/model/customer_seek_quote_model.dart';
import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/job_clarification_model.dart';
import 'package:codecarrots_unotraders/model/job_search_model.dart';
import 'package:codecarrots_unotraders/model/post_job_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/model/update_job_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';

class JobProvider with ChangeNotifier {
  List<TradersCategoryModel> categoryList = [];
  List<TraderSubCategory> subCategoryList = [];
  String _categoryErrorMessage = "";
  String get categoryErrorMessage => _categoryErrorMessage;
  String _subCategoryErrorMessage = "";
  String get subCategoryErrorMessage => _subCategoryErrorMessage;
  String? selectedcategory;
  String? selectedSubCategory;
  int? selectedcategoryId;
  int? selectedSubCategoryId;
  List<FetchJobModel> getjobslist = [];
  List<FetchJobModel> allJobList = [];
  List<CustomerSeekQuoteModel> getQuoteList = [];
  bool isLoading = false;
  bool searchingLoading = false;
  bool isSeekingLoading = false;
  bool sendingReq = false;
  String jobId = '';
  List<FetchJobModel> jobSearchList = [];
  String searchErrorMessage = "";
  String errorMessage = "";
  bool searchError = false;
  String JobErrorMessage = '';
  CurrentJobModel? currentjob;
  bool isSeekingQuote = false;
  String seekQuoteError = "";
  List<JobClarificationModel> jobClarificationList = [];

  disposeAll() {
    _categoryErrorMessage = "";
    _subCategoryErrorMessage = "";
    isLoading = false;
    isSeekingLoading = false;
    sendingReq = false;
    searchErrorMessage = "";
    errorMessage = "";
    searchError = false;
    JobErrorMessage = '';
  }

  clearCategories() {
    selectedcategory = null;
    selectedSubCategory = null;
    selectedcategoryId = null;
    selectedSubCategoryId = null;
    subCategoryList = [];
    notifyListeners();
  }

  void clear() {
    // getjobslist = [];
    categoryList = [];
    subCategoryList = [];
    getQuoteList = [];
    _categoryErrorMessage = "";
    _subCategoryErrorMessage = '';
    selectedcategory = null;
    selectedSubCategory = null;
    selectedcategoryId = null;
    selectedSubCategoryId = null;
    jobId = '';
    isSeekingLoading = false;
  }

  void changeCategory({
    required String categoryName,
  }) async {
    // ignore: avoid_print
    print(categoryName);
    selectedSubCategory = null;
    subCategoryList = [];
    selectedcategory = categoryName;
    fetchCategoryId(categoryName: categoryName);
    notifyListeners();

    for (var element in categoryList) {
      if (element.category == categoryName) {
        await fetchSubcategory(id: element.id!);
        // ignore: avoid_print
        print("subCategoryList length");
        // ignore: avoid_print
        print(subCategoryList.length.toString());
      }
    }

    notifyListeners();
  }

  fetchCategoryId({required categoryName}) {
    for (var element in categoryList) {
      if (element.category == categoryName) {
        selectedcategoryId = element.id;
        print("%sek cat $selectedcategoryId");
      }
    }
  }

  void changeSubCategory({
    required String categoryName,
  }) {
    selectedSubCategory = categoryName;
    fetchSubCategoryId(categoryName: categoryName);
    notifyListeners();
  }

  fetchSubCategoryId({required categoryName}) {
    for (var element in subCategoryList) {
      if (element.category == categoryName) {
        // ignore: avoid_print
        print(element.id);
        selectedSubCategoryId = element.id;
      }
    }
  }

  Future fetchSubcategory({required int id}) async {
    try {
      subCategoryList = await ApiServices.getTraderSubCategory(id: id);
    } catch (e) {
      _subCategoryErrorMessage = e.toString();
    }
    notifyListeners();
  }

  Future fetchCategory() async {
    try {
      categoryList = await ApiServices.getTraderCategory();
      // ignore: avoid_print
      print(categoryList.length);
    } catch (e) {
      categoryList = [];
      _categoryErrorMessage = e.toString();
    }
    notifyListeners();
  }

  categoryFromDatabase(
      {required String catId, required String subCatId}) async {
    selectedSubCategoryId = int.parse(subCatId);
    selectedcategoryId = int.parse(catId);
    print("%category id $selectedcategoryId");
    print("%sub category id $selectedSubCategoryId");
    for (var element in categoryList) {
      print(element.id);
      if (element.id == int.parse(catId)) {
        selectedcategory = element.category;
        print("%sel category id $selectedcategory");
      }
    }
    await fetchSubcategory(id: int.parse(catId));

    for (var element in subCategoryList) {
      if (element.id == int.parse(subCatId)) {
        selectedSubCategory = element.category;
        print("%sel sub category id $selectedSubCategory");
      }
    }
    notifyListeners();
  }

  Future<CurrentJobModel?> fetchCurrentJob({required String jobId}) async {
    JobErrorMessage = '';
    isLoading = true;
    notifyListeners();
    print("started");

    try {
      currentjob = await JobServices.getCurrentJobDetails(jobId: jobId);
      // print(currentjob!.description);
      // CurrentJobModel currentJobModel = CurrentJobModel.fromJson(currentjob);
      print("job fetched");
      await fetchCategory();
      if (currentjob != null) {
        categoryFromDatabase(
            catId: currentjob!.categoryId!,
            subCatId: currentjob!.subCategoryId!);
      }
    } catch (e) {
      print(e.toString());
      JobErrorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
    return currentjob;
  }

  Future<void> postJob(
      {required int customerId,
      required String jobTitle,
      required String jobDescription,
      required String budget,
      required String timeForCompletion,
      required String location,
      required String locationLatitude,
      required String locationLongitude,
      required String materialPurchased,
      required List<File> jobimages,
      required String jobStatus,
      required BuildContext context}) async {
    PostJobModel postJob = PostJobModel(
        customerId: customerId,
        category: selectedcategoryId,
        subCategory: selectedSubCategoryId,
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        budget: budget,
        timeForCompletion: timeForCompletion,
        location: location,
        locationLatitude: locationLatitude,
        locationLongitude: locationLongitude,
        materialPurchased: materialPurchased,
        jobimages: jobimages,
        jobStatus: jobStatus);

    // ignore: avoid_print
    print(postJob.customerId);
    // ignore: avoid_print
    print(postJob.category);
    // ignore: avoid_print
    print(postJob.subCategory);

    // ignore: avoid_print
    print(postJob.jobTitle);

    // ignore: avoid_print
    print(postJob.jobDescription);

    // ignore: avoid_print
    print(postJob.budget);

    // ignore: avoid_print
    print(postJob.timeForCompletion);

    // ignore: avoid_print
    print(postJob.location);

    // ignore: avoid_print
    print(postJob.locationLatitude.toString());
    // ignore: avoid_print
    print(postJob.locationLongitude.toString());

    // ignore: avoid_print
    print(postJob.materialPurchased);

    // ignore: avoid_print
    print(postJob.jobimages);

    // ignore: avoid_print
    print(postJob.jobStatus);

    try {
      jobId = await JobServices.postJob(postJob: postJob, context: context);
      print("job id");
      print(jobId);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<bool> updatejob(
      {required String jobTitle,
      required String jobDescription,
      required String budget,
      required String timeForCompletion,
      required String location,
      required String locationLatitude,
      required String locationLongitude,
      required String materialPurchased,
      required List<File> jobimages,
      required String jobStatus,
      required BuildContext context}) async {
    UpdateJobModel updateJobModel = UpdateJobModel(
      id: currentjob!.id,
      budget: budget,
      categoryId: selectedcategoryId,
      subCategoryId: selectedSubCategoryId,
      description: jobDescription,
      jobCompletion: timeForCompletion,
      jobImages: jobimages,
      jobLocation: location,
      title: jobTitle,
      latitude: locationLatitude,
      longitude: locationLongitude,
      materialPurchased: materialPurchased,
    );
    print(updateJobModel.materialPurchased);
    print(updateJobModel.jobImages![0]);

    // PostJobModel postJob = PostJobModel(

    //     category: selectedSubCategoryId,
    //     subCategory: selectedcategoryId,
    //     jobTitle: jobTitle,
    //     jobDescription: jobDescription,
    //     budget: budget,
    //     timeForCompletion: timeForCompletion,
    //     location: location,
    //     locationLatitude: locationLatitude,
    //     locationLongitude: locationLongitude,
    //     materialPurchased: materialPurchased,
    //     jobimages: jobimages,
    //     jobStatus: jobStatus,
    //     );

    // // ignore: avoid_print
    // print(postJob.customerId);
    // // ignore: avoid_print
    // print(postJob.category);
    // // ignore: avoid_print
    // print(postJob.subCategory);

    // // ignore: avoid_print
    // print(postJob.jobTitle);

    // // ignore: avoid_print
    // print(postJob.jobDescription);

    // // ignore: avoid_print
    // print(postJob.budget);

    // // ignore: avoid_print
    // print(postJob.timeForCompletion);

    // // ignore: avoid_print
    // print(postJob.location);

    // // ignore: avoid_print
    // print(postJob.locationLatitude.toString());
    // // ignore: avoid_print
    // print(postJob.locationLongitude.toString());

    // // ignore: avoid_print
    // print(postJob.materialPurchased);

    // // ignore: avoid_print
    // print(postJob.jobimages);

    // // ignore: avoid_print
    // print(postJob.jobStatus);

    try {
      bool res = await JobServices.updatePostedJob(
          context: context, upadatejob: updateJobModel);
      // jobId = await JobServices.postJob(postJob: postJob, context: context);
      if (res == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> postAndSeekQuote(
      {required int customerId,
      required String jobTitle,
      required String jobDescription,
      required String budget,
      required String timeForCompletion,
      required String location,
      required String locationLatitude,
      required String locationLongitude,
      required String materialPurchased,
      required List<File> jobimages,
      required String jobStatus,
      required BuildContext context}) async {
    PostJobModel postJob = PostJobModel(
        customerId: customerId,
        category: selectedcategoryId,
        subCategory: selectedSubCategoryId,
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        budget: budget,
        timeForCompletion: timeForCompletion,
        location: location,
        locationLatitude: locationLatitude,
        locationLongitude: locationLongitude,
        materialPurchased: materialPurchased,
        jobimages: jobimages,
        jobStatus: jobStatus);

    // ignore: avoid_print
    print(postJob.customerId);
    // ignore: avoid_print
    print(postJob.category);
    // ignore: avoid_print
    print(postJob.subCategory);

    // ignore: avoid_print
    print(postJob.jobTitle);

    // ignore: avoid_print
    print(postJob.jobDescription);

    // ignore: avoid_print
    print(postJob.budget);

    // ignore: avoid_print
    print(postJob.timeForCompletion);

    // ignore: avoid_print
    print(postJob.location);

    // ignore: avoid_print
    print(postJob.locationLatitude.toString());
    // ignore: avoid_print
    print(postJob.locationLongitude.toString());

    // ignore: avoid_print
    print(postJob.materialPurchased);

    // ignore: avoid_print
    print(postJob.jobimages);

    // ignore: avoid_print
    // print(postJob.jobStatus);
    // jobId = '';
    // isSeekingLoading = true;
    // notifyListeners();

    try {
      jobId = await JobServices.postJob(postJob: postJob, context: context);
      print("job id success message");
      print(jobId);
      return jobId;
      // isSeekingLoading = false;
      // notifyListeners();
    } catch (e) {
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
      return "";
    }
    // isSeekingLoading = false;
    // notifyListeners();
  }

  Future<List<FetchJobModel>> fetchJob(
      {required String endPoint, required String jobStatus}) async {
    getjobslist = [];
    try {
      getjobslist =
          await JobServices.getJob(endpoint: endPoint, jobStatus: jobStatus);
      // // ignore: avoid_print
      // print("job status");
      // // ignore: avoid_print
      // print(getjobslist.length.toString());
      return getjobslist;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> fetchJobList(
      {required String endPoint, required String jobStatus}) async {
    isLoading = true;
    getjobslist = [];
    errorMessage = '';

    notifyListeners();
    try {
      getjobslist =
          await JobServices.getJob(endpoint: endPoint, jobStatus: jobStatus);
      print(getjobslist.length.toString());
      // // ignore: avoid_print
      // print("job status");
      // // ignore: avoid_print
      // print(getjobslist.length.toString());
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  //get job calrification request
  Future<void> fetchJobClarification() async {
    isLoading = true;
    jobClarificationList = [];
    errorMessage = '';

    notifyListeners();
    try {
      jobClarificationList = await JobServices.getJobClarificationRequest();
      print(jobClarificationList.length.toString());
    } catch (e) {
      jobClarificationList = [];
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  //fetch seek quote
  Future<void> fetchQuote({required String jobId}) async {
    isSeekingQuote = true;
    seekQuoteError = "";
    getQuoteList = [];
    notifyListeners();
    try {
      getQuoteList = await JobServices.getQuote(jobId: jobId);
      // ignore: avoid_print
      print("quote");
      // ignore: avoid_print
      print(getQuoteList.length.toString());
    } catch (e) {
      seekQuoteError = e.toString();
      print(e.toString());
      throw Exception(e.toString());
    }
    isSeekingQuote = false;
    notifyListeners();
  }

//serach job by location
  Future<void> searchJob({
    required String query,
    required double latitude,
    required double longitude,
    required int distance,
  }) async {
    JobSearchModel jobSearchModel = JobSearchModel(
      keyword: query,
      category: selectedcategoryId,
      subcategory: selectedSubCategoryId,
      latitude: latitude,
      longitude: longitude,
      distance: distance,
    );

    print(jobSearchModel.keyword);
    // ignore: avoid_print

    print(jobSearchModel.category);
    // ignore: avoid_print
    print(jobSearchModel.subcategory);
    // ignore: avoid_print
    print(jobSearchModel.distance);
    // ignore: avoid_print
    print(jobSearchModel.latitude);
    // ignore: avoid_print
    print(jobSearchModel.longitude);
    // ignore: avoid_print
    print(jobSearchModel.keyword);
    // ignore: avoid_print
    searchingLoading = true;
    searchError = false;
    searchErrorMessage = "";
    notifyListeners();

    try {
      jobSearchList = await JobServices.jobSearch(
        search: jobSearchModel,
      );
    } catch (e) {
      searchError = true;
      searchErrorMessage = e.toString();
    }
    searchingLoading = false;
    notifyListeners();
  }

  //fetch All job trader from trader portal

  Future<void> fetchAllJob() async {
    isLoading = true;
    allJobList = [];
    errorMessage = '';
    notifyListeners();
    try {
      allJobList = await JobServices.fetchAllJob();
      print(allJobList.length);
    } catch (e) {
      print(e.toString());
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllJobQuoteRequests() async {
    isLoading = true;
    allJobList = [];
    errorMessage = '';
    notifyListeners();
    try {
      allJobList = await JobServices.fetchAllJobQuoteRequests();
      print(allJobList.length);
    } catch (e) {
      print(e.toString());
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateJobStatus(
      {required String jobId,
      required String endPoints,
      required String status,
      required String jobEndPoint,
      required String jobStatus}) async {
    isLoading = true;
    notifyListeners();
    try {
      await JobServices.customerUpdateJobStatus(
          endPoints: endPoints, jobId: jobId);

      final data =
          await JobServices.getJob(endpoint: jobEndPoint, jobStatus: jobStatus);

      getjobslist = [];
      getjobslist = data;
      AppConstant.toastMsg(
          msg: "Job Status Updated Successfully",
          backgroundColor: AppColor.green);
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteJob({required String jobId, required int index}) async {
    isLoading = true;
    notifyListeners();
    try {
      bool res = await JobServices.deleteJob(jobId: jobId);
      if (res == true) {
        AppConstant.toastMsg(
            msg: "Job Status Deleted Successfully",
            backgroundColor: AppColor.green);
        getjobslist.removeAt(index);
      }
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> completeJobStatus(
      {required String jobId,
      required String traderId,
      required String endPoints,
      required String status,
      required String jobEndPoint,
      required String jobStatus,
      required BuildContext ctx}) async {
    String jId = jobId;
    String tId = traderId;
    isLoading = true;
    notifyListeners();
    try {
      await JobServices.customerUpdateJobStatus(
          endPoints: endPoints, jobId: jobId);
      print("completed");

      final data =
          await JobServices.getJob(endpoint: jobEndPoint, jobStatus: jobStatus);
      print("getjob");
      print(tId);
      print(jId);

      getjobslist = [];
      getjobslist = data;
      // Navigator.push(
      //     ctx,
      //     PageTransition(
      //         type: PageTransitionType.fade,
      //         child: CustomerReviewScreen(
      //           jobId: jId,
      //           traderId: tId,
      //         )));
      AppConstant.toastMsg(
          msg: "Job Status Updated Successfully",
          backgroundColor: AppColor.green);
      print("finish");
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> callJobRefresh(
      {required String endPoints, required String status}) async {
    print("refresh star....");
    final data =
        await JobServices.getJob(endpoint: endPoints, jobStatus: status);
    if (data.isNotEmpty) {
      getjobslist = [];
      getjobslist = data;
      print("refresh comp....");
      print(getjobslist.length);
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> sendQuoteReq({
    required RequestJobQuoteModel request,
  }) async {
    print(request.quotePrice.toString());
    print(request.quoteReason.toString());
    print(request.jobId.toString());
    print(request.userId.toString());
    print(request.userType.toString());
    print(request.traderId.toString());
    print(request.name.toString());
    sendingReq = true;
    notifyListeners();
    try {
      await JobServices.requestJobQuote(request: request);
    } catch (e) {
      print(e.toString());
      AppConstant.toastMsg(msg: e.toString(), backgroundColor: AppColor.red);
    }
    sendingReq = false;
    notifyListeners();
  }
}
