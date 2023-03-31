class MessageListModel {
  int? userId;
  String? userType;
  String? profilePic;
  String? message;
  String? name;
  int? id;
  String? time;
  int? productId;
  String? productImage;

  static List<MessageListModel> snapshot(List snapshot) {
    return snapshot.map((snap) => MessageListModel.fromJson(snap)).toList();
  }

  MessageListModel(
      {this.userId,
      this.productId,
      this.productImage,
      this.userType,
      this.profilePic,
      this.id,
      this.message,
      this.time,
      this.name});

  MessageListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    id = json['id'];
    userType = json['user_type'];
    profilePic = json['profile_pic'];
    message = json['message'];
    productId = json['product_id'];
    productImage = json['product_img'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['user_type'] = userType;
    data['profile_pic'] = profilePic;
    data['message'] = message;
    data['time'] = time;
    return data;
  }
}
