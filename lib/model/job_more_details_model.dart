class JobMoreDetailsModel {
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
  List<Quotes>? quotes;
  List<String>? jobimages;

  JobMoreDetailsModel(
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
      this.quotes,
      this.jobimages});

  JobMoreDetailsModel.fromJson(Map<String, dynamic> json) {
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
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    jobimages = json['jobimages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (quotes != null) {
      data['quotes'] = quotes!.map((v) => v.toJson()).toList();
    }
    data['jobimages'] = jobimages;
    return data;
  }
}

class Quotes {
  int? id;
  int? jobId;
  int? traderId;
  int? customerId;
  String? quoteDetails;
  String? status;
  int? detailRequest;
  String? detailReqDetails;
  String? detailReqDetailsReply;
  int? seekQuote;
  String? name;
  bool? isExpanded;
  int? giveQuote;

  String? quotedPrice;
  String? quoteReason;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  List<Details>? details;

  Quotes(
      {this.id,
      this.name,
      this.jobId,
      this.isExpanded,
      this.traderId,
      this.customerId,
      this.quoteDetails,
      this.status,
      this.detailRequest,
      this.detailReqDetails,
      this.detailReqDetailsReply,
      this.seekQuote,
      this.giveQuote,
      this.quotedPrice,
      this.quoteReason,
      this.createdAt,
      this.updatedAt,
      this.profilePic,
      this.details});
  static List<Quotes> snapshot(List snapshot) {
    return snapshot.map((snap) => Quotes.fromJson(snap)).toList();
  }

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    traderId = json['trader_id'];
    customerId = json['customer_id'];
    quoteDetails = json['quote_details'];
    status = json['status'];
    name = json['name'];
    detailRequest = json['detail_request'];
    detailReqDetails = json['detail_req_details'];
    detailReqDetailsReply = json['detail_req_details_reply'];
    seekQuote = json['seek_quote'];
    giveQuote = json['give_quote'];
    isExpanded = false;
    quotedPrice = json['quoted_price'];
    quoteReason = json['quote_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['job_id'] = jobId;
    data['trader_id'] = traderId;
    data['customer_id'] = customerId;
    data['quote_details'] = quoteDetails;
    data['status'] = status;
    data['detail_request'] = detailRequest;
    data['detail_req_details'] = detailReqDetails;
    data['detail_req_details_reply'] = detailReqDetailsReply;
    data['seek_quote'] = seekQuote;
    data['give_quote'] = giveQuote;
    data['quoted_price'] = quotedPrice;
    data['quote_reason'] = quoteReason;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_pic'] = profilePic;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? jobId;
  int? jobQuoteId;
  int? jobQuoteDetailsId;
  String? userType;
  int? userId;
  String? details;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;

  Details(
      {this.id,
      this.jobId,
      this.jobQuoteId,
      this.jobQuoteDetailsId,
      this.userType,
      this.userId,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic});
  static List<Details> snapshot(List snapshot) {
    return snapshot.map((snap) => Details.fromJson(snap)).toList();
  }

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobQuoteId = json['job_quote_id'];
    jobQuoteDetailsId = json['job_quote_details_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['job_id'] = jobId;
    data['job_quote_id'] = jobQuoteId;
    data['job_quote_details_id'] = jobQuoteDetailsId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['details'] = details;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    return data;
  }
}
