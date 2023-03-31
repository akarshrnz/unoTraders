import 'package:flutter/cupertino.dart';

class FetchJobModel with ChangeNotifier {
  int? id;
  String? userType;
  String? userId;
  String? categoryId;
  String? subCategoryId;
  String? title;
  String? description;
  String? budget;
  String? jobCompletion;
  String? status;
  String? jobStatus;
  String? jobLocation;
  String? latitude;
  String? longitude;
  String? materialPurchased;
  String? jobViews;
  String? quoteProvided;
  String? createdAt;
  String? updatedAt;
  int? isReviewed;
  int? traderId;
  List<String>? jobimages;

  FetchJobModel(
      {this.id,
      this.userType,
      this.userId,
      this.isReviewed,
      this.categoryId,
      this.subCategoryId,
      this.title,
      this.description,
      this.budget,
      this.jobCompletion,
      this.status,
      this.traderId,
      this.jobStatus,
      this.jobLocation,
      this.latitude,
      this.longitude,
      this.materialPurchased,
      this.jobViews,
      this.quoteProvided,
      this.createdAt,
      this.updatedAt,
      this.jobimages});

  FetchJobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'].toString();
    categoryId = json['category_id'].toString();
    subCategoryId = json['sub_category_id'].toString();
    title = json['title'];
    description = json['description'];
    budget = json['budget'];
    isReviewed = json['reviewed'];
    jobCompletion = json['job_completion'];
    status = json['status'] as String;
    jobStatus = json['job_status'];
    jobLocation = json['job_location'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    materialPurchased = "";
    // json['material_purchased'];
    jobViews = json['job_views'].toString();
    quoteProvided = json['quote_provided'].toString();
    createdAt = json['created_at'];
    traderId = json['trader_id'];
    updatedAt = json['updated_at'];
    jobimages = json['jobimages'].cast<String>() ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['title'] = title;
    data['description'] = description;
    data['budget'] = budget;
    data['job_completion'] = jobCompletion;
    data['status'] = status;
    data['job_status'] = jobStatus;
    data['job_location'] = jobLocation;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['material_purchased'] = materialPurchased;
    data['job_views'] = jobViews;
    data['quote_provided'] = quoteProvided;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['jobimages'] = jobimages;
    return data;
  }

  static List<FetchJobModel> jobSnapshot(List snapshot) {
    return snapshot.map((snap) => FetchJobModel.fromJson(snap)).toList();
  }
}
