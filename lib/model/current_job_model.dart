class CurrentJobModel {
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
  List<String>? jobimages;

  CurrentJobModel(
      {this.id,
      this.userType,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.title,
      this.description,
      this.budget,
      this.jobCompletion,
      this.status,
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

  CurrentJobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    description = json['description'];
    budget = json['budget'];
    jobCompletion = json['job_completion'];
    status = json['status'];
    jobStatus = json['job_status'];
    jobLocation = json['job_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    materialPurchased = json['material_purchased'];
    jobViews = json['job_views'];
    quoteProvided = json['quote_provided'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobimages = json['jobimages'].cast<String>();
  }
}
