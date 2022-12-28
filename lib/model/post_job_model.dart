import 'dart:io';

class PostJobModel {
  int? customerId;
  int? category;
  int? subCategory;
  String? jobTitle;
  String? jobDescription;
  String? budget;
  String? timeForCompletion;
  String? location;
  String? locationLatitude;
  String? locationLongitude;
  String? materialPurchased;
  List<File>? jobimages;
  String? jobStatus;

  PostJobModel(
      {this.customerId,
      this.category,
      this.subCategory,
      this.jobTitle,
      this.jobDescription,
      this.budget,
      this.timeForCompletion,
      this.location,
      this.locationLatitude,
      this.locationLongitude,
      this.materialPurchased,
      this.jobimages,
      this.jobStatus});

  PostJobModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    category = json['category'];
    subCategory = json['subCategory'];
    jobTitle = json['jobTitle'];
    jobDescription = json['jobDescription'];
    budget = json['budget'];
    timeForCompletion = json['timeForCompletion'];
    location = json['location'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
    materialPurchased = json['material_purchased'];
    jobimages = json['jobimages'];
    jobStatus = json['job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['jobTitle'] = jobTitle;
    data['jobDescription'] = jobDescription;
    data['budget'] = budget;
    data['timeForCompletion'] = timeForCompletion;
    data['location'] = location;
    data['locationLatitude'] = locationLatitude;
    data['locationLongitude'] = locationLongitude;
    data['material_purchased'] = materialPurchased;
    data['jobimages'] = jobimages;
    data['job_status'] = jobStatus;
    return data;
  }
}
