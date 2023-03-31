class AddReviewCommentModel {
  int? reviewId;
  int? traderId;
  int? userId;
  String? userType;
  String? comment;
  int? reviewCommentId;

  AddReviewCommentModel(
      {this.reviewId,
      this.traderId,
      this.userId,
      this.userType,
      this.comment,
      this.reviewCommentId});

  AddReviewCommentModel.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    traderId = json['trader_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    comment = json['comment'];
    reviewCommentId = json['review_comment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['comment'] = comment;
    data['review_comment_id'] = reviewCommentId;
    return data;
  }
}
