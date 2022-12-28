class RemoveBazaarModel {
  String? userType;
  String? userId;
  String? productId;

  RemoveBazaarModel({this.userType, this.userId, this.productId});

  RemoveBazaarModel.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    userId = json['user_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['product_id'] = productId;
    return data;
  }
}
