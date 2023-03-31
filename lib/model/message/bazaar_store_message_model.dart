class BazaarStoreMessageModel {
  String? fromUserType;
  int? fromUserId;
  String? toUserType;
  int? toUserId;
  int? productId;

  BazaarStoreMessageModel(
      {this.fromUserType,
      this.fromUserId,
      this.toUserType,
      this.toUserId,
      this.productId});

  BazaarStoreMessageModel.fromJson(Map<String, dynamic> json) {
    fromUserType = json['from_user_type'];
    fromUserId = json['from_user_id'];
    toUserType = json['to_user_type'];
    toUserId = json['to_user_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_user_type'] = fromUserType;
    data['from_user_id'] = fromUserId;
    data['to_user_type'] = toUserType;
    data['to_user_id'] = toUserId;
    data['product_id'] = productId;
    return data;
  }
}
