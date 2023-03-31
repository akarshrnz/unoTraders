class UrlProfileVisitModel {
  String? username;
  int? userId;
  String? userType;

  UrlProfileVisitModel({this.username, this.userId, this.userType});

  UrlProfileVisitModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['user_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['user_id'] = userId;
    data['user_type'] = userType;
    return data;
  }
}
