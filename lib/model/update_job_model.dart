import 'dart:io';

class UpdateJobModel {
  int? id;
  String? name;
  int? phone;
  int? categoryId;
  int? subCategoryId;
  String? title;
  String? description;
  String? budget;
  String? jobCompletion;
  String? jobLocation;
  String? materialPurchased;
  String? longitude;
  String? latitude;
  List<File>? jobImages;

  UpdateJobModel(
      {this.id,
      this.name,
      this.phone,
      this.latitude,
      this.longitude,
      this.materialPurchased,
      this.categoryId,
      this.subCategoryId,
      this.title,
      this.description,
      this.budget,
      this.jobCompletion,
      this.jobLocation,
      this.jobImages});

  UpdateJobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    description = json['description'];
    budget = json['budget'];
    jobCompletion = json['job_completion'];
    jobLocation = json['job_location'];
    materialPurchased = json['material_purchased'];
    longitude = json['loc_longitude'];
    latitude = json['loc_latitude'];
    jobImages = json['job_images'].cast<String>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['phone'] = this.phone;
  //   data['category_id'] = this.categoryId;
  //   data['sub_category_id'] = this.subCategoryId;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['budget'] = this.budget;
  //   data['job_completion'] = this.jobCompletion;
  //   data['job_location'] = this.jobLocation;
  //   data['job_images'] = this.jobImages;
  //   return data;
  // }
}
