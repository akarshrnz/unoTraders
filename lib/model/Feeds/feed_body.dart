class FeedsBodyModel {
  int? traderId;
  int? userId;
  String? userType;

  FeedsBodyModel({this.traderId, this.userId, this.userType});

  FeedsBodyModel.fromJson(Map<String, dynamic> json) {
    traderId = json['traderId'];
    userId = json['userId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traderId'] = traderId;
    data['userId'] = userId;
    data['userType'] = userType;
    return data;
  }
}
