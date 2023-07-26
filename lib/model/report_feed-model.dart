class ReportFeedModel {
  int? traderPostId;
  int? userId;
  String? reason;
  String? userType;

  ReportFeedModel({this.traderPostId, this.userId, this.reason, this.userType});

  ReportFeedModel.fromJson(Map<String, dynamic> json) {
    traderPostId = json['trader_post_id'];
    userId = json['user_id'];
    reason = json['reason'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trader_post_id'] = traderPostId;
    data['user_id'] = userId;
    data['reason'] = reason;
    data['user_type'] = userType;
    return data;
  }
}
