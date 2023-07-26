class DiyHelpPostReplyModel {
  int? diyHelpId;
  int? diyHelpCommentId;
  int? userId;
  String? userType;
  String? diyHelpComment;

  DiyHelpPostReplyModel(
      {this.diyHelpId,
      this.diyHelpCommentId,
      this.userId,
      this.userType,
      this.diyHelpComment});

  DiyHelpPostReplyModel.fromJson(Map<String, dynamic> json) {
    diyHelpId = json['diy_help_id'];
    diyHelpCommentId = json['diy_help_comment_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    diyHelpComment = json['diy_help_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['diy_help_id'] = diyHelpId;
    data['diy_help_comment_id'] = diyHelpCommentId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['diy_help_comment'] = diyHelpComment;
    return data;
  }
}
