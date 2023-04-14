class JobClarificationModel {
  int? id;
  String? userType;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  String? title;
  String? description;
  String? budget;
  String? jobCompletion;
  String? status;
  String? jobStatus;
  String? jobLocation;
  double? latitude;
  double? longitude;
  int? materialPurchased;
  int? jobViews;
  int? quoteProvided;
  String? createdAt;
  String? updatedAt;
  int? jobId;
  int? jobQuoteId;
  int? jobQuoteDetailsId;
  String? details;
  String? jobimage;

  JobClarificationModel(
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
      this.jobId,
      this.jobQuoteId,
      this.jobQuoteDetailsId,
      this.details,
      this.jobimage});

  static List<JobClarificationModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => JobClarificationModel.fromJson(snap))
        .toList();
  }

  JobClarificationModel.fromJson(Map<String, dynamic> json) {
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
    jobId = json['job_id'];
    jobQuoteId = json['job_quote_id'];
    jobQuoteDetailsId = json['job_quote_details_id'];
    details = json['details'];
    jobimage = json['jobimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['job_id'] = jobId;
    data['job_quote_id'] = jobQuoteId;
    data['job_quote_details_id'] = jobQuoteDetailsId;
    data['details'] = details;
    data['jobimage'] = jobimage;
    return data;
  }
}
