class SendMessageModel {
  String? userId;
  String? userType;
  String? toUserId;
  String? toUserType;
  String? message;

  SendMessageModel(
      {this.userId,
      this.userType,
      this.toUserId,
      this.toUserType,
      this.message});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    toUserId = json['to_user_id'];
    toUserType = json['to_user_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['to_user_id'] = toUserId;
    data['to_user_type'] = toUserType;
    data['message'] = message;
    return data;
  }
}
