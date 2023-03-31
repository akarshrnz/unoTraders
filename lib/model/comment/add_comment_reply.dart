class AddCommentReplyModel {
  int? postId;
  int? traderId;
  int? userId;
  String? userType;
  String? postComment;
  int? postCommentId;

  AddCommentReplyModel(
      {this.postId,
      this.traderId,
      this.userId,
      this.userType,
      this.postComment,
      this.postCommentId});

  AddCommentReplyModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    traderId = json['trader_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    postComment = json['post_comment'];
    postCommentId = json['comment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['comment'] = postComment;
    data['comment_id'] = postCommentId;
    return data;
  }
}
