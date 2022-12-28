import 'package:flutter/cupertino.dart';

class GetAcceptRejectModel with ChangeNotifier {
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
  String? jobId;
  String? traderId;
  String? customerId;
  String? quoteDetails;
  String? detailRequest;
  String? detailReqDetails;
  String? detailReqDetailsReply;
  String? seekQuote;
  String? giveQuote;
  String? quotedPrice;
  String? quoteReason;
  List<String>? jobimages;

  GetAcceptRejectModel(
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
      this.traderId,
      this.customerId,
      this.quoteDetails,
      this.detailRequest,
      this.detailReqDetails,
      this.detailReqDetailsReply,
      this.seekQuote,
      this.giveQuote,
      this.quotedPrice,
      this.quoteReason,
      this.jobimages});

  GetAcceptRejectModel.fromJson(Map<String, dynamic> json) {
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
    traderId = json['trader_id'];
    customerId = json['customer_id'];
    quoteDetails = json['quote_details'];
    detailRequest = json['detail_request'];
    detailReqDetails = json['detail_req_details'];
    detailReqDetailsReply = json['detail_req_details_reply'];
    seekQuote = json['seek_quote'];
    giveQuote = json['give_quote'];
    quotedPrice = json['quoted_price'];
    quoteReason = json['quote_reason'];
    jobimages = json['jobimages'].cast<String>();
  }

  static List<GetAcceptRejectModel> jobSnapshot(List snapshot) {
    return snapshot.map((snap) => GetAcceptRejectModel.fromJson(snap)).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user_type'] = this.userType;
  //   data['user_id'] = this.userId;
  //   data['category_id'] = this.categoryId;
  //   data['sub_category_id'] = this.subCategoryId;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['budget'] = this.budget;
  //   data['job_completion'] = this.jobCompletion;
  //   data['status'] = this.status;
  //   data['job_status'] = this.jobStatus;
  //   data['job_location'] = this.jobLocation;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = this.longitude;
  //   data['material_purchased'] = this.materialPurchased;
  //   data['job_views'] = this.jobViews;
  //   data['quote_provided'] = this.quoteProvided;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['job_id'] = this.jobId;
  //   data['trader_id'] = this.traderId;
  //   data['customer_id'] = this.customerId;
  //   data['quote_details'] = this.quoteDetails;
  //   data['detail_request'] = this.detailRequest;
  //   data['detail_req_details'] = this.detailReqDetails;
  //   data['detail_req_details_reply'] = this.detailReqDetailsReply;
  //   data['seek_quote'] = this.seekQuote;
  //   data['give_quote'] = this.giveQuote;
  //   data['quoted_price'] = this.quotedPrice;
  //   data['quote_reason'] = this.quoteReason;
  //   data['jobimages'] = this.jobimages;
  //   return data;
  // }
}
