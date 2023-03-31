class TraderFollow {
  int? traderId;
  int? userId;
  String? userType;

  TraderFollow({this.traderId, this.userId, this.userType});

  TraderFollow.fromJson(Map<String, dynamic> json) {
    traderId = json['trader_id'];
    userId = json['user_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    return data;
  }
}
