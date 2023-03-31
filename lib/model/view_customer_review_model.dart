class ViewCustomerReviewModel {
  int? id;
  int? traderId;
  int? userId;
  String? workCompleted;
  int? serviceId;
  String? serviceDate;
  String? review;
  int? reliability;
  int? tidiness;
  int? response;
  int? accuracy;
  int? pricing;
  int? overallExp;
  String? recommend;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? average;
  String? name;
  String? profilePic;
  List<Comment>? comment;

  ViewCustomerReviewModel(
      {this.id,
      this.traderId,
      this.userId,
      this.workCompleted,
      this.serviceId,
      this.serviceDate,
      this.review,
      this.reliability,
      this.tidiness,
      this.response,
      this.accuracy,
      this.pricing,
      this.overallExp,
      this.recommend,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.average,
      this.name,
      this.profilePic,
      this.comment});

  ViewCustomerReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderId = json['trader_id'];
    userId = json['user_id'];
    workCompleted = json['work_completed'];
    serviceId = json['service_id'];
    serviceDate = json['service_date'];
    review = json['review'];
    reliability = json['reliability'];
    tidiness = json['tidiness'];
    response = json['response'];
    accuracy = json['accuracy'];
    pricing = json['pricing'];
    overallExp = json['overall_exp'];
    recommend = json['recommend'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    average = json['average'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
  }
  static List<ViewCustomerReviewModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => ViewCustomerReviewModel.fromJson(snap))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['work_completed'] = workCompleted;
    data['service_id'] = serviceId;
    data['service_date'] = serviceDate;
    data['review'] = review;
    data['reliability'] = reliability;
    data['tidiness'] = tidiness;
    data['response'] = response;
    data['accuracy'] = accuracy;
    data['pricing'] = pricing;
    data['overall_exp'] = overallExp;
    data['recommend'] = recommend;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['average'] = average;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (comment != null) {
      data['comment'] = comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  int? reviewId;
  String? userType;
  int? userId;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  bool? isExapand;
  String? profilePic;
  List<Replies>? replies;

  Comment(
      {this.id,
      this.reviewId,
      this.userType,
      this.isExapand,
      this.userId,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic,
      this.replies});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewId = json['review_id'];
    userType = json['user_type'];
    isExapand = json['isExpand'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review_id'] = reviewId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  int? reviewId;
  String? userType;
  int? userId;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;

  Replies(
      {this.id,
      this.reviewId,
      this.userType,
      this.userId,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewId = json['review_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review_id'] = reviewId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    return data;
  }
}
