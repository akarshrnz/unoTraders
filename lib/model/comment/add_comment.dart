class AddCommentModel {
  int? postId;
  int? traderId;
  int? userId;
  String? userType;
  String? postComment;

  AddCommentModel(
      {this.postId,
      this.traderId,
      this.userId,
      this.userType,
      this.postComment});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    postId = json['trader_post_id'];
    traderId = json['trader_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    postComment = json['post_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['post_id'] = postId;
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['comment'] = postComment;
    return data;
  }
}
