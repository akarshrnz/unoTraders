class BlockUnBlockTraderModel {
  int? userId;
  String? userType;
  int? traderId;
  int? status;

  BlockUnBlockTraderModel(
      {this.userId, this.userType, this.traderId, this.status});

  BlockUnBlockTraderModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    traderId = json['trader_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['trader_id'] = traderId;
    data['status'] = status;
    return data;
  }
}
